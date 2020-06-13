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

class _RegisterPageState extends State<RegisterPage> {
  String selectedplan;
  BuildContext cont;
  selextedPlan(String plan){
    setState(() {
      selectedplan=plan;
    });
    
  }


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

  dialogueBoxView(){
    return showDialog(context: context,
    barrierDismissible: true,
    child: Dialog(
      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
          child: Container(
            
            decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: Colors.transparent,),
        height: MediaQuery.of(context).size.height/2.65,
        width: MediaQuery.of(context).size.width,
        child: Dropdownscreen(selextedPlan)),
    )
    );
  }

  Widget textViewWidgetDisplayer(String errormessage,String hintname,TextCapitalization cap,TextInputType inputType,TextEditingController controller){
    bool validator(String val){
    if(hintname=='Password'){
      return val.length<8;
    }else{
      return val.isEmpty;
    }
    }
    
    return TextFormField(
                    style: TextStyle(fontSize: 20),
                    validator:(val)=>validator(val) ? errormessage : null,
                    keyboardType: inputType,
                    textCapitalization: cap,
                    decoration: InputDecoration(hintText: hintname,
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
                    controller: controller,
            
                  );
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
                  if(selectedplan==null){

                      final snack=SnackBar(content: Text('Please select a plan'),duration: Duration(seconds:2),backgroundColor: Colors.black,);
                      Scaffold.of(cont).showSnackBar(snack);
                    
                  }
                  if(_formkey.currentState.validate()&&selectedplan!=null){
                    setState(() {
                      load=true;
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
                    switch (result) {
                      case 'ERROR_EMAIL_ALREADY_IN_USE':
                        setState(() {
                        load=false;
                      final snack=SnackBar(content: Text('This e-mail is already in use'),duration: Duration(seconds:2),backgroundColor: Colors.black,);
                      Scaffold.of(cont).showSnackBar(snack);
                      });
                        break;
                      case 'ERROR_INVALID_EMAIL':
                        setState(() {
                        load=false;
                      final snack=SnackBar(content: Text('Invalid e-mail ID'),duration: Duration(seconds:2),backgroundColor: Colors.black,);
                      Scaffold.of(cont).showSnackBar(snack);
                      });
                        break;

                      case 'null':
                        setState(() {
                        load=false;
                      final snack=SnackBar(content: Text('Something went wrong'),duration: Duration(seconds:2),backgroundColor: Colors.black,);
                      Scaffold.of(cont).showSnackBar(snack);
                      });
                      break;
                      default:
                        
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
            
              backgroundColor: Colors.transparent,
                    body: Form(
              key: this._formkey,
                      child: SingleChildScrollView(
                        
                child: Builder(
                  builder: (BuildContext context){
                    cont=context;
                    return Column(
                    children:<Widget>[
                      textViewWidgetDisplayer('Cant be empty', 'Name', TextCapitalization.characters, TextInputType.text, name),
                      
                    SizedBox(height: 30,),
                    textViewWidgetDisplayer('Cant be empty', 'E-mail ID', TextCapitalization.none, TextInputType.text, emailId),
                   
                    SizedBox(height: 30,),
                    textViewWidgetDisplayer('password should be atleast 8 char long', 'Password', TextCapitalization.none, TextInputType.text, password),
                  
                    SizedBox(height: 30,),
                    textViewWidgetDisplayer('Cant be empty', 'Bank account branch', TextCapitalization.sentences, TextInputType.text, accountbranch),
                    
                  
                    SizedBox(height: 30,),
                    textViewWidgetDisplayer('Cant be empty', 'Bank account name', TextCapitalization.none, TextInputType.text, accountname),
                    
                    SizedBox(height: 23,),
                    textViewWidgetDisplayer('Cant be empty', 'Bank account number', TextCapitalization.none, TextInputType.number, accountnumber),
                    SizedBox(height: 23,),
                    textViewWidgetDisplayer('Cant be empty', 'IFSC code', TextCapitalization.none, TextInputType.text, ifcCode),
                     
                    SizedBox(height: 30,),
                    textViewWidgetDisplayer('Cant be empty', 'Mobile number', TextCapitalization.sentences, TextInputType.number, mobno),
                    
                    SizedBox(height: 30,),
                    textViewWidgetDisplayer('Cant be empty', 'Residential address', TextCapitalization.sentences, TextInputType.text, adress),
                    
                    SizedBox(height: 30,),
                    textViewWidgetDisplayer('Cant be empty', 'Pincode', TextCapitalization.sentences, TextInputType.number, pincode),
                    
                    SizedBox(height: 30,),
                    textViewWidgetDisplayer('Cant be empty', 'City', TextCapitalization.sentences, TextInputType.text, city),
                    
                    SizedBox(height: 30,),
                    textViewWidgetDisplayer('Cant be empty', 'State', TextCapitalization.sentences, TextInputType.text, state),
                    
                    SizedBox(height: 30,),
                    textViewWidgetDisplayer('Cant be empty', 'Pancard / Adhaar no', TextCapitalization.sentences, TextInputType.number, adhaarno),
                    
                    SizedBox(height: 23,),
                    Center(
                      child:MaterialButton(
                        minWidth: 350,
                        height: 45,
                        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                        onPressed: (){
                          dialogueBoxView();
                        },
                        color: Colors.blue,
                        child: Text("Choose plan",style: TextStyle(letterSpacing: 1,
                          color: Colors.white,fontSize: 24
                        ),),
                      ),),
                    SizedBox(height: 70,),
                    
                  ],
                  );
                  },
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