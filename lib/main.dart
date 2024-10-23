import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/auth/login/social_login_screen.dart';
import 'package:socialapp/cubits/app_cubit/app_cubit.dart';
import 'package:socialapp/cubits/app_cubit/app_state.dart';
import 'package:socialapp/helper/const.dart';
import 'package:socialapp/helper/styles/themes/theme_app.dart';
import 'package:socialapp/helper/shared_preference/shared_pref.dart';
import 'package:socialapp/views/social_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();

  Widget widget;
  isDark = CacheHelper.getData(key: 'isDark') ?? true;
  uid = CacheHelper.getData(key: 'uid') ?? '';

  if (uid != null) {
    widget = const SocialLayout();
  } else {
    widget = const SocialLoginScreen();
  }

  runApp(SocialApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class SocialApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;
  const SocialApp({
    required this.isDark,
    required this.startWidget,
  }) : super(key: null);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getUserData(),

      // ..changeAppMode(fromShared: isDark),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
