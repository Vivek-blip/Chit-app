import 'dart:io';
import 'package:firebaseflutter2/Services/Database.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UploadRecieptScrn extends StatefulWidget {
  @override
  _UploadRecieptScrnState createState() => _UploadRecieptScrnState();
}

class _UploadRecieptScrnState extends State<UploadRecieptScrn> {
  final GlobalKey<ScaffoldState> key=GlobalKey<ScaffoldState>();
  String imagePath;
  File result;
  bool loading=false;

  void pickImage()async{
    String selectedimage = await FilePicker.getFilePath(type: FileType.image);
    print(selectedimage);
    setState(() {
      imagePath=selectedimage;
    });
  }

  Future<File> imageCompressor()async{
    File file=File(imagePath);
    String filename=imagePath.split('/').last;
    String targetfile=imagePath.split(filename)[0];
    print(targetfile);
    print('b4 compression- ${file.lengthSync()}');
    File result=await FlutterNativeImage.compressImage(imagePath,quality: 90);
    print('after compression- ${result.lengthSync()}');
    return result;
    

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text('Upload Reciept'),
        centerTitle: true,
      ),
      body: Container(
        child: imagePath==null?Center(
          child:Text('Select an image',style:TextStyle(
            color:Colors.grey[500],
            fontSize:22
          ))
        ):Center(
          child: FutureBuilder<File>(
            future: imageCompressor(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(snapshot.data==null){
                return SpinKitChasingDots(color: Colors.blue,);
              }
              else{
                return Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height/1.9,
                      width: MediaQuery.of(context).size.width,
                      child: Image.file(snapshot.data)),
                      RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(10))),
                        color: Colors.blue,
                        child: loading?SpinKitCircle(color:Colors.white): Text('Upload',style:TextStyle(
                          color:Colors.white,fontSize:20
                        )),
                        onPressed: ()async{
                          setState(() {
                            loading=true;
                          });
                          String state=await DatabaseService().uploadRecieptFile(snapshot.data);
                          setState(() {
                            loading=false;
                            imagePath=null;
                          });
                          if(state=='uploaded'){
                            key.currentState.showSnackBar(
                              SnackBar(
                              content: Text('Reciept uploaded ✔'),
                              duration: Duration(milliseconds: 1000),
                            )
                            );
                            
                          }else{
                            key.currentState.showSnackBar(
                              SnackBar(
                              key: key,
                              content: Text('Somthing went wrong...check your internet connection'),
                              duration: Duration(milliseconds: 1000),
                            )
                            );
                          }
                        },
                      )
                  ],
                );
              }
            }
            ),
            ),
          ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Select Image',
        onPressed: pickImage,
      ),
    );
  }
}