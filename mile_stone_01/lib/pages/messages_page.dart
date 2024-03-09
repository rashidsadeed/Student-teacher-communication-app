import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mile_stone_01/repository/message_repo.dart';
import "package:mile_stone_01/models/message.dart";



class MessagesPage extends ConsumerStatefulWidget{
  const MessagesPage({super.key});

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends ConsumerState<MessagesPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value)=> ref.read(newMessagesProvider.notifier).nullify());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final messagesRepository = ref.watch(messagesProvider);
    return Scaffold(
      appBar: AppBar(
          title: const Text("Messages")
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messagesRepository.messages.length,
              itemBuilder: (context, index) {
                return MessageDisplay(messagesRepository.messages[index]);
              },
            ),
          ),

          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25.0),
                            )
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none
                            ),

                          ),
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ElevatedButton(
                      onPressed: () {
                        print("send");
                      },
                      child: const Text("Send")),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MessageDisplay extends StatelessWidget {
  final Message message;
  const MessageDisplay(this.message, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.sender == "Deadpool" ? Alignment.centerRight: Alignment.centerLeft,
      child: Padding(
        padding:const EdgeInsets.symmetric(horizontal:8.0, vertical: 8.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2),
              color: Colors.blue.shade300,
              borderRadius: const BorderRadius.all(Radius.circular(15))
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(message.text),
          ),
        ),
      ),
    );
  }
}
