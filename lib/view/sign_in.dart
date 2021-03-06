import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import 'package:newsapp/model/user.dart';
import 'package:newsapp/view/home_page.dart';

import 'sign_up.dart';

// ignore: must_be_immutable
class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = "", _password = "";
  bool _secureText = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                Text("Welcome Back",style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 35,fontWeight: FontWeight.w500),)),
                SizedBox(height: 15,),
                Text("Discover news in right way ",style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 18)),),
                SizedBox(height:  50),
                TextFormField(
                  validator: (input) {
                    if (input!.isEmpty) {
                      return "Please Enter a Email";
                    }
                     if (!GetUtils.isEmail(input)){
                      return "Email is not valid";
                     }
                  },
                  onSaved: (input) => _email = input.toString(),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide()
                    ),
                    hintText: "Enter Your Email",hintStyle: GoogleFonts.dmSans()),
                    
                ),
                SizedBox(height: 25,),
                TextFormField(
                  validator: (input) {
                    if (input!.isEmpty) {
                      return "Please a passward";
                    }
                  },
                  onSaved: (input) => _password = input.toString(),
                  obscureText: _secureText,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(icon: Icon(_secureText?Icons.visibility_off:Icons.visibility),
                    onPressed: (){
                      setState(() {
                        _secureText = !_secureText;
                      });
                    },
                    ),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide()
                    ),
                    hintText: "Enter Your password",hintStyle: GoogleFonts.dmSans(),
                  ),
                ),
               SizedBox(height: 20),
               Align(
                 alignment: Alignment.centerRight ,
                 child: InkWell(
                   onTap: (){
                   },
                   child: Text("Forgot Password?",style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 16),)))),
                   SizedBox(height: 30,),
                InkWell(
                  onTap: () {
                      final formSate = _formKey.currentState;
                      if (formSate!.validate()) {
                        formSate.save();
                        login(context);
                      }
                    },
                  child: Container(
                   // margin: EdgeInsets.only(top: 30),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blueAccent
                    ),
                      child: Center(child: Text("Login",style: GoogleFonts.dmSans(textStyle: TextStyle(color: Colors.white,fontSize: 20)),))),
                ),
               Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?",style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 20),)),
                            InkWell(
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUp()));
                              },
                              child: Text(" Sign Up",style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w600))))
                          ],
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<UserModel?> login(BuildContext context)async{
    if(_password.isNotEmpty && _email.isNotEmpty){
       var url = Uri.parse("https://newsmods.com/api/login");
        Map body = {"email": _email,"password": _password};
      var response = await http.post(url, body: body,headers: {"accept":"application/json"});
      if(response.statusCode == 201){
       // final body = jsonDecode(response.body);
        final UserModel user = UserModel.fromJson(response.body);
       await pageRoute(context,user);
        return user;
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid User")));
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Blank field are not allowed")));
    }
  }

  Future<void> pageRoute(BuildContext context,UserModel user)async{
    FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    
   await flutterSecureStorage.write(key: "login", value: user.token);
   await flutterSecureStorage.write(key: "user", value: user.user.toJson());
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
  }
}
