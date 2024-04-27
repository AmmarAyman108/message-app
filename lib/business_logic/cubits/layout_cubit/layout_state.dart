part of 'layout_cubit.dart';

sealed class LayoutState {}

final class LayoutInitial extends LayoutState {}

 class GetAllChatSuccess extends LayoutState {
  List<UserModel> users;
  GetAllChatSuccess({required this.users});
}

final class GetAllChatLoading extends LayoutState {}

final class GetAllChatFailure extends LayoutState {
  String errorMessage;
  GetAllChatFailure({required this.errorMessage});
}
final class GetMyDataFailure extends LayoutState {
  String errorMessage;
  GetMyDataFailure({required this.errorMessage});
}
final class GetMyDataLoading extends LayoutState {}
final class GetMyDataSuccess extends LayoutState {
  UserModel myData;
  GetMyDataSuccess({required this.myData});
}
