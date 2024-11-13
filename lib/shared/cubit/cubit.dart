import 'dart:io';
import 'dart:typed_data';
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
  File? profileImage;
  File? coverImage;
  ImagePicker picker = ImagePicker();
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

  // void getUserDataSupabase() async {
  //   final user = supabase.auth.currentUser;

  //   if (user != null) {
  //     final userMetadata = user.userMetadata;
  //     userModel = UserModel(
  //       uId: user.id,
  //       email: user.email!,
  //       name: userMetadata?['Display name'] ?? '',
  //       phone: userMetadata?['Phone'] ?? '',
  //       bio: userMetadata?['bio'] ?? '',
  //       cover: userMetadata?['cover_image'] ?? '',
  //       image: userMetadata?['profile_image'] ?? '',
  //       isEmailVerified: false,
  //       // Add other fields as needed
  //     );
  //     print('User Metadata: $userMetadata');

  //     print('Email: ${user.email}');
  //     print('Name: ${userModel!.name}');
  //     print('Phone: ${userModel!.phone}');
  //     print('profile: ${userModel!.image}');
  //     print('cover: ${userModel!.cover}');
  //     print('bio: ${userModel!.bio}');
  //   } else {
  //     print('No user is logged in');
  //   }
  // }
  void getUserDataSupabase() async {
    emit(SocialAppGetUserLoadingState());
    final response = await supabase.auth.getUser();
    final user = response.user;

    if (user != null) {
      emit(SocialAppGetUserSuccessState());
      final userMetadata = user.userMetadata;
      userModel = UserModel(
        uId: user.id,
        email: user.email!,
        name: userMetadata?['Display name'] ?? '',
        phone: userMetadata?['Phone'] ?? '',
        bio: userMetadata?['bio'] ?? '',
        cover: userMetadata?['cover_image'] ?? '',
        image: userMetadata?['profile_image'] ?? '',
        isEmailVerified: false,
      );
      print('Email: ${user.email}');
      print('Name: ${userModel!.name}');
      print('Phone: ${userModel!.phone}');
      print('Profile: ${userModel!.image}');
      print('Cover: ${userModel!.cover}');
      print('Bio: ${userModel!.bio}');
    } else {
      emit(SocialAppGetUserErrorState('No user is logged in',
          error: 'No user is logged in'));
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

  void uploadProfileImageFile() async {
    try {
      final avatarFile = File(profileImage!.path);
      final String fileName = Uri.file(avatarFile.path).pathSegments.last;

      // Upload the file with upsert set to true to overwrite if the file already exists
      final uploadResponse = await supabase.storage.from('social').upload(
            'users/profile_image/$fileName', // File path
            avatarFile,
            fileOptions: const FileOptions(
                cacheControl: '3600', upsert: true), // Allow overwriting
          );

      // Get the public URL for the uploaded file
      final String profileImageUrl =
          supabase.storage.from('social').getPublicUrl(
                'users/profile_image/$fileName',
              );

      print('Cover Image URL: $profileImageUrl');

      // Update the user data with the new cover image URL
      final UserResponse res = await supabase.auth.updateUser(
        UserAttributes(data: {
          'profile_image': profileImageUrl,
        }),
      );

      // Refresh user data
      getUserDataSupabase();
    } catch (error) {
      print('Error uploading cover image: $error');
    }
  }

  void uploadCoverImageFile() async {
    try {
      final avatarFile = File(coverImage!.path);
      final String fileName = Uri.file(avatarFile.path).pathSegments.last;

      // Upload the file with upsert set to true to overwrite if the file already exists
      final uploadResponse = await supabase.storage.from('social').upload(
            'users/cover_image/$fileName', // File path
            avatarFile,
            fileOptions: const FileOptions(
                cacheControl: '3600', upsert: true), // Allow overwriting
          );

      // Get the public URL for the uploaded file
      final String coverImageUrl = supabase.storage.from('social').getPublicUrl(
            'users/cover_image/$fileName',
          );

      print('Cover Image URL: $coverImageUrl');

      // Update the user data with the new cover image URL
      final UserResponse res = await supabase.auth.updateUser(
        UserAttributes(data: {
          'cover_image': coverImageUrl,
        }),
      );
      // Refresh user data
      getUserDataSupabase();
    } catch (error) {
      print('Error uploading cover image: $error');
    }
  }

  // Future<String> getProfileImageUrl() async {
  //   final String profileImage = await supabase.storage
  //       .from('social')
  //       .getPublicUrl(
  //           'users/profile_image/${Uri.file(avatarFile.path).pathSegments.last}');
  //   return profileImage;
  // }

  void updateUserData({
    required String name,
    required String phone,
    required String bio,
  }) async {
    try {
      // Perform the user update
      final UserResponse res = await supabase.auth.updateUser(
        UserAttributes(data: {
          'Display name': name,
          'Phone': phone,
          'bio': bio,
        }),
      );

      if (res.user != null) {
        getUserDataSupabase();
        emit(SocialAppUpdateUserSuccessState());
      } else {
        // If update failed, emit error state
        emit(SocialAppUpdateUserErrorState());
      }
    } catch (error) {
      // Handle errors
      print('Error updating user data: $error');
      emit(SocialAppUpdateUserErrorState());
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

  // void uploadProfile({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialAppUpdateUserLoadingState());
  //   UserModel model = UserModel(
  //       name: name,
  //       phone: phone,
  //       bio: bio,
  //       isEmailVerified: false,
  //       email: userModel!.email,
  //       uId: userModel!.uId,
  //       cover: userModel!.cover,
  //       image: userModel!.image);
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userModel!.uId)
  //       .update(model.toMap())
  //       .then((value) {
  //     getUserDataSupabase();
  //     emit(SocialAppUpdateUserSuccessState());
  //   }).catchError((error) {
  //     emit(SocialAppUpdateUserErrorState());
  //   });
  // }
}
