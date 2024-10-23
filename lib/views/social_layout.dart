import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/components/components.dart';
import 'package:socialapp/cubits/app_cubit/app_cubit.dart';
import 'package:socialapp/cubits/app_cubit/app_state.dart';
import 'package:socialapp/helper/styles/icon_broken.dart';
import 'package:socialapp/views/new_post/post_screen.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppNewPostBottomNavState) {
          navigateTo(
            context: context,
            widget: const NewPostScreen(),
          );
        }
      },
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              appCubit.titles[appCubit.currentIndex],
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  // appCubit.changeAppMode();
                },
                icon: const Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: () {
                  // navigateAndFinish(
                  //     context: context, widget: const SearchScreen());
                },
                icon: const Icon(IconBroken.Search),
              ),
            ],
          ),
          body: appCubit.screens[appCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: appCubit.currentIndex,
            onTap: (index) {
              appCubit.changeBottomNavBar(index);
            },
            items: appCubit.bottomNavBarItem,
          ),
        );
      },
    );
  }
}


// to send verfication
// ConditionalBuilder(
//             condition: appCubit.userModel != null,
//             fallback: (context) =>
//                 const Center(child: CircularProgressIndicator()),
//             builder: (context) {
//               return Column(
//                 children: [
//                   if (!appCubit.userModel!.isEmailVerified!)
//                     ListTile(
//                       tileColor: Colors.amber.withOpacity(.6),
//                       leading: const Icon(
//                         Icons.info_outline,
//                       ),
//                       title: const Text('please verify your account'),
//                       trailing: defaultTextButton(
//                         text: 'SEND',
//                         onPressed: () {},
//                       ),
//                     )
//                 ],
//               );
//             },
//           ),