import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/models/messages/messages_model.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class ChatBetween extends StatelessWidget {
  var MessageController = TextEditingController();
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
                icon: Icon(IconlyBroken.arrowLeft2)),
            title: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      NetworkImage(SocialAppCubit.get(context).profileImagee),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  SocialAppCubit.get(context).userName,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 2,
                color: Colors.black45,
              ),
              SizedBox(
                height: 10,
              ),
              ConditionalBuilder(
                condition: SocialAppCubit.get(context).messages.isNotEmpty,
                builder: (BuildContext context) {
                  return Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) => buildMessageItem(
                            SocialAppCubit.get(context).messages[index]),
                        separatorBuilder: (context, index) => Container(
                              height: 5,
                            ),
                        itemCount: SocialAppCubit.get(context).messages.length),
                  );
                },
                fallback: (BuildContext context) {
                  return Center(child: CircularProgressIndicator());
                },
              ),
              //Spacer(),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: defaultFormField(
                    controller: MessageController,
                    input: TextInputType.text,
                    onValidator: (value) {},
                    text: "",
                    prefix: IconlyBold.message,
                    suffix: IconlyBroken.send,
                    onSuffix: () async {
                      print(SocialAppCubit.get(context).chatID);
                      print(uId);
                      print(DateTime.now().toString());
                      SocialAppCubit.get(context).sendMessage(
                          senderId: uId,
                          text: MessageController.text,
                          at: DateTime.now().toString(),
                          chatId: SocialAppCubit.get(context).chatID);
                      MessageController.clear();
                    }),
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildMessageItem(MessagesModel messageModel) {
    return Row(
      mainAxisAlignment: messageModel.senderId == uId
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 300,
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(messageModel.text),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
