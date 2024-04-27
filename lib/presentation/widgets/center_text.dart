import 'package:flutter/material.dart';
import 'package:message_app/constants/constant.dart';
import 'package:message_app/presentation/widgets/custom_text.dart';

// ignore: must_be_immutable
class CenterText extends StatelessWidget {
  CenterText({
    super.key,
    required this.textHint,
    required this.textButton,
    required this.onTap,
  });
  String textHint, textButton;
  Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          title: textHint,
          fontSize: 16,
        ),
        GestureDetector(
          onTap: onTap,
          child: CustomText(
            title: textButton,
            color: CustomColor.kPrimaryColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
