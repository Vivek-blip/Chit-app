import 'package:flutter/material.dart';
import 'package:firebaseflutter2/Services/Firebaseregis.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebaseflutter2/AuthScreens/Dropdown.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class RegisterPage extends StatefulWidget {
  final Function refrsh;
  RegisterPage({this.refrsh});
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with AutomaticKeepAliveClientMixin{
  String selectedplan;
  selextedPlan(String plan){
    setState(() {
      selectedplan=plan;
    });
    
  }

   @override
    bool get wantKeepAlive => true;

final adhaarno=TextEditingController();
final name=TextEditingController();
final password=TextEditingController();
final emailId=TextEditingController();
final accountbranch=TextEditingController();
final accountname=TextEditingController();
final accountnumber=TextEditingController();
final ifcCode=TextEditingController();
final mobno=TextEditingController();
final adress=TextEditingController();
final pincode=TextEditingController();
final city=TextEditingController();
final state=TextEditingController();
  final _formkey=GlobalKey<FormState>();
  final FirebaseMessaging _fmc=FirebaseMessaging();
  bool load=false;
  String errortext="";
  String notificationToken;

  //For saving notification token to database
  void fmcTokenFetcher()async{
    notificationToken=await _fmc.getToken();
  }

  @override
  void initState(){
    super.initState();
    fmcTokenFetcher();
  }
  
  Widget loadingSwitcher(){
    if(load==false){
      return MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                color: Colors.red[500],
                child: Text("Register",
                style: 
                TextStyle(
                fontSize: 20,color: Colors.white  
                ),),
                
                onPressed: ()async{
                  FocusScope.of(context).unfocus();
                  if(_formkey.currentState.validate()&&selectedplan!=null){
                    setState(() {
                      load=true;
                      errortext="";
                    });
                    print(password.text);
                    dynamic result=await Registration().registerNewUser(emailId.text, {
                      'password':password.text,
                      'name':name.text,
                      'accountbranch':accountbranch.text,
                      'accountname':accountname.text,
                      'accountnumber':accountnumber.text,
                      'ifccode':ifcCode.text,
                      'plan':selectedplan,
                      'mob no':mobno.text,
                      'adress':adress.text,
                      'pincode':pincode.text,
                      'city':city.text,
                      'state':state.text,
                      'adhaarno':adhaarno.text,
                      'fmcToken':notificationToken
                    });
                    if(result==null){
                      setState(() {
                        load=false;
                        errortext="Something went wrong";
                      });
                    }
                  }
                },
              );
    }
    else{
      return MaterialButton(onPressed: (){},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      color: Colors.red[500],
      child: Container(
        height: 20,
        width: 100,
        child: SpinKitThreeBounce(
          color: Colors.white,
        ),
      ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Create account"),
        leading: MaterialButton(
          onPressed: (){
            widget.refrsh();
          },
          child: Icon(Icons.arrow_back,color: Colors.white,),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(
          image: AssetImage("Assets/background.jpeg"),
          fit: BoxFit.fill,
          alignment: Alignment.bottomCenter
        )),
        padding: EdgeInsets.all(10),
        child: Center(
          child: Scaffold(
            // resizeToAvoidBottomInset: true,
              backgroundColor: Colors.transparent,
                    body: Form(
              key: this._formkey,
                      child: SingleChildScrollView(
                        
                child: Column(
                  children:<Widget>[
                    TextFormField(
                    style: TextStyle(fontSize: 20),
                    validator:(val)=>val.isEmpty ? "Cant be empty" : null,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(hintText: "Name",
                        contentPadding: EdgeInsets.symmetric(vertical: 13,horizontal: 10),
                        fillColor: Colors.blue[100],
                      filled: true,
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue[500],width: 2),
                          borderRadius: BorderRadius.circular(15),
                        )
                    ),
                    controller: name,
            
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    style: TextStyle(fontSize: 20),
                    validator:(val)=>val.isEmpty ? "Cant be empty" : null,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "e-mail ID",
                        contentPadding: EdgeInsets.symmetric(vertical: 13,horizontal: 10),
                        fillColor: Colors.blue[100],
                      filled: true,
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue[500],width: 2),
                          borderRadius: BorderRadius.circular(15),
                        )
                    ),
                    controller: emailId,

                  ),
                 
                  SizedBox(height: 30,),
                  TextFormField(
                    style: TextStyle(fontSize: 20),
                    validator:(val)=>val.length<8 ? "too short" : null,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "password",
                        contentPadding: EdgeInsets.symmetric(vertical: 13,horizontal: 10),
                        fillColor: Colors.blue[100],
                      filled: true,
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue[500],width: 2),
                          borderRadius: BorderRadius.circular(15),
                        )
                    ),
                    controller: password,
                   
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    style: TextStyle(fontSize: 20),
                    validator:(val)=>val.isEmpty ? "Cant be empty" : null,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "Bank account branch",
                        contentPadding: EdgeInsets.symmetric(vertical: 13,horizontal: 10),
                        fillColor: Colors.blue[100],
                      filled: true,
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue[500],width: 2),
                          borderRadius: BorderRadius.circular(15),
                        )
                    ),
                    controller: accountbranch,
                    
                  ),
                
                  SizedBox(height: 30,),
                  TextFormField(
                    style: TextStyle(fontSize: 20),
                    validator:(val)=>val.isEmpty ? "Cant be empty" : null,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "Bank account name",
                        contentPadding: EdgeInsets.symmetric(vertical: 13,horizontal: 10),
                        fillColor: Colors.blue[100],
                      filled: true,
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue[500],width: 2),
                          borderRadius: BorderRadius.circular(15),
                        )
                    ),
                    controller: accountname,
                  
                  ),
                  SizedBox(height: 23,),
                                TextFormField(
                    style: TextStyle(fontSize: 20),
                    validator:(val)=>val.isEmpty ? "Cant be empty" : null,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Bank account number",
                        contentPadding: EdgeInsets.symmetric(vertical: 13,horizontal: 10),
                        fillColor: Colors.blue[100],
                      filled: true,
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue[500],width: 2),
                          borderRadius: BorderRadius.circular(15),
                        )
                    ),
                    controller: accountnumber,
                    
                  ),SizedBox(height: 23,),
                                TextFormField(
                    style: TextStyle(fontSize: 20),
                    validator:(val)=>val.isEmpty ? "Cant be empty" : null,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "IFC code",
                        contentPadding: EdgeInsets.symmetric(vertical: 13,horizontal: 10),
                        fillColor: Colors.blue[100],
                      filled: true,
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue[500],width: 2),
                          borderRadius: BorderRadius.circular(15),
                        )
                    ),
                    controller: ifcCode,
                    
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    style: TextStyle(fontSize: 20),
                    validator:(val)=>val.isEmpty ? "Cant be empty" : null,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Mobile number",
                        contentPadding: EdgeInsets.symmetric(vertical: 13,horizontal: 10),
                        fillColor: Colors.blue[100],
                      filled: true,
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue[500],width: 2),
                          borderRadius: BorderRadius.circular(15),
                        )
                    ),
                    controller: mobno,
                    
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    style: TextStyle(fontSize: 20),
                    validator:(val)=>val.isEmpty ? "Cant be empty" : null,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "Residential address",
                        contentPadding: EdgeInsets.symmetric(vertical: 13,horizontal: 10),
                        fillColor: Colors.blue[100],
                      filled: true,
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue[500],width: 2),
                          borderRadius: BorderRadius.circular(15),
                        )
                    ),
                    controller: adress,
                                      ),
                  SizedBox(height: 30,),
                  TextFormField(
                    style: TextStyle(fontSize: 20),
                    validator:(val)=>val.isEmpty ? "Cant be empty" : null,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Pincode",
                        contentPadding: EdgeInsets.symmetric(vertical: 13,horizontal: 10),
                        fillColor: Colors.blue[100],
                      filled: true,
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue[500],width: 2),
                          borderRadius: BorderRadius.circular(15),
                        )
                    ),
                    controller: pincode,
                   
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    style: TextStyle(fontSize: 20),
                    validator:(val)=>val.isEmpty ? "Cant be empty" : null,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "City",
                        contentPadding: EdgeInsets.symmetric(vertical: 13,horizontal: 10),
                        fillColor: Colors.blue[100],
                      filled: true,
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue[500],width: 2),
                          borderRadius: BorderRadius.circular(15),
                        )
                    ),
                    controller: city,
                   
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    style: TextStyle(fontSize: 20),
                    validator:(val)=>val.isEmpty ? "Cant be empty" : null,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "State",
                        contentPadding: EdgeInsets.symmetric(vertical: 13,horizontal: 10),
                        fillColor: Colors.blue[100],
                      filled: true,
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue[500],width: 2),
                          borderRadius: BorderRadius.circular(15),
                        )
                    ),
                    controller: state,
                    
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    style: TextStyle(fontSize: 20),
                    validator:(val)=>val.isEmpty ? "Cant be empty" : null,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Pancard / Adhaar no",
                        contentPadding: EdgeInsets.symmetric(vertical: 13,horizontal: 10),
                        fillColor: Colors.blue[100],
                      filled: true,
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[100],width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue[500],width: 2),
                          borderRadius: BorderRadius.circular(15),
                        )
                    ),
                    controller: adhaarno,
                    
                  ),
                  SizedBox(height: 23,),
                  Center(
                    child: Dropdownscreen(selextedPlan),),
                  SizedBox(height: 23,),
                  Center(child: Text(errortext,style: TextStyle(color:Colors.red,fontSize: 20),)),
                  SizedBox(height: 23,),
                  
                ],
                )
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: loadingSwitcher(),
          ),
        ),
      ),
    );
  }
}