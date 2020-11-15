import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  String fileUrl;
  ImageContainer({this.fileUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          child: Image.network(
            "$fileUrl",
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Container(
                  height: 50, width: 50, child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
