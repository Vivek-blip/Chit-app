import 'package:firebaseflutter2/Models/Planmodel.dart';
import 'package:flutter/material.dart';
import 'package:firebaseflutter2/Services/Firebaseregis.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Dropdownscreen extends StatefulWidget {
  final Function selectedplan;
  Dropdownscreen(this.selectedplan);
  @override
  _DropdownscreenState createState() => _DropdownscreenState();
}

class _DropdownscreenState extends State<Dropdownscreen> {
  
  String selected="Select plan";


  List<DropdownMenuItem<String>> planlistMaker(List<plan> data){
    
    List<DropdownMenuItem<String>> items=[];
    for(plan docs in data){
      items.add(
        DropdownMenuItem<String>(
              value: docs.chitPlan,
              child: Text(docs.chitPlan,style: TextStyle(fontSize:20),),
            ),
      );
    }
    return items;

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Registration().dropdownplans() ,
      builder: (context,AsyncSnapshot snapshot){
        if(snapshot.data==null){
          return Container(
            height: 20,
            width: 100,
            child: SpinKitThreeBounce(color: Colors.white,),
          );
        }
        return DropdownButton<String>(
          
          hint: Text(selected,style: TextStyle(fontSize:25,color:Colors.grey[200]),),
          onChanged: (value){
            setState(() {
              selected=value;
              widget.selectedplan(selected);
            });
          },
          items: planlistMaker(snapshot.data)
        );
      },
    );
  }
}