abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {}

class ChatFailure extends ChatState {
  final String error;

  ChatFailure(this.error);
}

class ChatReplyState extends ChatState {}
