import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/privacy_cubit.dart';
import '../cubit/privacy_state.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({super.key});

  static const id = "/privacy";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PrivacyCubit()..loadPrivacy(),

      child: BlocBuilder<PrivacyCubit, PrivacyState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xff08131F),

            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: const Color(0xff08131F),
              title: const Text(
                "الخصوصية",
                style: TextStyle(color: Colors.white),
              ),
            ),

            body: ListView(
              padding: const EdgeInsets.all(12),

              children: [
                privacyTile(
                  context,
                  title: "آخر ظهور",
                  value: state.lastSeen,
                  onTap: () {
                    showPrivacyDialog(
                      context,
                      "آخر ظهور",
                      ["Everyone", "My Contacts", "Nobody"],
                      (v) {
                        context.read<PrivacyCubit>().changeLastSeen(v);
                      },
                    );
                  },
                ),

                privacyTile(
                  context,
                  title: "الصورة الشخصية",
                  value: state.profilePhoto,

                  onTap: () {
                    showPrivacyDialog(
                      context,
                      "الصورة الشخصية",
                      ["Everyone", "My Contacts", "Nobody"],
                      (v) {
                        context.read<PrivacyCubit>().changeProfilePhoto(v);
                      },
                    );
                  },
                ),

                privacyTile(
                  context,
                  title: "إضافة للمجموعات",
                  value: state.addGroups,

                  onTap: () {
                    showPrivacyDialog(
                      context,
                      "إضافة للمجموعات",
                      ["Everyone", "My Contacts", "Nobody"],
                      (v) {
                        context.read<PrivacyCubit>().changeAddGroups(v);
                      },
                    );
                  },
                ),

                const SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff0F2742),
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: const ListTile(
                    leading: Icon(Icons.block, color: Colors.redAccent),

                    title: Text(
                      "المستخدمون المحظورون",
                      style: TextStyle(color: Colors.white),
                    ),

                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white54,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget privacyTile(
    BuildContext context, {
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        color: const Color(0xff0F2742),
        borderRadius: BorderRadius.circular(15),
      ),

      child: ListTile(
        title: Text(title, style: const TextStyle(color: Colors.white)),

        subtitle: Text(value, style: const TextStyle(color: Colors.white54)),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white54,
          size: 16,
        ),

        onTap: onTap,
      ),
    );
  }

  void showPrivacyDialog(
    BuildContext context,
    String title,
    List<String> options,
    Function(String) onSelect,
  ) {
    showDialog(
      context: context,

      builder: (_) {
        return AlertDialog(
          backgroundColor: const Color(0xff0F2742),

          title: Text(title, style: const TextStyle(color: Colors.white)),

          content: Column(
            mainAxisSize: MainAxisSize.min,

            children: options.map((e) {
              return RadioListTile(
                value: e,
                groupValue: null,
                title: Text(e, style: const TextStyle(color: Colors.white)),

                onChanged: (_) {
                  onSelect(e);

                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
