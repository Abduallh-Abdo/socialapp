import 'package:flutter/material.dart';
import 'package:socialapp/components/components.dart';
import 'package:socialapp/helper/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            IconBroken.Arrow___Left_2,
          ),
        ),
        title: 'Add Post',
      ),
    );
  }
}
