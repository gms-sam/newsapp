import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:http/http.dart'as http;
import 'package:newsapp/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:newsapp/services/api_manager.dart';
import 'package:newsapp/view/dashboard.dart';
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                Text("Welcome Back",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w500),),
                SizedBox(height: 15,),
                Text("I am happy to see you again. You can continue when you left off by logging in",style: TextStyle(fontSize: 18),),
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
                    //filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide()
                    ),
                    hintText: "Enter Your Email"),
                ),
                SizedBox(height: 25,),
                TextFormField(
                  validator: (input) {
                    if (input!.isEmpty) {
                      return "Please a passward";
                    }
                  },
                  onSaved: (input) => _password = input.toString(),
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide()
                    ),
                    hintText: "Enter Your password",
                  ),
                ),
               SizedBox(height: 20),
               Align(
                 alignment: Alignment.centerRight ,
                 child: InkWell(
                   onTap: (){
                     //Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                   },
                   child: Text("Forgot Password?",style: TextStyle(fontSize: 16),))),
                InkWell(
                  onTap: () {
                      final formSate = _formKey.currentState;
                      if (formSate!.validate()) {
                        formSate.save();
                        login(context);
                        //apiManager.signIn(_email, _password);
                       // callLoginApi();
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) => MainHomePage()));
                      }
                    },
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blueAccent
                    ),
                      child: Center(child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 20),))),
                ),
               Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?",style: TextStyle(fontSize: 20),),
                            InkWell(
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUp()));
                              },
                              child: Text(" Sign Up",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)))
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

  Future<User?> login(BuildContext context)async{
    if(_password.isNotEmpty && _email.isNotEmpty){
       var url = Uri.parse("https://newsmods.com/api/login");
        Map body = {"email": _email,"password": _password};
      var response = await http.post(url, body: body,headers: {"accept":"application/json"});
      if(response.statusCode == 201){
        final body = jsonDecode(response.body);
        pageRoute(body["token"],context,body["user"]["name"],body["user"]["email"]);
        final User user = User.fromJson(response.body);
        return user;
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid User")));
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Blank field are not allowed")));
    }
  }

  void pageRoute(String token,BuildContext context,String name,String email)async{
    //  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //     await sharedPreferences.setString("login", token);

    FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    flutterSecureStorage.write(key: "login", value: token);
    flutterSecureStorage.write(key: "email", value: email);
    flutterSecureStorage.write(key: "name", value: name);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>DashBoard()), (route) => false);
  }
}
