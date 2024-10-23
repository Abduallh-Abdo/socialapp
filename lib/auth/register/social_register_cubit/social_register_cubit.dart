import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/auth/register/social_register_cubit/social_register_state.dart';
import 'package:socialapp/models/user_model/user_model.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  final GlobalKey<FormState> socialregisterFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SocialRegisterChangePasswordVisibilityState());
  }

  void userSocialRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      log(value.user!.uid);

      createUser(
        email: email,
        name: name,
        phone: phone,
        uid: value.user!.uid,
      );
    }).catchError((error) {
      log("Failed to create user: $error");
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uid,
  }) {
    UserModel userModel = UserModel(
      email: email,
      name: name,
      phone: phone,
      uid: uid,
      bio: 'write your bio  ...',
      coverImage: 
          'https://c4.wallpaperflare.com/wallpaper/164/772/9/blade-runner-2049-officer-k-hologram-bridge-wallpaper-preview.jpg',
      image:
          'https://c4.wallpaperflare.com/wallpaper/416/743/733/anime-demon-slayer-kimetsu-no-yaiba-sabito-demon-slayer-hd-wallpaper-preview.jpg',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(userModel.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
      emit(SocialRegisterSuccessState());
    }).catchError((error) {
      emit(
        SocialCreateUserErrorState(error.toString()),
      );
    });
  }
}
