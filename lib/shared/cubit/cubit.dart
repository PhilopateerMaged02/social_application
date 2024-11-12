import 'dart:io';
import 'package:supabase/supabase.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
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
import 'package:supabase_flutter/supabase_flutter.dart';

class SocialAppCubit extends Cubit<SocialAppStates> {
  SocialAppCubit() : super(SocialAppInitialState());
  static SocialAppCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  void getUserData() {
    // emit(SocialAppGetUserLoadingState());
    // FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
    //   if (value.data() != null) {
    //     userModel = UserModel.fromJson(value.data()!);
    //     emit(SocialAppGetUserSuccessState());
    //   } else {
    //     print("User data is null.");
    //     emit(SocialAppGetUserErrorState("User data is null.", error: ''));
    //   }
    // }).catchError((error) {
    //   print("Error retrieving user data: ${error.toString()}");
    //   emit(SocialAppGetUserErrorState(error.toString(), error: 'errrr'));
    // });
  }

  void getUserDataSupabase() async {
    final user = supabase.auth.currentUser;

    if (user != null) {
      final userMetadata = user.userMetadata;
      userModel = UserModel(
        uId: user.id,
        email: user.email!,
        name: userMetadata?['Display name'] ?? '',
        phone: userMetadata?['Phone'] ?? '', bio: '', cover: '', image: '',
        isEmailVerified: false,
        // Add other fields as needed
      );
      print('Email: ${user.email}');
      print('Name: ${userModel!.name}');
      print('Phone: ${userModel!.phone}');
    } else {
      print('No user is logged in');
    }
  }

  void getBucket() async {
    final List<Bucket> buckets = await supabase.storage.listBuckets();
  }

  Future<Bucket?> getBuckets(String bucketName) async {
    try {
      final Bucket bucket = await supabase.storage.getBucket(bucketName);
      return bucket;
    } catch (e) {
      print('Error retrieving bucket: $e');
      return null;
    }
  }

  void createBucket() async {
    final String bucketId = await supabase.storage.createBucket('social');
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

  File? profileImage;
  File? coverImage;
  ImagePicker picker = ImagePicker();

  Future<void> getProfileImage() async {
    try {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        profileImage = File(pickedFile.path);
        emit(SocialAppPickedProfileImageSuccessState());
      } else {
        print('No image selected');
        emit(SocialAppPickedProfileImageErrorState());
        //return null;
      }
    } catch (e) {
      print('Error selecting image: $e');
      emit(SocialAppPickedProfileImageErrorState());
      //return null;
    }
  }

  Future<void> getCoverImage() async {
    try {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        coverImage = File(pickedFile.path);
        print(pickedFile.path);
        emit(SocialAppPickedCoverImageSuccessState());
      } else {
        print('No image selected');
        emit(SocialAppPickedCoverImageErrorState());
        //return null;
      }
    } catch (e) {
      print('Error selecting image: $e');
      emit(SocialAppPickedCoverImageErrorState());
      //return null;
    }
  }

  void uploadProfile({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialAppUpdateUserLoadingState());
    UserModel model = UserModel(
        name: name,
        phone: phone,
        bio: bio,
        isEmailVerified: false,
        email: userModel!.email,
        uId: userModel!.uId,
        cover: userModel!.cover,
        image: userModel!.image);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserDataSupabase();
      emit(SocialAppUpdateUserSuccessState());
    }).catchError((error) {
      emit(SocialAppUpdateUserErrorState());
    });
  }
}
