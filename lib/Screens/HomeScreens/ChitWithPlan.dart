import 'dart:ui';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebaseflutter2/Models/User.dart';
import 'package:firebaseflutter2/Models/Planmodel.dart';
import 'package:flutter/material.dart';
import 'package:firebaseflutter2/Services/Firebaseregis.dart';
import 'package:provider/provider.dart';

class ChitWithPlanViewPg extends StatefulWidget {
  final UserData snapshot;
  ChitWithPlanViewPg({this.snapshot});
  @override
  _ChitWithPlanViewPgState createState() => _ChitWithPlanViewPgState(snapshot);
}

class _ChitWithPlanViewPgState extends State<ChitWithPlanViewPg> {
  UserData snapshot;
  List widget_data = [0, 0];
  List<plan> _chachedplans = [];
  String _selectedAmt = '';
  bool _loading = false;
  String _submitButtonText = 'Submit';
  _ChitWithPlanViewPgState(this.snapshot);
  int bhagya_chit_quantity = 3;

  String termsAndConditions =
      '''Chit due has to be paid before 10th every month. If not, you will not be able to participate in the Chit of that month. 

Chit draw winning amount will be paid to you by cash or bank transfer within 3 working days. 

The Chit amount will be credited to the account number given in the Cheque Leaf. 

Winners of the Bhagya chit monthly draw can withdraw the entire chit amount. 

In case of non-withdrawal, only half of the monthly installment will need to be paid in the subsequent months. 

Nonwithdrawn money will be paid in the month in which the Bhagya Chit ends, 

A person can participate in minimum 3 chits and maximum no limit. 

The Chit amount will be credited to the account number given in the Cheque Leaf. 

 6 chit draws are conducted in a month. 

Individuals withdrawing the Bhagya Chit amount are required to provide two cheque leaves as collateral. 

        (Not applicable for non-withdrawals)''';

  fetchPlansFromDatabase() async {
    if (_chachedplans.isEmpty) {
      return _chachedplans = await Registration().dropdownplans();
    } else {
      return _chachedplans;
    }
  }

  List<DropdownMenuItem<String>> dropdownMenuItem(List items) {
    // Function for making list of dropdownmenuitems for the dropdown to choose amount

    return items.map<DropdownMenuItem<String>>((val) {
      return DropdownMenuItem<String>(
        value: val,
        child: Text(
          '₹ $val',
          style: TextStyle(fontSize: 20, color: Colors.limeAccent),
        ),
      );
    }).toList();
  }

  void addquantity() {
    if (bhagya_chit_quantity < 10) {
      setState(() {
        bhagya_chit_quantity += 1;
      });
    }
  }

  void subtractquantity() {
    if (bhagya_chit_quantity > 3) {
      setState(() {
        bhagya_chit_quantity -= 1;
      });
    }
  }

  Widget termsAndCondDialog(User user, int _index, BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 0),
      title: Text("Terms & Conditions"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text(termsAndConditions),
            RaisedButton(
                color: Colors.green[400],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: _loading
                    ? SpinKitCircle(
                        color: Colors.white,
                      )
                    : Text("Accept",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                onPressed: () async {
                  Navigator.of(context).pop();
                  if (!_loading) {
                    setState(() {
                      _loading = true;
                    });
                    dynamic result = await Registration().addSelectedPlanToUser(
                        user.uid,
                        _chachedplans[_index].chitPlan,
                        _selectedAmt.isEmpty
                            ? _chachedplans[_index].amount[0]
                            : _selectedAmt,
                        _chachedplans[_index].type == "edmchit"
                            ? "edmchit"
                            : "bhagyachit",
                        bhagya_chit_quantity.toString());

                    if (result == 'Sucess') {
                      setState(() {
                        _loading = false;
                      });
                    } else {
                      setState(() {
                        _loading = false;
                        _submitButtonText = 'Retry';
                      });
                    }
                  }
                })
          ],
        ),
      ),
    );
  }

  Widget containerWidgetSwitcher(User user) {
    if (widget_data[0] == 0) {
      return Column(
        key: UniqueKey(),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text('Select a plan to continue',
              style: TextStyle(color: Colors.white, fontSize: 25)),
          SizedBox(
            height: 20,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            child: FutureBuilder(
              future: fetchPlansFromDatabase(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return SpinKitChasingDots(
                    color: Colors.white,
                  );
                } else if (snapshot.data.length == 0) {
                  return Text('No plans are currently available',
                      style: TextStyle(color: Colors.white));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, i) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.blue.withOpacity(0.2),
                        child: ListTile(
                          subtitle: Text(
                              'Tenor - expires on ${snapshot.data[i].tenor}',
                              style: TextStyle(color: Colors.white)),
                          title: Text(snapshot.data[i].chitPlan,
                              style: TextStyle(color: Colors.white)),
                          trailing: Icon(
                            Icons.chevron_right,
                            size: 30,
                          ),
                          onTap: () {
                            setState(() {
                              _selectedAmt = '';
                              widget_data[0] = 1;
                              widget_data[1] = i;
                            });
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      );
    } else {
      int _index = widget_data[1];
      return Column(
        key: UniqueKey(),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
                onPressed: () {
                  if (!_loading) {
                    setState(() {
                      widget_data[0] = 0;
                    });
                  }
                },
              ),
              SizedBox(
                width: 1,
              ),
            ],
          ),
          SizedBox(
            height: 1,
          ),
          Text(_chachedplans[_index].chitPlan,
              style: TextStyle(color: Colors.white, fontSize: 25)),
          Container(
            width: 70,
            color: Colors.purple,
            height: 3,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width / 1.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.black.withOpacity(0.2),
            ),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Principal amount - ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    _chachedplans[_index].type == "edmchit"
                        ? DropdownButton<String>(
                            dropdownColor: Colors.blue[300],
                            value: _selectedAmt.isEmpty
                                ? _chachedplans[_index].amount[0]
                                : _selectedAmt,
                            icon: Icon(
                              Icons.expand_more,
                              color: Colors.white,
                            ),
                            iconSize: 20,
                            underline: Container(
                              width: 50,
                              height: 2,
                              color: Colors.red,
                            ),
                            onChanged: (String val) {
                              if (!_loading) {
                                setState(() {
                                  _selectedAmt = val;
                                });
                              }
                            },
                            items:
                                dropdownMenuItem(_chachedplans[_index].amount),
                          )
                        : Text(
                            '₹ ${_chachedplans[_index].amount[0]}',
                            style: TextStyle(
                                fontSize: 20, color: Colors.limeAccent),
                          ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _chachedplans[_index].type == "edmchit"
                          ? "EMI - "
                          : 'Quantity - ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                    _chachedplans[_index].type == "edmchit"
                        ? SizedBox(
                            height: 0,
                            width: 0,
                          )
                        : FloatingActionButton(
                            mini: true,
                            onPressed: addquantity,
                            child: new Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            backgroundColor: Colors.white,
                          ),
                    Text(
                      _chachedplans[_index].type == "edmchit"
                          ? '₹ ${_chachedplans[_index].eMI}'
                          : "${bhagya_chit_quantity.toString()}",
                      style: TextStyle(
                          color: Colors.limeAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                    _chachedplans[_index].type == "edmchit"
                        ? SizedBox(
                            height: 0,
                            width: 0,
                          )
                        : FloatingActionButton(
                            mini: true,
                            onPressed: subtractquantity,
                            child: new Icon(
                              Icons.remove,
                              color: Colors.black,
                            ),
                            backgroundColor: Colors.white,
                          ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                RaisedButton(
                  color: Colors.green[400],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: _loading
                      ? SpinKitCircle(
                          color: Colors.white,
                        )
                      : Text(_submitButtonText,
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext acontext) {
                          return termsAndCondDialog(user, _index, acontext);
                        });

                    // if (!_loading) {
                    //   setState(() {
                    //     _loading = true;
                    //   });
                    //   dynamic result = await Registration()
                    //       .addSelectedPlanToUser(
                    //           user.uid,
                    //           _chachedplans[_index].chitPlan,
                    //           _selectedAmt.isEmpty
                    //               ? _chachedplans[_index].amount[0]
                    //               : _selectedAmt,
                    //           _chachedplans[_index].type == "edmchit"
                    //               ? "edmchit"
                    //               : "bhagyachit",
                    //           bhagya_chit_quantity.toString());

                    //   if (result == 'Sucess') {
                    //     setState(() {
                    //       _loading = false;
                    //     });
                    //   } else {
                    //     setState(() {
                    //       _loading = false;
                    //       _submitButtonText = 'Retry';
                    //     });
                    //   }
                    // }
                  },
                )
              ],
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.indigo[400], Colors.blue[400]],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: Stack(
        alignment:
            AlignmentGeometry.lerp(Alignment.center, Alignment.center, 20),
        children: <Widget>[
          Center(
            child: Container(
                padding: EdgeInsets.fromLTRB(6, 6, 6, 0),
                height: MediaQuery.of(context).size.height / 1.2,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Text(
                        "Welcome ${snapshot.name}",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.8,
                            fontSize: 30),
                      ),
                    ),
                    Image(
                      image: AssetImage("Assets/home page.png"),
                    ),
                  ],
                )),
          ),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
              child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width / 1.2,
                  color: Colors.white.withOpacity(0.2),
                  child: AnimatedSwitcher(
                    child: containerWidgetSwitcher(user),
                    duration: Duration(milliseconds: 500),
                    reverseDuration: Duration(milliseconds: 300),
                    switchInCurve: Curves.fastOutSlowIn,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  )),
            ),
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ],
      ),
    );
  }
}
