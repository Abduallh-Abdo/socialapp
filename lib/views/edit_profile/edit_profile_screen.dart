import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/components/components.dart';
import 'package:socialapp/cubits/app_cubit/app_cubit.dart';
import 'package:socialapp/cubits/app_cubit/app_state.dart';
import 'package:socialapp/helper/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);

        var userModel = appCubit.userModel;
        var profileImage = appCubit.profileImage;
        var carckImage = appCubit.im;
        var coverImage = appCubit.coverImage;
        appCubit.nameController.text = userModel!.name!;
        appCubit.bioController.text = userModel.bio!;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                IconBroken.Arrow___Left_2,
              ),
            ),
            actions: [
              defaultTextButton(
                text: 'Update',
                fontSize: 18,
                color: Colors.blue,
                onPressed: () {
                  if (appCubit.profileImage != null) {
                    appCubit.uploadProfileImage();
                    // appCubit.uploadProfileIm;
                  }
                  // if (appCubit.coverImage != null) {
                  //   appCubit.uploadCoverImage();
                  // }
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3.1,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    clipBehavior: Clip.none,
                    children: [
                      // Background Image Container
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 4,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                image: DecorationImage(
                                  image: coverImage == null
                                      ? NetworkImage('${userModel.coverImage}')
                                      : FileImage(File(coverImage.path))
                                          as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: -5,
                            top: -9,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.blue,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  appCubit.pickCoverImage();
                                },
                                icon: const Icon(
                                  IconBroken.Camera,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Profile Avatar Positioned at the Bottom, Half Outside the Image
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: profileImage == null
                                ? profileAvatar(
                                    radius: 55,
                                    url: '${userModel.image}',
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(55),
                                    child: Image.file(
                                      File(profileImage.path),
                                      fit: BoxFit.cover,
                                      width: 110,
                                      height: 110,
                                    ),
                                  ),
                          ),

                          // Edit Profile Image Button
                          Positioned(
                            left: 70,
                            top: 80,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.blue,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  appCubit.pickProfileImage();
                                  // appCubit.pickProfileIm();
                                },
                                icon: const Icon(
                                  IconBroken.Camera,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Edit Name Field
                defuaLtFormField(
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name Must not Empty';
                    }
                    return null;
                  },
                  controller: appCubit.nameController,
                  prefix: IconBroken.User,
                  type: TextInputType.name,
                ),
                const SizedBox(height: 20),
                // Edit Bio Field
                defuaLtFormField(
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'BIO Must not Empty';
                    }
                    return null;
                  },
                  controller: appCubit.bioController,
                  prefix: IconBroken.Info_Circle,
                  type: TextInputType.text,
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultButton(
                    text: 'Update',
                    onPressed: () {
                      appCubit.uploadProfileImage();

                      // appCubit.uploadProfileIm();
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
