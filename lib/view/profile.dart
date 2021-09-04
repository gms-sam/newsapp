import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sign_in.dart';

class Profile extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(onPressed: ()async{
          FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
          flutterSecureStorage.delete(key: "login");
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SignIn()), (route) => false);
        }, child: Text("LogOut")),
      ),
      
    );
  }
}