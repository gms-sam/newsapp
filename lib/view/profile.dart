import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sign_in.dart';

class Profile extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(onPressed: ()async{
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.clear();
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SignIn()), (route) => false);
        }, child: Text("LogOut")),
      ),
      
    );
  }
}