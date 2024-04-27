import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message_app/constants/settings.dart';
import 'package:message_app/data/models/message_model.dart';
import 'package:message_app/data/models/user_model.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageInitial());
  final collection = FirebaseFirestore.instance.collection(usersCollection);

  Future<void> sendMessage(
      {required String message, required UserModel receiver}) async {
    try {
      await collection
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection(chatsCollection)
          .doc(receiver.id)
          .collection(messagesCollection)
          .add({
        'content': message,
        'date': DateTime.now().toString(),
        'senderID': FirebaseAuth.instance.currentUser?.uid
      });
      await collection
          .doc(receiver.id)
          .collection(chatsCollection)
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection(messagesCollection)
          .add({
        'content': message,
        'date': DateTime.now().toString(),
        'senderID': receiver.id
      });
      debugPrint(
          '=============================================== SendMessageSuccess');
      emit(SendMessageSuccess());
    } on Exception catch (e) {
      debugPrint(
          '=============================================== SendMessageFailure');

      emit(SendMessageFailure(errorMessage: e.toString()));
    }
  }

  List<MessageModel> messages = [];
  Future<List<MessageModel>> getAllMessage(
      {required UserModel receiver}) async {
    messages.clear();
    emit(GetMessageLoading());
    debugPrint(
        '============================================ GetMessageLoading');

    try {
      await collection
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection(chatsCollection)
          .doc(receiver.id)
          .collection(messagesCollection)
          .orderBy('date')
          .get()
          .then(
        (event) {
          for (var item in event.docs) {
            messages.add(MessageModel.fromJson(item.data()));
          }
        },
      );
      debugPrint(
          '============================================ GetMessageSuccess');
      debugPrint("$messages");
      emit(GetMessageSuccess(messages: messages));
      return messages;
    } on Exception catch (e) {
      emit(GetMessageFailure(errorMessage: e.toString()));
      return [];
    }
  }
}
