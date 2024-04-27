import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back_ios_sharp,
        size: 23,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      color: Colors.white,
    );
  }
}
