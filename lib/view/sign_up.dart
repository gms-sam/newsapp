import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/view/sign_in.dart';
import 'package:http/http.dart'as http;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = "", _userName = "",_password="",_confrmPassword="";

  bool _secureText = true,_secureText1 = true;

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
                Text("Welcome",style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 35,fontWeight: FontWeight.w500),)),
                SizedBox(height: 15,),
                Text("Discover news in right way",style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 18),)),
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
                    hintText: "Username",hintStyle: GoogleFonts.dmSans()),
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
                    hintText: "Email Address",hintStyle: GoogleFonts.dmSans()),
                ),
                SizedBox(height: 25,),
                TextFormField(
                  obscureText: _secureText,
                  validator: (input) {
                    if (input!.isEmpty) {
                      return "Please Enter Password";
                    }
                  },
                  onSaved: (input) => _password= input.toString(),
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
                    hintText: "Password",hintStyle: GoogleFonts.dmSans()),
                ),
                SizedBox(height: 25,),
                TextFormField(
                  obscureText: _secureText1,  
                  validator: (input) {
                    if (input!.isEmpty) {
                      return "Please Enter Confirm Password";
                    }
                  },
                  onSaved: (input) => _confrmPassword = input.toString(),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(icon: Icon(_secureText1?Icons.visibility_off:Icons.visibility),
                    onPressed: (){
                      setState(() {
                      _secureText1 = !_secureText1;
                      });
                    },
                    ),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide()
                    ),
                    
                    hintText: "Repeat Password",hintStyle: GoogleFonts.dmSans()),
                ),
                SizedBox(height: 25,),
                InkWell(
                  onTap: () {
                      final formSate = _formKey.currentState;
                      if (formSate!.validate()) {
                        formSate.save();
                        registerUser(context);
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
                      child: Center(child: Text("Sign Up",style: GoogleFonts.dmSans(textStyle: TextStyle(color: Colors.white,fontSize: 20),)))),
                ),
                SizedBox(height: 40,),
                Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?",style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 20)),),
                            InkWell(
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
                              },
                              child: Text(" Sign In",style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w600))))
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
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SignIn()), (route) => false);
  }
}