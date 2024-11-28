import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/models/posts/posts_model.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class FeedsScreen extends StatefulWidget {
  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  @override
  void initState() {
    super.initState();
  }

  // Function to handle the refresh action
  Future<void> _refreshPosts() async {
    // Trigger fetching the posts again
    setState(() async {
      await SocialAppCubit.get(context)
          .fetchAndFillPosts(); // Assuming getPosts fetches new posts from the server
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (BuildContext context, SocialAppStates state) {},
      builder: (BuildContext context, SocialAppStates state) {
        return RefreshIndicator(
          color: Colors.blue,
          onRefresh:
              _refreshPosts, // When pulled to refresh, it will trigger _refreshPosts
          child: ConditionalBuilder(
            condition: SocialAppCubit.get(context).posts.isNotEmpty &&
                SocialAppCubit.get(context).userModel != null,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image(
                              image: NetworkImage(
                                  "https://img.freepik.com/free-psd/3d-rendering-mike-pointing_23-2149312575.jpg?t=st=1730479823~exp=1730483423~hmac=91b43646b83d000bd6568d75fd4ee162f7f5e0b98e3fb245ed918bdeb314690e&w=1480"),
                              fit: BoxFit.cover,
                              height: 200,
                              width: double.infinity,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Text(
                              "Communicate with Friends Now",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ]),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildPostItem(
                            SocialAppCubit.get(context).posts[index], context),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 1,
                            ),
                        itemCount: SocialAppCubit.get(context).posts.length)
                  ],
                ),
              );
            },
            fallback: (BuildContext context) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.blue,
              ));
            },
          ),
        );
      },
    );
  }

  Widget buildPostItem(PostsModel postModel, context) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(postModel.image),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          postModel.name,
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
                      postModel.dateTime,
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600]),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
              ],
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey[300],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              child: Text(
                postModel.text,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            if (postModel.postImage != '')
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(postModel.postImage ?? ''),
                    ),
                  ),
                ),
              ),
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: InkWell(
                    child: Row(
                      children: [
                        Icon(
                          IconlyBroken.heart,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          postModel.postLikes.toString(),
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: InkWell(
                    child: Row(
                      children: [
                        Icon(
                          IconlyBroken.chat,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          "0",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          "comments",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey[300],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(
                        SocialAppCubit.get(context).userModel!.image),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  TextButton(
                    onPressed: () {
                      print(uId);
                    },
                    child: Text(
                      "Write a Comment...",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        SocialAppCubit.get(context).toggleLike(
                            postId: postModel.id.toInt(),
                            userId: postModel.uId);
                      });
                      print(postModel.id);
                    },
                    child: Row(
                      children: [
                        Icon(
                          IconlyBroken.heart,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Like",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
