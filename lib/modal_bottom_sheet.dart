import 'package:flutter/material.dart';

class ModalBottomSheetDemo extends StatelessWidget {
  const ModalBottomSheetDemo({super.key});

  @override
  Widget build(BuildContext context) {
    void bottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        // barrierColor: Colors.blueAccent,
        // backgroundColor: Colors.yellow,
        builder: (BuildContext context) {
          return SizedBox(
            width: double.infinity,
            child: Column(children: [Text("Hello")]),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: Text("Chats"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),

      body: Center(
        child: ElevatedButton(
          onPressed: () {
            bottomSheet(context);
          },
          child: Text("Click Me"),
        ),
      ),
    );



  }
}
