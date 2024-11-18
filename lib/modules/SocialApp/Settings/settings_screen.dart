import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/modules/SocialApp/EditProfile/edit_profile_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (SocialAppCubit.get(context).userModel == null) {
          return Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                        image: NetworkImage(
                            SocialAppCubit.get(context).userModel!.cover),
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
                            backgroundImage: NetworkImage(
                                '${SocialAppCubit.get(context).userModel!.image}'),
                          ),
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                '${SocialAppCubit.get(context).userModel!.name}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                '${SocialAppCubit.get(context).userModel!.bio}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '100',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Posts',
                          style: TextStyle(color: Colors.grey[600]),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '1.5k',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Likes',
                          style: TextStyle(color: Colors.grey[600]),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '520',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Share',
                          style: TextStyle(color: Colors.grey[600]),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '3.5k',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Follow',
                          style: TextStyle(color: Colors.grey[600]),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(
                              BorderSide(color: Colors.grey, width: .5)),
                        ),
                        child: Text(
                          "Add Photos",
                          style: TextStyle(color: Colors.blue),
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        navigateTo(context, EditProfileScreen());
                      },
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            BorderSide(color: Colors.grey, width: .5)),
                      ),
                      child: Icon(
                        IconlyBroken.edit,
                        color: Colors.blue,
                      )),
                ],
              ),
              Spacer(),
              defaultButton(
                  function: () {
                    SocialAppCubit.get(context).signOut(context);
                  },
                  text: "Log Out"),
            ],
          ),
        );
      },
    );
  }
}
