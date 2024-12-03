import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/modules/SocialApp/NewPost/new_post_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (BuildContext context, SocialAppStates state) {},
      builder: (BuildContext context, SocialAppStates state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(IconlyBroken.paperUpload),
              onPressed: () {
                navigateTo(context, NewPostScreen());
              },
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              SocialAppCubit.get(context)
                  .Titles[SocialAppCubit.get(context).currentIndex],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              //IconButton(onPressed: () {}, icon: Icon(IconlyBroken.search)),
              IconButton(
                  onPressed: () {}, icon: Icon(IconlyBroken.notification)),
            ],
          ),
          body: SocialAppCubit.get(context)
              .Screens[SocialAppCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: SocialAppCubit.get(context).currentIndex,
              onTap: (index) {
                SocialAppCubit.get(context).changeIndex(index);
              },
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      IconlyBroken.home,
                    ),
                    label: "Home"),
                BottomNavigationBarItem(
                  icon: Icon(IconlyBroken.chat),
                  label: "Chats",
                ),
                BottomNavigationBarItem(
                    icon: Icon(IconlyBroken.search), label: "Search"),
                BottomNavigationBarItem(
                    icon: Icon(IconlyBroken.setting), label: "Settings"),
              ]),
        );
      },
    );
  }
}
