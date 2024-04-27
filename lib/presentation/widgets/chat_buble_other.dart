import 'package:flutter/material.dart';
import 'package:message_app/data/models/message_model.dart';
import 'package:message_app/presentation/widgets/custom_text.dart';
// import 'package:flutter_application_1/models/message_model.dart';

// ignore: must_be_immutable
class ChatBubleOther extends StatelessWidget {
  ChatBubleOther({super.key, required this.message
      // required this.message
      });
  MessageModel message;
  // MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: const BoxDecoration(
            color: Color(0xff373737),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            )),
        child: CustomText(
          title: message.content,
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
