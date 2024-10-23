import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/auth/login/social_login_cubit/social_login_cubit.dart';
import 'package:socialapp/auth/login/social_login_cubit/social_login_state.dart';
import 'package:socialapp/auth/register/social_register_screen.dart';
import 'package:socialapp/components/components.dart';
import 'package:socialapp/helper/shared_preference/shared_pref.dart';
import 'package:socialapp/views/social_layout.dart';

class SocialLoginScreen extends StatelessWidget {
  const SocialLoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {

          if (state is SocialLoginErrorState) {
            defaultToast(msg: state.error, state: ToastStates.error);
          }
                    if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(
              key: 'uid',
              value: state.uid,
            ).then((value) {
              navigateAndFinish(
                context: context,
                widget: const SocialLayout(),
              );
            });
          }
        },
        builder: (context, state) {
          SocialLoginCubit socialloginCubit = SocialLoginCubit.get(context);
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: socialloginCubit.socialloginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        defuaLtFormField(
                          controller: socialloginCubit.emailController,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            // Additional email validation (optional)
                            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          labelText: 'Email',
                          type: TextInputType.emailAddress,
                          prefix: Icons.email,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defuaLtFormField(
                          controller: socialloginCubit.passController,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          onSubmit: (p0) {
                            if (socialloginCubit
                                .socialloginFormKey.currentState!
                                .validate()) {
                              socialloginCubit.userSocialLogin(
                                email: socialloginCubit.emailController.text,
                                password: socialloginCubit.passController.text,
                              );
                            }
                          },
                          labelText: 'Password',
                          type: TextInputType.visiblePassword,
                          suffix: socialloginCubit.suffix,
                          prefix: Icons.lock,
                          obscureText: socialloginCubit.isPassword,
                          suffixPressed: () {
                            socialloginCubit.changePasswordVisibility();
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          builder: (context) => defaultButton(
                            onPressed: () {
                              if (socialloginCubit
                                  .socialloginFormKey.currentState!
                                  .validate()) {
                                socialloginCubit.userSocialLogin(
                                  email: socialloginCubit.emailController.text,
                                  password:
                                      socialloginCubit.passController.text,
                                );
                              }
                            },
                            text: 'login',
                            isUppercase: true,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            defaultTextButton(
                              text: 'Register now',
                              onPressed: () {
                                navigateTo(
                                  context: context,
                                  widget: const SocialRegisterScreen(),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
