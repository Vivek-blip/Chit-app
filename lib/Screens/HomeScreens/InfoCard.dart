import 'package:firebaseflutter2/Models/User.dart';
import 'package:flutter/material.dart';

import 'UploadReciept.dart';

class InfoCard extends StatefulWidget {
  final UserData userData;
  InfoCard({this.userData});
  @override
  _InfoCardState createState() => _InfoCardState(userData);
}

class _InfoCardState extends State<InfoCard> {
  UserData userData;
  _InfoCardState(this.userData);

  List<Widget> generateTextWigits() {
    List<Widget> list = [];
    for (int i = 0; i < userData.chit_nos.length; i++) {
      list.add(Text("${userData.chit_nos[i]}"));
    }
    return list;
  }

  List<bool> generateIsselctedList() {
    List<bool> list = [];
    for (int i = 0; i < userData.chit_nos.length; i++) {
      if (i == 0) {
        list.add(true);
      } else {
        list.add(false);
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.09,
        height: MediaQuery.of(context).size.height / 2.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Color(0xff283747)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black,
                    backgroundImage: AssetImage(
                      "Assets/AppIcon.jpeg",
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 35,
                  ),
                  Text(
                    userData.chit_type,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 15,
                  ),
                  MaterialButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.fromLTRB(1, 1, 4, 1),
                    color: Colors.grey[400].withOpacity(0.1),
                    onPressed: () {},
                    child: Text(
                      "accounts >",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 70,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Chit number",
                    style: TextStyle(color: Colors.grey[400], fontSize: 15),
                  ),
                  MaterialButton(
                    elevation: 0,
                    padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      "Upload receipt",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue[400],
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              UploadRecieptScrn()));
                    },
                  )
                ],
              ),
            ),
            userData.type == "bhagyachit"
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 5, 8, 15),
                        child: SizedBox(
                          height: 40,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ToggleButtons(
                              borderWidth: 5,
                              fillColor: Colors.blue[200].withOpacity(0.1),
                              textStyle: TextStyle(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              children: generateTextWigits(),
                              isSelected: generateIsselctedList(),
                              onPressed: (index) {
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    height: 1,
                    width: 1,
                  ),
            Divider(
              color: Colors.grey[300],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Plan",
                        style: TextStyle(color: Colors.grey[400], fontSize: 15),
                      ),
                      Text(
                        userData.chit_type,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 80,
                      ),
                      Text(
                        "principal amount",
                        style: TextStyle(color: Colors.grey[400], fontSize: 15),
                      ),
                      Text(
                        userData.amount,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 80,
                      ),
                      Text(
                        "EMI",
                        style: TextStyle(color: Colors.grey[400], fontSize: 15),
                      ),
                      Text(
                        userData.monthlyAmt,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "expires on",
                        style: TextStyle(color: Colors.grey[400], fontSize: 15),
                      ),
                      Text(
                        "12-10-2020",
                        style: TextStyle(color: Colors.grey[400], fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
