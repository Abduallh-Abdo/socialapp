import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/components/components.dart';
import 'package:socialapp/cubits/app_cubit/app_cubit.dart';
import 'package:socialapp/cubits/app_cubit/app_state.dart';
import 'package:socialapp/helper/styles/icon_broken.dart';
import 'package:socialapp/views/edit_profile/edit_profile_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        var userModel = appCubit.userModel;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //image and cover image
                defaultProfileView(
                  context: context,
                  userModel: userModel,
                ),
                const SizedBox(height: 60),
                // Additional widgets can be placed below
                Text('${userModel!.name}',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                const SizedBox(height: 10),
                Text(
                  '${userModel.bio}',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.grey[700],
                      ),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    defaultInfo(
                      context: context,
                      number: '100',
                      text: 'posts',
                    ),
                    defaultInfo(
                      context: context,
                      number: '15',
                      text: 'photo',
                    ),
                    defaultInfo(
                      context: context,
                      number: '150',
                      text: 'follower',
                    ),
                    defaultInfo(
                      context: context,
                      number: '25',
                      text: 'following',
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              color: Colors.grey), // Grey border color
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(0), // Square border
                          ),
                        ),
                        child: Text(
                          'Add Photo',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Colors.blue,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(
                        width: 8), // Optional spacing between buttons
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: Colors.grey), // Grey border color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(0), // Square border
                        ),
                      ),
                      onPressed: () {
                        navigateTo(
                          context: context,
                          widget:  const EditProfileScreen(),
                        );
                      },
                      child: const Icon(
                        IconBroken.Edit,
                        color: Colors.blue, // Optional icon color customization
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget defaultInfo({
    required context,
    required String number,
    required String text,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Text(number,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    )),
            const SizedBox(height: 10),
            Text(
              text,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.grey[700],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
