import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/business_logic/cubits/message_cubit/message_cubit.dart';
import 'package:message_app/constants/constant.dart';
import 'package:message_app/constants/settings.dart';
import 'package:message_app/data/models/message_model.dart';
import 'package:message_app/data/models/user_model.dart';
import 'package:message_app/presentation/widgets/back.dart';
import 'package:message_app/presentation/widgets/chat_buble.dart';
import 'package:message_app/presentation/widgets/chat_buble_other.dart';
import 'package:message_app/presentation/widgets/custom_text.dart';
import 'package:message_app/presentation/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class ChatView extends StatefulWidget {
  ChatView({
    super.key,
    required this.user,
  });
  UserModel user;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  TextEditingController message = TextEditingController();

  // final ScrollController scrollController = ScrollController();
  List<MessageModel> messages = [];

  @override
  Widget build(BuildContext context) {
    var collection = FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection(chatsCollection)
        .doc(widget.user.id)
        .collection(messagesCollection);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.kColor,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 0),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5000),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/xm.jpg'),
                        fit: BoxFit.fill)),
              ),
            ),
            CustomText(
              title: widget.user.name,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ],
        ),
        leading: const CustomBackButton(),
      ),
      body: Column(
        children: [
          // Container(
          //   color: CustomColor.kColor,
          //   height: 89,
          //   padding: const EdgeInsets.only(top: 30),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       const CustomBackButton(),
          //       Padding(
          //         padding: const EdgeInsets.only(right: 10, left: 5),
          //         child: Container(
          //           height: 40,
          //           width: 40,
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(5000),
          //               image: const DecorationImage(
          //                   image: AssetImage('assets/images/xm.jpg'),
          //                   fit: BoxFit.fill)),
          //         ),
          //       ),
          //       CustomText(
          //           title: widget.user.name,
          //           fontWeight: FontWeight.bold,
          //           color: Colors.white,
          //           fontSize: 20),
          //       const Spacer(),
          //     ],
          //   ),
          // ),
          Expanded(
              flex: 8,
              child: StreamBuilder<QuerySnapshot>(
                stream: collection.orderBy('date').snapshots(),
                builder: (context, snapshot) {
                  snapshot.data?.docs
                      .map((e) => messages.add(MessageModel.fromJson(e.data())))
                      .toList();
                  if (snapshot.hasData) {
                    messages.clear();

                    snapshot.data?.docs
                        .map((e) =>
                            messages.add(MessageModel.fromJson(e.data())))
                        .toList();

                    return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return messages[index].senderID ==
                                FirebaseAuth.instance.currentUser?.uid
                            ? ChatBuble(
                                message: messages[index],
                              )
                            : ChatBubleOther(
                                message: messages[index],
                              );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: CustomText(title: 'error'),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 5, top: 4),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(right: 5, left: 2),
                      child: CustomTextField(
                        controller: message,
                        hint: 'Message',
                        icon: Icons.face,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(500),
                        color: CustomColor.kColor),
                    child: Center(
                      child: IconButton(
                          onPressed: () {
                            BlocProvider.of<MessageCubit>(context).sendMessage(
                                message: message.text, receiver: widget.user);
                            message.clear();
                            // scrollController.animateTo(0,
                            //     duration: const Duration(seconds: 3),
                            //     curve: Curves.easeIn);
                          },
                          icon: const Icon(
                            Icons.send,
                            size: 25,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
// state.messages[index].senderID ==
                      //         FirebaseAuth.instance.currentUser?.uid
                      //     ? ChatBuble(
                      //         message: state.messages[index],
                      //       )
                      //     : ChatBubleOther(
                      //         message: state.messages[index],
                      //       ),