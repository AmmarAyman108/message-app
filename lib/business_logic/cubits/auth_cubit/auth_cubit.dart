import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:message_app/constants/settings.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> loginByEmailAndPassword(
      {required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        emit(LoginFailureState(errorMessage: 'user not found'));
      } else if (e.code == 'wrong-password.') {
        emit(LoginFailureState(errorMessage: 'wrong password.'));
      } else if (e.code == "invalid-email") {
        emit(LoginFailureState(errorMessage: "Invalid Email."));
      }
    } catch (e) {
      emit(LoginFailureState(errorMessage: e.toString()));
    }
  }

  Future<void> registerByEmailAndPassword(
      {required String email,
      required String name,
      required String password}) async {
    emit(RegisterLoadingState());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await saveUserInformation(email: email, name: name);
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailureState(errorMessage: 'weak password'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailureState(errorMessage: 'email already in use'));
      } else if (e.code == "invalid-email") {
        emit(RegisterFailureState(errorMessage: "Invalid Email."));
      }
    } catch (e) {
      emit(RegisterFailureState(errorMessage: e.toString()));
    }
  }

  File? profileImage;
  Future pickImage() async {
    emit(ProfileImageSelectedLoading());

    final XFile? imagePicker =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicker != null) {
      profileImage = File(imagePicker.path);
      emit(ProfileImageSelectedSuccess(profileImage: profileImage));
    } else {
      emit(ProfileImageSelectedFailure());
    }
  }

  final CollectionReference collection =
      FirebaseFirestore.instance.collection(usersCollection);
  Future saveUserInformation({
    required String name,
    required String email,
  }) async {
    // UserModel user = UserModel(
    //     email: email,
    //     id: FirebaseAuth.instance.currentUser?.uid ?? '',
    //     name: name);
    try {
      await collection.doc(FirebaseAuth.instance.currentUser?.uid).set({
        'name': name,
        'email': email,
        'id': FirebaseAuth.instance.currentUser?.uid
      });
      emit(SaveUserInformationSuccess());
    } on FirebaseException catch (e) {
      emit(SaveUserInformationFailure(errorMessage: e.toString()));
    }
  }
}
