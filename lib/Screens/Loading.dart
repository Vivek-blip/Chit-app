import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.indigo[400],Colors.blue[400]],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight
              )
          ),
      child: Center(
        child: SpinKitPulse(
          color: Colors.white,
          size: 300,
        ),
      ),
    );
  }
}
