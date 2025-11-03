import 'package:flutter/material.dart';

class MakePost extends StatefulWidget {
  const MakePost({super.key});

  @override
  State<MakePost> createState() => _MakePostState();
}

class _MakePostState extends State<MakePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
            child: ElevatedButton(onPressed: () {}, child: Text('Post')),
          ),
        ],
      ),
      body: Column(
        children: [
          CircleAvatar(),
          Expanded(
            child: TextField(
              decoration: InputDecoration(hintText: "Let's Discuss"),
            ),
          ),
        ],
      ),
    );
  }
}
