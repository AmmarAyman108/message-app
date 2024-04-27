import 'package:flutter/material.dart';
import 'package:message_app/data/models/message_model.dart';
import 'package:message_app/presentation/widgets/custom_text.dart';

// ignore: must_be_immutable
class ChatBuble extends StatelessWidget {
  ChatBuble({super.key, required this.message
      // required this.message
      });
  MessageModel message;
  // MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        padding: const EdgeInsets.all(10),
        // ignore: sort_child_properties_last
        child: CustomText(
          title: message.content,
          color: Colors.white,
          fontSize: 16,
        ),
        decoration: const BoxDecoration(
            // ignore: unnecessary_const
            color: Color(0xff035D4D),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100),
                topLeft: Radius.circular(100),
                topRight: Radius.circular(100))),
      ),
    );
  }
}
