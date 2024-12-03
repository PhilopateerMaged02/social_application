import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/models/user/user_model.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  var searchController = TextEditingController();
  bool flag = false;
  List<UserModel> filteredUsers = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        // Fetch the list of users from the cubit
        var users = SocialAppCubit.get(context).users;

        // Filter users based on search input
        if (searchController.text.isNotEmpty) {
          filteredUsers = users
              .where((user) => user.name
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()))
              .toList();
        } else {
          filteredUsers = users;
        }

        return Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: defaultFormField(
                  controller: searchController,
                  input: TextInputType.text,
                  onValidator: (value) {},
                  text: "Search for User...",
                  prefix: IconlyBroken.search,
                  onFieldSubmitted: (value) {
                    setState(() {
                      flag = true;
                    });
                  },
                ),
              ),
              if (flag || searchController.text.isNotEmpty)
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => itemBuilder(
                        filteredUsers[index]), // Display filtered users
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: filteredUsers.length,
                  ),
                ),
              if (searchController.text.isEmpty && !flag)
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) =>
                        itemBuilder(SocialAppCubit.get(context).users[index]),
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: SocialAppCubit.get(context).users.length,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget itemBuilder(UserModel userModel) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
        ],
      ),
    );
  }
}
