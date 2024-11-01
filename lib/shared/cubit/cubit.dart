import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/models/user/user_model.dart';
import 'package:social_app/modules/SocialApp/Chats/chats_screen.dart';
import 'package:social_app/modules/SocialApp/Feeds/feeds_screen.dart';
import 'package:social_app/modules/SocialApp/Notifications/notifications_screen.dart';
import 'package:social_app/modules/SocialApp/Search/search_screen.dart';
import 'package:social_app/modules/SocialApp/Settings/settings_screen.dart';
import 'package:social_app/modules/SocialApp/Users/users_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:path/path.dart';

class SocialAppCubit extends Cubit<SocialAppStates> {
  SocialAppCubit() : super(SocialAppInitialState());
  static SocialAppCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  void getUserData() {
    emit(SocialAppGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      if (value.data() != null) {
        userModel = UserModel.fromJson(value.data()!);
        emit(SocialAppGetUserSuccessState());
      } else {
        print("User data is null.");
        emit(SocialAppGetUserErrorState("User data is null.", error: ''));
      }
    }).catchError((error) {
      print("Error retrieving user data: ${error.toString()}");
      emit(SocialAppGetUserErrorState(error.toString(), error: 'errrr'));
    });
  }

  int currentIndex = 0;
  List<Widget> Screens = [
    FeedsScreen(),
    ChatsScreen(),
    UsersScreen(),
    SettingsScreen()
  ];
  List<String> Titles = [
    "Home",
    "Chats",
    "Users",
    "Settings",
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(SocialAppChangeBottomNavState());
  }
}
