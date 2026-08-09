import 'package:chatt/cubit/regsister_cubit.dart';
import 'package:chatt/cubit/state_cubit.dart';
import 'package:chatt/helper/showsnakebar.dart';
import 'package:chatt/view/login_view.dart';
import 'package:chatt/widgets/custom_buttom.dart';
import 'package:chatt/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static String id = 'register';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {}

          if (state is AuthError) {
            showSnakbar(context, state.message);
          }

          if (state is AuthSuccess) {
            showSnakbar(context, 'تم إنشاء الحساب بنجاح');

            Navigator.pushReplacementNamed(context, LoginView.id);
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);

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
                    child: Form(
                      key: formkey,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
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
                            "أنشئ حسابًا وابدأ المحادثة.",
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
                                  hintText: "الاسم",
                                  icon: Icons.person_outline,
                                  onChanged: (data) => name = data,
                                ),

                                const SizedBox(height: 18),

                                CustomFromTextField(
                                  hintText: "البريد الإلكتروني",
                                  icon: Icons.email_outlined,
                                  onChanged: (data) => email = data,
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

                                const SizedBox(height: 18),

                                CustomFromTextField(
                                  hintText: "تأكيد كلمة المرور",
                                  icon: Icons.lock_outline,
                                  obscureText: cubit.isConfirmPassword,
                                  suffixIcon: cubit.isConfirmPassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  onSuffixPressed: () {
                                    cubit.changeConfirmPasswordVisibility();
                                  },
                                  onChanged: (data) {
                                    confirmPassword = data;
                                  },
                                ),

                                const SizedBox(height: 28),

                                state is AuthLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : CustomButton(
                                        text: "إنشاء حساب",
                                        onTap: () {
                                          if (formkey.currentState!
                                              .validate()) {
                                            if (password != confirmPassword) {
                                              showSnakbar(
                                                context,
                                                "كلمتا المرور غير متطابقتين",
                                              );
                                              return;
                                            }

                                            cubit.register(
                                              name: name,
                                              email: email,
                                              password: password,
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
                                "لديك حساب بالفعل؟",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(.7),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, LoginView.id);
                                },
                                child: const Text(
                                  "تسجيل الدخول",
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
