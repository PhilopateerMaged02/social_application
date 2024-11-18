import 'dart:io';
import 'dart:typed_data';
import 'package:social_app/models/posts/posts_model.dart';
import 'package:social_app/modules/SocialApp/Login/login_screen.dart';
import 'package:social_app/shared/components/components.dart';
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
  File? postImage;
  String? postImageURL;
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
      final uploadResponse = await supabase.storage.from('social').upload(
            'users/cover_image/$fileName',
            avatarFile,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
          );

      final String coverImageUrl = supabase.storage.from('social').getPublicUrl(
            'users/cover_image/$fileName',
          );
      print('Cover Image URL: $coverImageUrl');

      final UserResponse res = await supabase.auth.updateUser(
        UserAttributes(data: {
          'cover_image': coverImageUrl,
        }),
      );
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
        emit(SocialAppUpdateUserErrorState());
      }
    } catch (error) {
      print('Error updating user data: $error');
      emit(SocialAppUpdateUserErrorState());
    }
  }

  void createBucket() async {
    final String bucketId = await supabase.storage.createBucket('social');
  }

  PostsModel? postsModel;
  Future<void> uploadImagePost() async {
    emit(SocialAppCreatePostLoadingState());
    try {
      if (postImage != null) {
        final avatarFile = File(postImage!.path);
        final String fileName = Uri.file(avatarFile.path).pathSegments.last;

        await supabase.storage.from('social').upload(
              'posts/post_image/$fileName', // File path
              avatarFile,
              fileOptions:
                  const FileOptions(cacheControl: '3600', upsert: true),
            );
        postImageURL = supabase.storage.from('social').getPublicUrl(
              'posts/post_image/$fileName',
            );
        print('Post Image URL: $postImageURL');
        emit(SocialAppCreatePostSuccessState());
      } else {}
    } catch (error) {
      print('Error uploading post image: $error');
      emit(SocialAppCreatePostErrorState());
    }
  }

  Future<List<Map<String, dynamic>>> fetchPosts() async {
    final data = await supabase.from('posts').select();

    return data as List<Map<String, dynamic>>;
  }

  void insertIntoTable({
    required String name,
    required String dateTime,
    required String image,
    String? postImage,
    required String text,
    required String uId,
  }) async {
    emit(SocialAppCreatePostLoadingState());

    try {
      final response = await supabase
          .from('posts')
          .insert({
            'uId': uId,
            'name': name,
            'image': image,
            'postImage': postImage,
            'dateTime': dateTime.toString(),
            'text': text,
          })
          .select(
              'id, name, uId, image, postImage, dateTime, text, likes_count')
          .single();

      if (response != null) {
        final postId = response['id'];
        final postName = response['name'];
        final postUId = response['uId'];
        final postImageUrl = response['postImage'];
        final postDateTime = response['dateTime'];
        final postText = response['text'];
        final postUserImage = response['image'];
        final postLikes = response['likes_count'];

        final post = PostsModel(
          id: postId,
          name: postName,
          uId: postUId,
          image: postUserImage,
          postImage: postImageUrl,
          dateTime: postDateTime,
          text: postText,
          postLikes: postLikes,
        );

        print("**********************************************");
        print("*************Inserted Successfully************");
        print(post);
        print("**********************************************");

        emit(SocialAppCreatePostSuccessState());
      }
    } catch (error) {
      print('Error inserting data into the table: $error');
      emit(SocialAppCreatePostErrorState());
    }
  }

  List<PostsModel> posts = [];

  Future<List<PostsModel>> getPosts() async {
    emit(SocialAppGetPostsLoadingState());
    try {
      final data = await supabase.from('posts').select();

      // Debug: Print the raw data
      print(data);
      emit(SocialAppGetPostsSuccessState());
      // Parse the data into PostsModel
      return (data as List<dynamic>)
          .map((item) => PostsModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (error) {
      print('Error fetching posts: $error');
      emit(SocialAppGetPostsErrorState());
      return [];
    }
  }

  Future<List<PostsModel>> getPostId() async {
    try {
      final data = await supabase.from('posts').select('id');
      // Debug: Print the raw data
      print(data);
      // Parse the data into PostsModel
      return (data as List<dynamic>)
          .map((item) => PostsModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (error) {
      print('Error fetching posts: $error');
      return [];
    }
  }
  //List<PostsModel> posts = [];

  Future<void> fetchAndFillPosts() async {
    emit(SocialAppGetPostsLoadingState());
    try {
      final fetchedPosts = await getPosts();
      posts = fetchedPosts;
      for (var post in posts) {
        print(post);
        print(posts.length);
        emit(SocialAppGetPostsSuccessState());
      }
    } catch (error) {
      print('Error filling posts list: $error');
      emit(SocialAppGetPostsErrorState());
    }
  }

  void toggleLike({required int postId, required String userId}) async {
    emit(SocialAppToggleLikeLoadingState());
    try {
      final response = await supabase
          .from('likes')
          .select()
          .eq('post_id', postId)
          .eq('uId', userId);

      final List<dynamic> likes = response as List;

      if (likes.isNotEmpty) {
        await supabase
            .from('likes')
            .delete()
            .eq('post_id', postId)
            .eq('uId', userId);
        await supabase
            .rpc('decrement_likes_count_bigintt', params: {'post_id': postId});

        print('Like removed successfully.');
        emit(SocialAppUnlikeSuccessState());
      } else {
        await supabase.from('likes').insert({
          'post_id': postId,
          'uId': userId,
        });
        print('postId type: ${postId.runtimeType}');
        await supabase
            .rpc('increment_likes_count_bigintt', params: {'post_id': postId});

        print('Like added successfully.');
        emit(SocialAppLikeSuccessState());
      }
    } catch (error) {
      print('Error toggling like: $error');
      emit(SocialAppToggleLikeErrorState());
    }
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

  Future<void> getPostImage() async {
    try {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        postImage = File(pickedFile.path);
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

  void signOut(BuildContext context) async {
    try {
      await supabase.auth.signOut();
      print('User signed out successfully');

      // Navigate to the login screen or reset the app state
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SocialLoginScreen()),
      );
    } catch (error) {
      print('Error signing out: $error');
      // Handle the error, e.g., show a message to the user
    }
    uId = '';
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
