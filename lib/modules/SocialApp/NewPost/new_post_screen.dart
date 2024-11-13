import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class NewPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
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
            SizedBox(
              height: 10,
            ),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      "https://img.freepik.com/free-photo/portrait-sad-young-student-getting-bullied-school_23-2151395774.jpg?ga=GA1.1.960460351.1727711267"),
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
                maxLines: 22),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
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
                            color: Colors.blue, fontWeight: FontWeight.w800),
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
                            color: Colors.blue, fontWeight: FontWeight.w800),
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
  }
}
