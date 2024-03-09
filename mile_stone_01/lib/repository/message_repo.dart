import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:mile_stone_01/models/message.dart";

class MessagesRepository extends ChangeNotifier {
  List<Message> messages = [
    Message("What up fam??", "Dave chapelle", DateTime.now().subtract(const Duration(minutes: 3))),
    Message("How you doin??", "Joey", DateTime.now().subtract(const Duration(minutes: 2))),
    Message("What in the actual FUCK!!!?????", "Deadpool", DateTime.now().subtract(const Duration(minutes: 1))),
    Message("I wonder how this gun tastes like", "Hemingway", DateTime.now()),
  ];

  int numMessages = 4;
}

final messagesProvider = ChangeNotifierProvider((ref){
  return MessagesRepository();
});

class NumNewMessages extends StateNotifier<int>{
  NumNewMessages(int state) : super(state);

  void nullify(){
    state = 0;
  }
}

final newMessagesProvider = StateNotifierProvider<NumNewMessages, int>((ref){
  return NumNewMessages(4);
});
