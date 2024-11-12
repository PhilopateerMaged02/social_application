import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var nameController = TextEditingController();
        var bioController = TextEditingController();
        var phoneController = TextEditingController();
        var profileImage = SocialAppCubit.get(context).profileImage;
        var coverImage = SocialAppCubit.get(context).coverImage;
        nameController.text = SocialAppCubit.get(context).userModel!.name;
        bioController.text = SocialAppCubit.get(context).userModel!.bio;
        phoneController.text = SocialAppCubit.get(context).userModel!.phone;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(IconlyBroken.arrowLeft2),
            ),
            title: Text(
              "Edit Profile",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    SocialAppCubit.get(context).uploadProfile(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text);
                  },
                  child: Text(
                    "UPDATE",
                    style: TextStyle(color: Colors.blue),
                  )),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (state is SocialAppUpdateUserLoadingState)
                  LinearProgressIndicator(
                    color: Colors.blue,
                  ),
                SizedBox(
                  height: 10,
                ),
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            width: double.infinity,
                            height: 200,
                            child: Image(
                              image: coverImage == null
                                  ? NetworkImage(SocialAppCubit.get(context)
                                      .userModel!
                                      .cover)
                                  : FileImage(coverImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -50,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CircleAvatar(
                                radius: 65,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage(
                                          '${SocialAppCubit.get(context).userModel!.image}')
                                      : FileImage(profileImage),
                                ),
                                backgroundColor: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 230,
                          top: 190,
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: IconButton(
                              onPressed: () {
                                SocialAppCubit.get(context).getProfileImage();
                              },
                              icon: Icon(
                                IconlyBroken.camera,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: IconButton(
                          onPressed: () {
                            SocialAppCubit.get(context).getCoverImage();
                          },
                          icon: Icon(
                            IconlyBroken.camera,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 55,
                ),
                defaultFormField(
                    controller: nameController,
                    input: TextInputType.name,
                    onValidator: (value) {
                      if (value!.isEmpty) {
                        return "Name must not be Empty";
                      }
                      return null;
                    },
                    text: "Name",
                    prefix: IconlyBroken.user2),
                SizedBox(
                  height: 20,
                ),
                defaultFormField(
                    controller: bioController,
                    input: TextInputType.name,
                    onValidator: (value) {
                      if (value!.isEmpty) {
                        return "Bio must not be Empty";
                      }
                      return null;
                    },
                    text: "Bio",
                    prefix: IconlyBroken.edit),
                SizedBox(
                  height: 20,
                ),
                defaultFormField(
                    controller: phoneController,
                    input: TextInputType.phone,
                    onValidator: (value) {
                      if (value!.isEmpty) {
                        return "Phone must not be Empty";
                      }
                      return null;
                    },
                    text: "Phone",
                    prefix: IconlyBroken.call),
              ],
            ),
          ),
        );
      },
    );
  }
}
