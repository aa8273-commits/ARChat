import 'package:chatt/cubit/login_cubit.dart';
import 'package:chatt/cubit/state_cubit.dart';
import 'package:chatt/helper/showsnakebar.dart';
import 'package:chatt/view/home_view.dart';
import 'package:chatt/view/register_view.dart';
import 'package:chatt/widgets/custom_buttom.dart';
import 'package:chatt/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
  LoginView({super.key});

  static String id = 'loginpage';

  String? email;
  String? password;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            showSnakbar(context, state.message);
          }

          if (state is AuthSuccess) {
            showSnakbar(context, "تم تسجيل الدخول بنجاح");

            Navigator.pushReplacementNamed(context, HomeView.id);
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);

          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff08131F),
                    Color(0xff0F2742),
                    Color(0xff163B5F),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -120,
                    left: -100,
                    child: Container(
                      width: 260,
                      height: 260,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.05),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: -140,
                    right: -120,
                    child: Container(
                      width: 320,
                      height: 320,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.03),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Form(
                        key: formkey,
                        child: ListView(
                          children: [
                            const SizedBox(height: 20),

                            Center(
                              child: Image.asset(
                                "assets/images/logo.png",
                                width: 140,
                              ),
                            ),

                            const SizedBox(height: 20),

                            const Text(
                              "AR Chat",

                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Pacifico",
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              "سجل دخولك للمتابعة.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withOpacity(.7),
                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(height: 40),

                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.06),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: Colors.white.withOpacity(.12),
                                ),
                              ),
                              child: Column(
                                children: [
                                  CustomFromTextField(
                                    hintText: "البريد الإلكتروني",
                                    keyboardType: TextInputType.emailAddress,
                                    icon: Icons.email_outlined,
                                    onChanged: (data) {
                                      email = data;
                                    },
                                  ),

                                  const SizedBox(height: 18),

                                  CustomFromTextField(
                                    hintText: "كلمة المرور",
                                    icon: Icons.lock_outline,
                                    obscureText: cubit.isPassword,
                                    suffixIcon: cubit.isPassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    onSuffixPressed: () {
                                      cubit.changePasswordVisibility();
                                    },
                                    onChanged: (data) {
                                      password = data;
                                    },
                                  ),

                                  const SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () async {
                                        if (email != null &&
                                            email!.isNotEmpty) {
                                          await FirebaseAuth.instance
                                              .sendPasswordResetEmail(
                                                email: email!,
                                              );

                                          showSnakbar(
                                            context,
                                            "تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني",
                                          );
                                        } else {
                                          showSnakbar(
                                            context,
                                            "يرجى إدخال البريد الإلكتروني أولًا",
                                          );
                                        }
                                      },
                                      child: const Text(
                                        "نسيت كلمة المرور؟",
                                        style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 15),

                                  state is AuthLoading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : CustomButton(
                                          text: "تسجيل الدخول",
                                          onTap: () {
                                            if (formkey.currentState!
                                                .validate()) {
                                              cubit.login(
                                                email: email!,
                                                password: password!,
                                              );
                                            } else {
                                              showSnakbar(
                                                context,
                                                "يرجى ملء جميع الحقول",
                                              );
                                            }
                                          },
                                        ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 25),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "ليس لديك حساب؟",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(.7),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      RegisterView.id,
                                    );
                                  },
                                  child: const Text(
                                    "إنشاء حساب",
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
