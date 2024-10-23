import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
  // Define the primary color for the app
  primarySwatch: Colors.blue,
  primaryColor: Colors.blue,
  primaryColorLight: Colors.blue,

  // Set the background color for the AppBar
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.blue,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
    iconTheme: IconThemeData(color: Colors.black), // AppBar icons color
    titleTextStyle: TextStyle(
        color: Colors.white, fontSize: 20), // Title text style in AppBar
  ),

  // Define the color scheme for the rest of the app
  colorScheme: const ColorScheme.light(
    primary: Colors.blue,
    // primaryVariant: Colors.blue[700], // Darker variant of blue
    secondary: Colors.blueAccent, // Background color for the app
    surface: Colors.white, // Surface color for cards, dialogs, etc.
    onPrimary: Colors.white, // Text color on primary color
    onSecondary: Colors.white, // Text color on secondary color
  ),

  // Set the default button theme
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
  ),

  // Set the floating action button theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
  ),

  // Set the bottom navigation bar theme
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.black,
    enableFeedback: true,
    showUnselectedLabels: true,

  ),

  // Set the scaffold background color
  scaffoldBackgroundColor: Colors.white,
);

ThemeData darkTheme = ThemeData(
  // Define the primary color for the dark theme
  primarySwatch: Colors.blue,
  primaryColor: Colors.blue,

  // Define the brightness of the theme as dark
  brightness: Brightness.dark,

  // Set the AppBar theme
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
    iconTheme: IconThemeData(color: Colors.white), // AppBar icons color
    titleTextStyle: TextStyle(
        color: Colors.white, fontSize: 20), // Title text style in AppBar
  ),

  // Define the color scheme for the rest of the app
  colorScheme: ColorScheme.dark(
    primary: Colors.blue,
    primaryContainer: Colors.blue[700], // Darker variant of blue for containers
    secondary: Colors.blueAccent, // Accent color
    surface: Colors.black, // Background color for the app
    // surface: Colors.grey[900], // Surface color for cards, dialogs, etc.
    onPrimary: Colors.black, // Text color on primary color
    onSecondary: Colors.black, // Text color on secondary color
  ),

  // Set the default button theme
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
  ),

  // Set the floating action button theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
  ),

  // Set the bottom navigation bar theme
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    enableFeedback: true,
    showUnselectedLabels: true,
  ),

  // Set the scaffold background color
  scaffoldBackgroundColor: Colors.black,

  // Set other general settings like text themes if needed
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white), // Formerly bodyText1
    bodyMedium: TextStyle(color: Colors.white), // Formerly bodyText2
    bodySmall: TextStyle(color: Colors.white70), // Formerly caption

    headlineLarge: TextStyle(color: Colors.white), // Formerly headline1
    headlineMedium: TextStyle(color: Colors.white), // Formerly headline2
    headlineSmall: TextStyle(color: Colors.white), // Formerly headline3

    titleLarge: TextStyle(color: Colors.white), // Formerly headline6
    titleMedium: TextStyle(color: Colors.white), // Formerly subtitle1
    titleSmall: TextStyle(color: Colors.white70), // Formerly subtitle2

    labelLarge: TextStyle(color: Colors.white), // Formerly button
    labelMedium: TextStyle(
        color: Colors.white), // For smaller buttons or similar elements
    labelSmall:
        TextStyle(color: Colors.white70), // For overlines or smaller labels
  ),
);
