import 'package:firebaseflutter2/Models/Planmodel.dart';
import 'package:flutter/material.dart';
import 'package:firebaseflutter2/Services/Firebaseregis.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Dropdownscreen extends StatefulWidget {
  final Function selectedplan;
  Dropdownscreen(this.selectedplan);
  @override
  _DropdownscreenState createState() => _DropdownscreenState();
}

class _DropdownscreenState extends State<Dropdownscreen> {
  
  List selectedValue=["Select plan",-1];
  


  List<DropdownMenuItem<String>> dropdownMenuItem(List items){    // Function for making list of dropdownmenuitems for the dropdown to choose amount

    return items
          .map<DropdownMenuItem<String>>((val){
            return DropdownMenuItem<String>(
              value: val,
              child:Text('₹ $val',style: TextStyle(
                        fontSize: 20,color: Colors.blue[900]
                      ),),
            );
          }).toList();
  }

  List<Widget> planListMaker(data){
    List<Widget>lst=[];
    for(int i=0;i<data.length;i++){
      lst.add(
        Container(
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(10), color: Colors.blue[300],
                ),
                margin: EdgeInsets.only(top:5,left:2.5,right:2.5,bottom:5),
                height: MediaQuery.of(context).size.height/2.2,
                width: MediaQuery.of(context).size.width/2.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 5,),
                    Center(
                      child: Text(data[i].chitPlan,style: TextStyle(
                        fontSize: 21,color: Colors.white,fontWeight: FontWeight.bold
                      ),),
                    ),
                    SizedBox(height: 15,),
                    Text(' Total amount :',style: TextStyle(
                      fontSize: 16,color: Colors.grey[800]
                    ),),
                    Center(
                      child: DropdownButton<String>(
                        value: selectedValue[1]!=i?null:selectedValue[0],
                        hint: Text('Choose',style: TextStyle(
                          fontSize: 20,color: Colors.blue[900]
                        ),),
                        icon: Icon(Icons.arrow_downward,color: Colors.white,),
                        iconSize: 18,
                        elevation: 15,
                        underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String val){
                            setState(() {
                              selectedValue[0]=val;
                              selectedValue[1]=i;
                              print(val);
                            });
                          },
                          items: dropdownMenuItem(data[i].amount),
                      )
                    ),
                    SizedBox(height: 10,),
                    Text(' Monthly amount :',style: TextStyle(
                      fontSize: 16,color: Colors.grey[800]
                    ),),
                    Center(
                      child: Text('₹ ${data[i].monthlyAmt}',style: TextStyle(
                        fontSize: 20,color: Colors.blue[900]
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Text(' Tenor :',style: TextStyle(
                      fontSize: 16,color: Colors.grey[800]
                    ),),
                    Center(
                      child: Text('${data[i].tenor} months',style: TextStyle(
                        fontSize: 20,color: Colors.blue[900]
                      ),),
                    ),
                    SizedBox(height: 8,),
                    MaterialButton(
                      height: 30,
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                      color: Colors.greenAccent,
                      onPressed: (){
                        if(selectedValue[1]==i){
                        widget.selectedplan(data[i].chitPlan,selectedValue[0]);
                        Navigator.pop(context);
                        }
                      },
                      child: Text('Select',style:TextStyle(color: Colors.white,fontSize:17)),
                    ),
                  ],
                ),
              )
      );
    }
    return lst;

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Registration().dropdownplans() ,
      builder: (BuildContext context,AsyncSnapshot snapshot){
        if(snapshot.data==null){
          return Container(
            height: 20,
            width: 100,
            child: SpinKitThreeBounce(color: Colors.blue,),
          );
        }
        return SingleChildScrollView(
          scrollDirection:Axis.horizontal,
          child:Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:planListMaker(snapshot.data)
          )
        );
      },
    );
  }
}