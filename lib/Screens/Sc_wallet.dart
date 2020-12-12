import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseflutter2/Models/User.dart';
import 'package:firebaseflutter2/Services/Database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Sc_wallet extends StatefulWidget {
  final String uid;
  Sc_wallet(this.uid);
  @override
  _Sc_walletState createState() => _Sc_walletState();
}

class _Sc_walletState extends State<Sc_wallet> {
  @override
  initState() {
    super.initState();
    fetchWalletData(widget.uid);
  }

  List<Widget> listOfWidgets = [
    Center(
      child: SpinKitCircle(
        color: Colors.white,
        size: 50,
      ),
    )
  ];

  fetchWalletData(String uid) async {
    List data = await DatabaseService().fetchWalletInfo(uid);
    if (data == null) {
      setState(() {
        listOfWidgets = [
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
            height: 8,
          ),
          Center(
            child: Text(
              "Earned",
              style: TextStyle(color: Colors.grey[200], fontSize: 20),
            ),
          ),
        ];
      });
    } else {
      int sum = sumofAllAmounts(data);
      listOfWidgets = [
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
                sum.toString(),
                style: TextStyle(color: Colors.white, fontSize: 30),
              )
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Center(
          child: Text(
            "Earned",
            style: TextStyle(color: Colors.grey[200], fontSize: 20),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ];
      maketransactionCards(data);
    }
  }

  List<Widget> maketransactionCards(List data) {
    data.forEach((element) {
      // Timestamp timestamp = element['timestamp'];
      // print("haaa ${element['timestamp']}");
      var date = element['timestamp'].toDate();
      String formatedDate = DateFormat("dd-MM-yy").format(date);
      print(formatedDate);
      listOfWidgets.add(Container(
        height: 70,
        child: Card(
          color: Color(0x5f86a6df),
          child: ListTile(
            leading: Text("₹ ${element['amount']}",
                style: TextStyle(color: Colors.white, fontSize: 30)),
            subtitle: Text("Chit no: ${element['chitno']}",
                style: TextStyle(color: Colors.white, fontSize: 15)),
            trailing: Text(formatedDate,
                style: TextStyle(color: Colors.grey[350], fontSize: 20)),
          ),
        ),
      ));
    });
    setState(() {});
  }

  int sumofAllAmounts(List data) {
    int sum = 0;
    data.forEach((element) {
      sum += int.parse(element["amount"]);
    });
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(children: listOfWidgets),
    );
  }
}
