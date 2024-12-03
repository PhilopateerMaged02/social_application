import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/models/messages/messages_model.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class ChatBetween extends StatefulWidget {
  @override
  _ChatBetweenState createState() => _ChatBetweenState();
}

class _ChatBetweenState extends State<ChatBetween> {
  var MessageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, () {
    //   // Trigger message stream when the widget is initialized
    //   SocialAppCubit.get(context).fetchAndFillMessages(
    //     chatId: SocialAppCubit.get(context).chatID,
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (BuildContext context, SocialAppStates state) {},
      builder: (BuildContext context, SocialAppStates state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                SocialAppCubit.get(context).messages = [];
              },
              icon: Icon(IconlyBroken.arrowLeft2),
            ),
            title: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    SocialAppCubit.get(context).profileImagee,
                  ),
                ),
                SizedBox(width: 10),
                Text(SocialAppCubit.get(context).userName),
              ],
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: StreamBuilder<List<MessagesModel>>(
                  stream: SocialAppCubit.get(context)
                      .getMessagesStream(SocialAppCubit.get(context).chatID),
                  builder: (context, snapshot) {
                    // Initial loading state
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text("No messages in this chat"));
                    } else {
                      // Display messages
                      List<MessagesModel> messages = snapshot.data!;
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          return buildMessageItem(message);
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 8),
                        itemCount: messages.length,
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: defaultFormField(
                  controller: MessageController,
                  input: TextInputType.text,
                  text: "Type your message...",
                  prefix: Icons.message,
                  suffix: Icons.send,
                  onSuffix: () {
                    SocialAppCubit.get(context).sendMessage(
                      senderId: uId,
                      text: MessageController.text,
                      at: DateTime.now().toString(),
                      chatId: SocialAppCubit.get(context).chatID,
                    );
                    MessageController.clear();
                  },
                  onFieldSubmitted: (value) {
                    SocialAppCubit.get(context).sendMessage(
                      senderId: uId,
                      text: MessageController.text,
                      at: DateTime.now().toString(),
                      chatId: SocialAppCubit.get(context).chatID,
                    );
                    MessageController.clear();
                  },
                  onValidator: (String? value) {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildMessageItem(MessagesModel message) {
    final isMyMessage = message.senderId == uId;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Align(
        alignment: isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isMyMessage ? Colors.blue : Colors.grey[400],
            borderRadius: isMyMessage
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.zero,
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))
                : BorderRadius.only(
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
          ),
          child: Text(message.text),
        ),
      ),
    );
  }
}
