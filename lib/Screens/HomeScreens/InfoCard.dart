import 'package:firebaseflutter2/Models/User.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'UploadReciept.dart';

class InfoCard extends StatefulWidget {
  final UserData userData;
  final String uid;
  InfoCard({this.userData, this.uid});
  @override
  _InfoCardState createState() => _InfoCardState(userData);
}

class _InfoCardState extends State<InfoCard> {
  UserData userData;
  _InfoCardState(this.userData);
  int selectedChitNo = 0;
  List<bool> chitToggleList = [];

  List<Widget> generateTextWigits() {
    List<Widget> list = [];
    for (int i = 0; i < userData.chit_nos.length; i++) {
      list.add(Text("${userData.chit_nos[i]}"));
    }
    List<bool> _lst = [];
    for (int i = 0; i < userData.chit_nos.length; i++) {
      if (i == selectedChitNo) {
        _lst.add(true);
      } else {
        _lst.add(false);
      }
    }
    chitToggleList = _lst;
    return list;
  }

  // List<bool> generateIsselctedList() {
  //   for (int i = 0; i < userData.chit_nos.length; i++) {
  //     if (i == 0) {
  //       chitToggleList.add(true);
  //     } else {
  //       chitToggleList.add(false);
  //     }
  //   }
  //   return chitToggleList;
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            width: MediaQuery.of(context).size.width / 1.09,
            height: MediaQuery.of(context).size.height / 2.21,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Color(0xff283747)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 200),
                  child: MaterialButton(
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
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 80,
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
                                  isSelected: chitToggleList,
                                  onPressed: (index) {
                                    setState(() {
                                      selectedChitNo = index;
                                    });
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
                SizedBox(
                  height: MediaQuery.of(context).size.height / 80,
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
                            "principal amount",
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 15),
                          ),
                          Text(
                            "₹${userData.amount}",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 80,
                          ),
                          Text(
                            "EMI",
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 15),
                          ),
                          Text(
                            "₹${userData.monthlyAmt}",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "expires on",
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 15),
                          ),
                          Text(
                            userData.chit_validity,
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 29.5,
                ),
              ],
            )),
        MaterialButton(
          elevation: 0,
          minWidth: MediaQuery.of(context).size.width / 1.09,
          height: MediaQuery.of(context).size.height / 17,
          padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Text(
            "Upload receipt",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.normal),
          ),
          color: Colors.green[800],
          onPressed: () async {
            String _url = "https://forms.gle/h9k4U4aNRYr5DTKN8";
            if (await canLaunch(_url)) {
              await launch(_url);
            }
          },
        )
      ],
    );
  }
}
