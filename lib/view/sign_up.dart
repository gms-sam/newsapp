import 'package:flutter/material.dart';
import 'package:newsapp/view/sign_in.dart';

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
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) => HomePage()));
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
}