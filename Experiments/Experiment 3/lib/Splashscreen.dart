import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Splashscreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book store"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Hello World"),
          SizedBox(
            height: 20,
          ),
          Image.network(
            "https://images.app.goo.gl/pA6SbgMKyZYuEfWu5",
            height: 200,
            width: 200,
          )
        ],
      )),
    );
  }
}
