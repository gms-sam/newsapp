import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:newsapp/view/sign_in.dart';
import 'package:http/http.dart'as http;
import 'dashboard.dart';

class SignUp extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = "", _userName = "",_password="",_confrmPassword="";


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
                Text("Welcome to Nuntium",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w500),),
                SizedBox(height: 15,),
                Text("Hello, I guess are new around here. You can start using the application after sign up.",style: TextStyle(fontSize: 18),),
                SizedBox(height:  50),
                TextFormField(
                  validator: (input) {
                    if (input!.isEmpty) {
                      return "Enter your Username";
                    }
                  },
                  onSaved: (input) => _userName = input.toString(),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide()
                    ),
                    hintText: "Username"),
                ),
                SizedBox(height: 25,),
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
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide()
                    ),
                    hintText: "Email Address"),
                ),
                SizedBox(height: 25,),
                TextFormField(
                  validator: (input) {
                    if (input!.isEmpty) {
                      return "Please Enter Password";
                    }
                  },
                  onSaved: (input) => _password= input.toString(),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide()
                    ),
                    hintText: "Password"),
                ),
                SizedBox(height: 25,),
                TextFormField(
                  validator: (input) {
                    if (input!.isEmpty) {
                      return "Please Enter Confirm Password";
                    }
                  },
                  onSaved: (input) => _confrmPassword = input.toString(),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide()
                    ),
                    hintText: "Repeat Password"),
                ),
                SizedBox(height: 25,),
                InkWell(
                  onTap: () {
                      final formSate = _formKey.currentState;
                      if (formSate!.validate()) {
                        formSate.save();
                        registerUser(context);
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) => SignIn()));
                      }
                    },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blueAccent
                    ),
                      child: Center(child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 20),))),
                ),
                SizedBox(height: 40,),
                Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?",style: TextStyle(fontSize: 20),),
                            InkWell(
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
                              },
                              child: Text(" Sign In",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)))
                          ],
                        ),
              ],
            ),
          ),
        ),
      ),
      
    );
  }

  Future registerUser(BuildContext context) async{
    var url = Uri.parse("https://newsmods.com/api/register");
    Map body={
      "name":_userName,
      "email":_email,
      "password":_password,
      "password_confirmation":_confrmPassword
    };
       var response = await http.post(url, body: body,headers: {"accept":"application/json"});
       print(response.statusCode);
       if(response.statusCode == 201){
       //  print(response.body);
        final body = jsonDecode(response.body);
         print(body["token"]);
        pageRoute(body["token"],context); 
      }
      else if(response.statusCode==422){
         print(response.body);
         final body = jsonDecode(response.body);
         Map data = body["errors"];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 20),
            content: Text(data.values.toList()[0][0])));
      }
  }
  void pageRoute(String token,BuildContext context)async{
    //  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //     await sharedPreferences.setString("login", token);

    // FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    // flutterSecureStorage.write(key: "login", value: token);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SignIn()), (route) => false);
  }
}