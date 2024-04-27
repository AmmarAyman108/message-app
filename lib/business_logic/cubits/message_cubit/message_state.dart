part of 'message_cubit.dart';

@immutable
sealed class MessageState {}

final class MessageInitial extends MessageState {}

final class SendMessageSuccess extends MessageState {}

final class SendMessageLoading extends MessageState {}

// ignore: must_be_immutable
final class SendMessageFailure extends MessageState {
  String errorMessage;
  SendMessageFailure({required this.errorMessage});
}

// ignore: must_be_immutable
final class GetMessageSuccess extends MessageState {
  List<MessageModel> messages;
  GetMessageSuccess({required this.messages});
}

// ignore: must_be_immutable
final class GetMessageFailure extends MessageState {
  String errorMessage;
  GetMessageFailure({required this.errorMessage});
}

final class GetMessageLoading extends MessageState {}
