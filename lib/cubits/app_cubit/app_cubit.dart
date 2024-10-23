import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:socialapp/cubits/app_cubit/app_state.dart';
import 'package:socialapp/helper/const.dart';
import 'package:socialapp/helper/shared_preference/shared_pref.dart';
import 'package:socialapp/helper/styles/icon_broken.dart';
import 'package:socialapp/models/user_model/user_model.dart';
import 'package:socialapp/views/chats/chats_screen.dart';
import 'package:socialapp/views/feeds/feeds_screen.dart';
import 'package:socialapp/views/new_post/post_screen.dart';
import 'package:socialapp/views/settings/settings_screen.dart';
import 'package:socialapp/views/users/users_screen.dart';


class AppCubit extends Cubit<AppStates> {
  bool isDark = false;
  bool iEdit = false;

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomNavBarItem = [
    const BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Home,
      ),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Chat,
      ),
      label: 'Chats',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Paper_Upload,
      ),
      label: 'Post',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Location,
      ),
      label: 'Users',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Setting,
      ),
      label: 'Settings',
    ),
  ];

  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const NewPostScreen(),
    const UsersScreen(),
    const SettingScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNavBar(int index) {
    if (index == 2) {
      emit(AppNewPostBottomNavState());
    } else {
      currentIndex = index;
      emit(AppChangeBottomNavState());
    }
  }

final ImagePicker imagePicker = ImagePicker();
  File? profileImage; 
  XFile? coverImage; //has the Cover image path
  XFile? im;
  File? crack;
// Pick an image from the gallery
  Future<void> pickProfileImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path); // Convert XFile to File
      log('Picked profile image path: ${profileImage!.path}');
      emit(AppPickedProfileImageSuccessState()); // Emit success state
    } else {
      log('No image selected');
      emit(AppPickedProfileImageErrorState()); // Emit error state
    }
  }

  Future<void> pickProfileIm() async {
    im = await imagePicker.pickImage(source: ImageSource.camera);
    if (im != null) {
      crack = File(im!.path);
      log('File ${crack!.path}');
      emit(AppPickedProfileImageSuccessState());
    } else {
      emit(AppPickedProfileImageErrorState());
    }
  }

  Future<void> pickCoverImage() async {
    // Always try to pick the image
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      coverImage = XFile(image.path);
      emit(AppPickedProfileImageSuccessState());
    } else {
      emit(AppPickedCoverImageErrorState());
    }
  }
// Upload profile image to Firebase Storage
  String profileImageUrl = '';
  void uploadProfileImage() {
    if (profileImage != null) {
      log('Uploading image: ${profileImage!.path}');

      // Reference for the file in Firebase Storage
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(profileImage!.path).pathSegments.last}');

      // Upload the image file to Firebase Storage
      storageRef.putFile(profileImage!).then((TaskSnapshot snapshot) {
        log('Image uploaded, getting download URL...');

        // Get the download URL for the uploaded image
        snapshot.ref.getDownloadURL().then((downloadUrl) {
          profileImageUrl = downloadUrl;
          log('Profile image uploaded successfully: $downloadUrl');
          emit(AppUploadProfileImageSuccessState()); // Emit success state
        }).catchError((error) {
          log('Error getting download URL: $error');
          emit(AppUploadProfileImageErrorState()); // Emit error state
        });
      }).catchError((error) {
        log('Error uploading profile image: $error');
        emit(AppUploadProfileImageErrorState()); // Emit error state
      });
    } else {
      log('No profile image to upload');
      emit(AppUploadProfileImageErrorState()); // Emit error state if no image
    }
  }

  String profileImUrl = '';
  void uploadProfileIm() async {
    emit(AppUploadProfileImageLoadingState());
    log('iam here');
    try {
      log('iam 2');
      if (im != null) {
        log('iam 3');
        String imageName = basename(
          im!.path,
        );
        log('iam 4');
        Reference reference = FirebaseStorage.instance.ref(imageName);
        log('iam 5');
        await reference.putFile(crack!);
        log('iam put');
        profileImUrl = await reference.getDownloadURL();
        log('iam get');
        // .then((value) {
        // value.ref.getDownloadURL();
        // log('iam 6');
        // emit(AppUploadProfileImageSuccessState());
        // .then((downloadUrl) {
        //   profileImUrl = downloadUrl;
        //   log('Profile im uploaded: $downloadUrl'); // Log the download URL for debugging
        //   emit(AppUploadProfileImageSuccessState());
        // }).catchError((error) {
        //   log('Failed to get profile im URL: $error'); // Log the error for debugging
        //   emit(AppUploadProfileImageErrorState());
        // });
        // });
        log('iam 7');
      }
    } catch (e) {
      log('iam 8');
      log(e.toString());
    }
  }

  String coverImageUrl = '';
  void uploadCoverImage() {
    if (coverImage != null) {
      FirebaseStorage.instance
          .ref()
          .child(
              'users/${Uri.file(coverImage!.path).pathSegments.last}') // Added `.pathSegments.last`
          .putFile(File(coverImage!.path))
          .then((value) {
        value.ref.getDownloadURL().then((downloadUrl) {
          coverImageUrl = downloadUrl;
          log('Cover image uploaded: $downloadUrl');
          emit(AppUploadCoverImageSuccessState());
        }).catchError((error) {
          log('Failed to get cover image URL: $error');
          emit(AppUploadCoverImageErrorState());
        });
      }).catchError((error) {
        log('Failed to upload cover image: $error');
        emit(AppUploadCoverImageErrorState());
      });
    }
  }

  void changeAppMode({dynamic fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
    } else {
      isDark = !isDark;
      CacheHelper.saveData(
        key: 'isDark',
        value: isDark,
      ).then((value) {
        emit(AppChanegeModeState());
      });
    }
    emit(AppChanegeModeState());
  }

  UserModel? userModel;
  void getUserData() {
    emit(AppLoadingUserDataState());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      log(value.data().toString());
      userModel = UserModel.fromJson(value.data()!);
      emit(AppSuccessUserDataState());
    }).catchError((error) {
      log(error.toString());
      emit(AppErrorUserDataState(error.toString()));
    });
  }
}
