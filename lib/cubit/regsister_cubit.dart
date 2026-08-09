import 'package:chatt/cubit/state_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<AuthState> {
  RegisterCubit() : super(AuthInitial());

  bool isPassword = true;
  bool isConfirmPassword = true;

  static RegisterCubit get(context) => BlocProvider.of(context);

  void changePasswordVisibility() {
    isPassword = !isPassword;
    emit(ChangePasswordVisibilityState());
  }

  void changeConfirmPasswordVisibility() {
    isConfirmPassword = !isConfirmPassword;
    emit(ChangePasswordVisibilityState());
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      if (!email.endsWith("@gmail.com")) {
        emit(AuthError("يجب استخدام بريد إلكتروني من Gmail فقط"));
        return;
      }

      if (password.length < 8) {
        emit(AuthError("يجب ألا تقل كلمة المرور عن 8 أحرف"));
        return;
      }

      if (!RegExp(r'^(?=.*[A-Z])(?=.*[0-9])').hasMatch(password)) {
        emit(
          AuthError(
            "يجب أن تحتوي كلمة المرور على حرف كبير ورقم واحد على الأقل",
          ),
        );
        return;
      }

      final auth = FirebaseAuth.instance;

      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await userCredential.user!.updateDisplayName(name);

      final uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection("users").doc(uid).set({
        'uid': uid,
        'name': name,
        'nameLower': name.toLowerCase(),
        'email': email.trim(),
        'image': '',
        'bio': '',
        'isOnline': false,
        'lastSeen': FieldValue.serverTimestamp(),
      });
      await userCredential.user!.reload();

      final currentUser = FirebaseAuth.instance.currentUser;

      emit(
        AuthSuccess(
          name: currentUser?.displayName ?? '',
          email: currentUser?.email ?? '',
        ),
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'isOnline': false, 'lastSeen': Timestamp.now()});
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          emit(AuthError("هذا البريد الإلكتروني مستخدم بالفعل"));
          break;

        case 'invalid-email':
          emit(AuthError("البريد الإلكتروني غير صالح"));
          break;

        case 'weak-password':
          emit(AuthError("كلمة المرور ضعيفة"));
          break;

        case 'network-request-failed':
          emit(AuthError("تحقق من اتصالك بالإنترنت"));
          break;

        case 'too-many-requests':
          emit(AuthError("تم إجراء محاولات كثيرة، حاول مرة أخرى لاحقًا"));
          break;

        default:
          emit(AuthError("فشل إنشاء الحساب"));
      }
    } catch (_) {
      emit(AuthError("حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى"));
    }
  }
}
