import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user/user_model.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return ListView.separated(
            itemBuilder: (context, index) =>
                itemBuilder(SocialAppCubit.get(context).users[index]),
            separatorBuilder: (context, index) => Container(),
            itemCount: SocialAppCubit.get(context).users.length);
      },
    );
  }

  Widget itemBuilder(UserModel userModel) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(userModel.image),
          ),
          SizedBox(
            width: 20.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                userModel.name,
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                userModel.bio,
                style: TextStyle(fontSize: 15.0),
              ),
            ],
          )
        ]));
  }
}
