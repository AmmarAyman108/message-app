part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

// ignore: must_be_immutable
class LoginFailureState extends AuthState {
  String errorMessage;
  LoginFailureState({
    required this.errorMessage,
  });
}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {}

// ignore: must_be_immutable
class RegisterFailureState extends AuthState {
  String errorMessage;
  RegisterFailureState({
    required this.errorMessage,
  });
}

class ProfileImageSelectedSuccess extends AuthState {
  File? profileImage;
  ProfileImageSelectedSuccess({
    required this.profileImage,
  });
}

class ProfileImageSelectedLoading extends AuthState {}

class ProfileImageSelectedFailure extends AuthState {}

class SaveUserInformationFailure extends AuthState {
   String errorMessage;
  SaveUserInformationFailure({
    required this.errorMessage,
  });
}

class SaveUserInformationSuccess extends AuthState {}
