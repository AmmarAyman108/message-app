import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/constants/settings.dart';
import 'package:message_app/data/models/user_model.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
  List<UserModel> users = [];
  final collection = FirebaseFirestore.instance.collection(usersCollection);
  Future<List<UserModel>> getAllChat() async {
    emit(GetAllChatLoading());
    try {
      users.clear();
      await collection.get().then(
        (value) {
          for (var element in value.docs) {
            if (element.id != FirebaseAuth.instance.currentUser?.uid) {
              users.add(UserModel.fromJson(element.data()));
            }
          }
        },
      );
      debugPrint(
          '=========================================== GetAllChatSuccess');
      debugPrint("$users");
      emit(GetAllChatSuccess(users: users));

      return users;
    } on FirebaseException catch (e) {
      emit(GetAllChatFailure(errorMessage: e.toString()));
      debugPrint(
          '=========================================== GetAllChatFailure');

      return [];
    }
  }

  UserModel? user;
  Future getMyData() async {
    emit(GetMyDataLoading());
    try {
      await collection
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get()
          .then((value) => user = UserModel.fromJson(value.data()));
      emit(GetMyDataSuccess(myData: user!));
    } on FirebaseException catch (e) {
      emit(GetMyDataFailure(errorMessage: e.toString()));
    }
  }
}
