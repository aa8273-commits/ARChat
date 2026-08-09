import 'package:chatt/cubit/state_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<AuthState> {
  LoginCubit() : super(AuthInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    emit(ChangePasswordVisibilityState());
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final user = credential.user;

      String? token = await FirebaseMessaging.instance.getToken();

      if (user != null && token != null) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .update({"token": token});
      }

      emit(
        AuthSuccess(name: user?.displayName ?? '', email: user?.email ?? ''),
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          emit(AuthError('لا يوجد حساب بهذا البريد الإلكتروني'));
          break;

        case 'wrong-password':
          emit(AuthError('كلمة المرور غير صحيحة'));
          break;

        case 'invalid-email':
          emit(AuthError('البريد الإلكتروني غير صالح'));
          break;

        case 'invalid-credential':
          emit(AuthError('البريد الإلكتروني أو كلمة المرور غير صحيحة'));
          break;

        case 'network-request-failed':
          emit(AuthError('تحقق من اتصالك بالإنترنت'));
          break;

        case 'too-many-requests':
          emit(AuthError('تم إجراء محاولات كثيرة، حاول مرة أخرى لاحقًا'));
          break;

        default:
          emit(AuthError('فشل تسجيل الدخول'));
      }
    } catch (e) {
      emit(AuthError('حدث خطأ غير متوقع، حاول مرة أخرى'));
    }
  }
}
