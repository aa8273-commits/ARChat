import 'dart:io';

import 'package:chatt/view/chat_view.dart';
import 'package:chatt/widgets/create_group_header.dart';
import 'package:chatt/widgets/group_user_tile.dart';
import 'package:chatt/widgets/create_group_button.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateGroupView extends StatefulWidget {
  const CreateGroupView({super.key});

  static const String id = '/create-group';

  @override
  State<CreateGroupView> createState() => _CreateGroupViewState();
}

class _CreateGroupViewState extends State<CreateGroupView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _nameController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  final Color background = const Color(0xff08131F);

  final Color card = const Color(0xff0F2742);

  final Color orange = Colors.orangeAccent;

  List<Map<String, dynamic>> users = [];

  final Set<String> selectedUsers = {};

  File? groupImage;

  bool isLoadingUsers = true;

  bool isCreatingGroup = false;

  @override
  void initState() {
    super.initState();

    _loadUsers();
  }

  Future<void> _loadUsers() async {
    try {
      final currentUid = _auth.currentUser?.uid;

      if (currentUid == null) {
        return;
      }

      final snapshot = await _firestore.collection('users').get();

      final loadedUsers = snapshot.docs
          .where((doc) => doc.id != currentUid)
          .map((doc) {
            final data = doc.data();

            return {
              'uid': data['uid'] ?? doc.id,
              'name': data['name'] ?? 'Unknown',
              'image': data['image'] ?? '',
              'email': data['email'] ?? '',
            };
          })
          .toList();

      if (!mounted) return;

      setState(() {
        users = loadedUsers;
        isLoadingUsers = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoadingUsers = false;
      });

      _showMessage('حدث خطأ أثناء تحميل المستخدمين', isError: true);
    }
  }

  Future<void> _pickGroupImage() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile == null) return;

      setState(() {
        groupImage = File(pickedFile.path);
      });
    } catch (e) {
      _showMessage('حدث خطأ أثناء اختيار الصورة', isError: true);
    }
  }

  Future<void> _createGroup() async {
    final currentUser = _auth.currentUser;

    if (currentUser == null) {
      _showMessage('يجب تسجيل الدخول أولاً', isError: true);
      return;
    }

    final groupName = _nameController.text.trim();

    if (groupName.isEmpty) {
      _showMessage('اكتب اسم الجروب', isError: true);
      return;
    }

    if (selectedUsers.isEmpty) {
      _showMessage('اختر عضوًا واحدًا على الأقل', isError: true);
      return;
    }

    try {
      setState(() {
        isCreatingGroup = true;
      });

      final Map<String, bool> members = {currentUser.uid: true};

      for (final uid in selectedUsers) {
        members[uid] = true;
      }

      final Map<String, bool> admins = {currentUser.uid: true};

      final conversationRef = _firestore.collection('conversations').doc();

      await conversationRef.set({
        'type': 'group',
        'name': groupName,
        'image': '',
        'createdBy': currentUser.uid,
        'createdAt': FieldValue.serverTimestamp(),
        'members': members,
        'admins': admins,
        'lastMessage': '',
        'lastMessageId': '',
        'lastSenderId': '',
        'lastTime': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      setState(() {
        isCreatingGroup = false;
      });

      _showMessage('تم إنشاء الجروب بنجاح');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ChatView(
            conversationId: conversationRef.id,
            receiverId: '',
            receiverName: groupName,
            receiverImage: '',
            isGroup: true,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isCreatingGroup = false;
      });

      _showMessage('حدث خطأ أثناء إنشاء الجروب', isError: true);
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.redAccent : orange,
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,

        title: const Text(
          'إنشاء جروب',
          style: TextStyle(
            color: Colors.orangeAccent,
            fontWeight: FontWeight.bold,
          ),
        ),

        iconTheme: const IconThemeData(color: Colors.orangeAccent),
      ),

      body: isLoadingUsers
          ? const Center(
              child: CircularProgressIndicator(color: Colors.orangeAccent),
            )
          : Column(
              children: [
                CreateGroupHeader(
                  groupImage: groupImage,
                  groupNameController: _nameController,
                  cardColor: card,
                  onPickImage: _pickGroupImage,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),

                  child: Align(
                    alignment: Alignment.centerRight,

                    child: Text(
                      'الأعضاء المختارون: ${selectedUsers.length}',
                      style: const TextStyle(
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Expanded(
                  child: users.isEmpty
                      ? const Center(
                          child: Text(
                            'لا يوجد مستخدمون',
                            style: TextStyle(color: Colors.white70),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 18),

                          itemCount: users.length,

                          itemBuilder: (context, index) {
                            final user = users[index];

                            final uid = user['uid'];

                            return GroupUserTile(
                              user: user,
                              isSelected: selectedUsers.contains(uid),
                              cardColor: card,
                              onChanged: (value) {
                                setState(() {
                                  if (value == true) {
                                    selectedUsers.add(uid);
                                  } else {
                                    selectedUsers.remove(uid);
                                  }
                                });
                              },
                            );
                          },
                        ),
                ),

                CreateGroupButton(
                  isLoading: isCreatingGroup,
                  onPressed: _createGroup,
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();

    super.dispose();
  }
}
