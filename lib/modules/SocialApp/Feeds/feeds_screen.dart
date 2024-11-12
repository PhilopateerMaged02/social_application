import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Stack(alignment: AlignmentDirectional.bottomCenter, children: [
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
                  color: Colors.blue[300],
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ]),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => buildPostItem(context),
              separatorBuilder: (context, index) => SizedBox(
                    height: 2,
                  ),
              itemCount: 10)
        ],
      ),
    );
  }

  Widget buildPostItem(context) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        "https://img.freepik.com/free-photo/portrait-sad-young-student-getting-bullied-school_23-2151395774.jpg?ga=GA1.1.960460351.1727711267"),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Philopateer Maged",
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
                      "January 21 , 2025 at 11:00 AM",
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
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Container(
                      height: 20,
                      child: MaterialButton(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        minWidth: 1,
                        onPressed: () {},
                        child: Text(
                          "#software",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                      child: MaterialButton(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        minWidth: 1,
                        onPressed: () {},
                        child: Text(
                          "#software",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                      child: MaterialButton(
                        minWidth: 1,
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        onPressed: () {},
                        child: Text(
                          "#software",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                      child: MaterialButton(
                        minWidth: 1,
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        onPressed: () {},
                        child: Text(
                          "#software_development",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                      child: MaterialButton(
                        minWidth: 1,
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        onPressed: () {},
                        child: Text(
                          "#software_development",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                      child: MaterialButton(
                        minWidth: 1,
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        onPressed: () {},
                        child: Text(
                          "#software_development",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://img.freepik.com/free-photo/young-person-presenting-empty-copyspace_1048-17665.jpg?t=st=1730484096~exp=1730487696~hmac=7afe40a7acc60e1aa9da996993a72531dc58e72793f9889f63eb83f14920a88e&w=1480"),
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
                    onTap: () {},
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
                          "1.2k",
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
                    onTap: () {},
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
                          "521",
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
                        "https://img.freepik.com/free-photo/portrait-sad-young-student-getting-bullied-school_23-2151395774.jpg?ga=GA1.1.960460351.1727711267"),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Write a Comment...",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      SocialAppCubit.get(context).getBucket();
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
                  InkWell(
                    onTap: () async {
                      final bucket = await SocialAppCubit.get(context)
                          .getBuckets("social");
                      if (bucket != null) {
                        print('Bucket retrieved successfully: ${bucket.name}');
                      } else {
                        print('Bucket not found or an error occurred.');
                      }
                    },
                    child: Row(
                      children: [
                        Icon(
                          IconlyBroken.upload,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Share",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
