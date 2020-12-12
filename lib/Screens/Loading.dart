import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff1B2631),
      child: Center(
        child: SpinKitPulse(
          color: Colors.white,
          size: 300,
        ),
      ),
    );
  }
}

class UpdateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff1B2631),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Please update the app",
              style: TextStyle(color: Colors.white, fontSize: 25),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "(new verison available)",
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              color: Color(0xff283747),
              onPressed: () async {
                String _url =
                    "https://play.google.com/store/apps/details?id=com.edm.flutter&hl=en-GB";
                if (await canLaunch(_url)) {
                  await launch(_url);
                }
              },
              child: Text(
                "Update",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        )),
      ),
    );
  }
}
