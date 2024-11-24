import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class NewPostScreen extends StatefulWidget {
  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(IconlyBroken.arrowLeft2)),
            backgroundColor: Colors.white,
            title: Text(
              "Create Post",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  final cubit = SocialAppCubit.get(context);

                  if (cubit.postImage == null) {
                    // No image, directly insert into the table
                    cubit.insertIntoTable(
                      name: cubit.userModel!.name,
                      dateTime: DateTime.now().toString(),
                      image: cubit.userModel!.image,
                      text: textController.text,
                      uId: cubit.userModel!.uId,
                    );
                    setState(() {
                      SocialAppCubit.get(context).fetchAndFillPosts();
                    });
                    Navigator.pop(context);
                  } else {
                    await cubit.uploadImagePost(); // Ensure it's awaited
                    cubit.insertIntoTable(
                      name: cubit.userModel!.name,
                      dateTime: DateTime.now().toString(),
                      image: cubit.userModel!.image,
                      text: textController.text,
                      postImage:
                          cubit.postImageURL, // Use the uploaded image URL
                      uId: cubit.userModel!.uId,
                    );
                    setState(() {
                      SocialAppCubit.get(context).fetchAndFillPosts();
                    });
                    Navigator.pop(context);
                    //SocialAppCubit.get(context).postImageURL = null;
                  }
                },
                child: Text(
                  "POST",
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (state is SocialAppCreatePostLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialAppCreatePostLoadingState)
                  SizedBox(
                    height: 15,
                  ),
                Row(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          SocialAppCubit.get(context).userModel!.image),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              SocialAppCubit.get(context).userModel!.name,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.verified,
                              size: 20,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        Text(
                          "Public",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "What is on your mind?",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    //minLines: 3,
                    maxLines: 10),
                SizedBox(
                  height: 80,
                ),
                if (SocialAppCubit.get(context).postImage != null)
                  Container(
                    height: 150,
                    child: Stack(
                      fit: StackFit.loose,
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Image(
                          image:
                              FileImage(SocialAppCubit.get(context).postImage!),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: IconButton(
                              icon: Icon(Icons.close),
                              color: Colors.white,
                              onPressed: () {
                                setState(() {
                                  SocialAppCubit.get(context).postImage = null;
                                  SocialAppCubit.get(context).postImageURL =
                                      null;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        SocialAppCubit.get(context).getPostImage();
                      },
                      child: Row(
                        children: [
                          Icon(
                            IconlyBroken.image,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Add Image",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "# tags",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
