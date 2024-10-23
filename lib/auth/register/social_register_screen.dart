import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/auth/login/social_login_screen.dart';
import 'package:socialapp/auth/register/social_register_cubit/social_register_cubit.dart';
import 'package:socialapp/auth/register/social_register_cubit/social_register_state.dart';
import 'package:socialapp/components/components.dart';
import 'package:socialapp/views/social_layout.dart';

class SocialRegisterScreen extends StatelessWidget {
  const SocialRegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            navigateAndFinish(
              context: context,
              widget: const SocialLayout(),
            );
          }

          if (state is SocialCreateUserErrorState) {
            defaultToast(
              msg: state.error,
              state: ToastStates.error,
            );
          }
        },
        builder: (context, state) {
          SocialRegisterCubit socialRegisterCubit =
              SocialRegisterCubit.get(context);
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: socialRegisterCubit.socialregisterFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        defuaLtFormField(
                          controller: socialRegisterCubit.nameController,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }

                            return null;
                          },
                          labelText: 'Name',
                          type: TextInputType.name,
                          prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defuaLtFormField(
                          controller: socialRegisterCubit.emailController,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            // Additional email validation (optional)
                            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Please enter a valid email address';
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
                          controller: socialRegisterCubit.phoneController,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                          labelText: 'Phone',
                          type: TextInputType.phone,
                          prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defuaLtFormField(
                          controller: socialRegisterCubit.passController,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          onSubmit: (p0) {
                            if (socialRegisterCubit
                                .socialregisterFormKey.currentState!
                                .validate()) {
                              // SocialregisterCubit.userSocialRegister(
                              //   name: SocialregisterCubit.nameController.text,
                              //   email: SocialregisterCubit.emailController.text,
                              //   phone: SocialregisterCubit.phoneController.text,
                              //   password:
                              //       SocialregisterCubit.passController.text,
                              // );
                            }
                          },
                          labelText: 'Password',
                          type: TextInputType.visiblePassword,
                          suffix: socialRegisterCubit.suffix,
                          prefix: Icons.lock,
                          obscureText: socialRegisterCubit.isPassword,
                          suffixPressed: () {
                            socialRegisterCubit.changePasswordVisibility();
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          builder: (context) => defaultButton(
                            onPressed: () {
                              if (socialRegisterCubit
                                  .socialregisterFormKey.currentState!
                                  .validate()) {
                                socialRegisterCubit.userSocialRegister(
                                  name: socialRegisterCubit.nameController.text,
                                  email:
                                      socialRegisterCubit.emailController.text,
                                  phone:
                                      socialRegisterCubit.phoneController.text,
                                  password:
                                      socialRegisterCubit.passController.text,
                                );
                              }
                            },
                            text: 'Register',
                            isUppercase: true,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Already have an account?',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            defaultTextButton(
                              
                              text: 'Login now',
                              onPressed: () {
                                navigateTo(
                                  context: context,
                                  widget: const SocialLoginScreen(),
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
