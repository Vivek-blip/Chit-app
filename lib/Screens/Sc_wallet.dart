import 'package:flutter/material.dart';

class Sc_wallet extends StatefulWidget {
  @override
  _Sc_walletState createState() => _Sc_walletState();
}

class _Sc_walletState extends State<Sc_wallet> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          CircleAvatar(
            backgroundColor: Color(0x5f86a6df),
            radius: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "₹ ",
                  style: TextStyle(color: Colors.grey[100], fontSize: 30),
                ),
                Text(
                  "0",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Earned",
            style: TextStyle(color: Colors.grey[200], fontSize: 20),
          )
        ],
      ),
    );
  }
}
