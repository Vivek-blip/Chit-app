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
  
  String selected="Select plan";


  List<Widget> planListMaker(data){
    List<Widget>lst=[];
    for(int i=0;i<data.length;i++){
      lst.add(
        Container(
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(10), color: Colors.blue[300],
                ),
                margin: EdgeInsets.only(top:5,left:2.5,right:2.5,bottom:5),
                height: MediaQuery.of(context).size.height/2.7,
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
                      child: Text(data[i].amount,style: TextStyle(
                        fontSize: 20,color: Colors.red[300]
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Text(' Monthly amount :',style: TextStyle(
                      fontSize: 16,color: Colors.grey[800]
                    ),),
                    Center(
                      child: Text(data[i].monthlyAmt,style: TextStyle(
                        fontSize: 20,color: Colors.red[300]
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Text(' Tenor :',style: TextStyle(
                      fontSize: 16,color: Colors.grey[800]
                    ),),
                    Center(
                      child: Text('${data[i].tenor} months',style: TextStyle(
                        fontSize: 20,color: Colors.red[300]
                      ),),
                    ),
                    SizedBox(height: 8,),
                    MaterialButton(
                      height: 30,
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                      color: Colors.greenAccent,
                      onPressed: (){
                        widget.selectedplan(data[i].chitPlan);
                        Navigator.pop(context);
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