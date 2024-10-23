import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defuaLtFormField({
  required TextEditingController controller,
  required dynamic validate,
  String? labelText,
  String? hintText,
  required TextInputType type,
  required IconData prefix,
  IconData? suffix,
  bool obscureText = false,
  Function()? suffixPressed,
  Function(String)? onSubmit,
  Function(String)? onChanged,
}) {
  return TextFormField(
    style: const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    controller: controller,
    keyboardType: type,
    obscureText: obscureText,
    validator: validate,
    onFieldSubmitted: onSubmit,
    onChanged: onChanged,
    decoration: InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: Icon(
        prefix,
      ),
      //
      suffix: suffix != null
          ? IconButton(
              onPressed: suffixPressed,
              icon: Icon(
                suffix,
              ),
            )
          : null,
      border: const OutlineInputBorder(),
    ),
  );
}

Widget defaultButton({
  required String text,
  required VoidCallback onPressed,
  Color color = Colors.blueAccent,
  double width = double.infinity,
  double height = 40,
  double radius = 0,
  bool isUppercase = true,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        radius,
      ),
      color: color,
    ),
    child: MaterialButton(
      onPressed: onPressed,
      child: Text(
        isUppercase ? text.toUpperCase() : text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    ),
  );
}

Widget defaultTextButton({
  required String text,
  required VoidCallback onPressed,
  double fontSize = 15,
  Color color = Colors.blue,
}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
      ),
    ),
  );
}

void navigateTo({
  required BuildContext context,
  required Widget widget,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndFinish({
  required BuildContext context,
  required Widget widget,
}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false,
  );
}

Future<bool?> defaultToast({
  required msg,
  required ToastStates state,
}) async {
  return await Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: changeToastState(state: state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastStates {
  success,
  error,
  warning,
}

Color changeToastState({required ToastStates state}) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.lightGreen;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}

PreferredSizeWidget defaultAppBar({
  required context,
  String? title,
  Widget? leading,
  List<Widget>? actions,
}) {
  return AppBar(
    actions: actions,
    leading: leading,
    backgroundColor: Colors.white,
    title: Text(
      title!,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    ),
  );
}

Widget defaultProfileView({required context, required var userModel}) {
  return Stack(
    alignment: Alignment.center, // Aligns the avatar horizontally
    clipBehavior:
        Clip.none, // Allows the avatar to overflow outside the container
    children: [
      // Background Image Container
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          image: DecorationImage(
            image: NetworkImage(
              '${userModel!.coverImage}',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
      // Profile Avatar Positioned at the Bottom, Half Outside the Image
      Positioned(
        top: MediaQuery.of(context).size.height / 6,
        child: CircleAvatar(
          radius: 60,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: profileAvatar(
            radius: 55,
            url: '${userModel.image}',
          ),
        ),
      ),
    ],
  );
}

Widget profileAvatar({double radius = 40, required String url}) {
  return CircleAvatar(
    radius: radius,
    backgroundImage: NetworkImage(
      url,
    ),
  );
}
