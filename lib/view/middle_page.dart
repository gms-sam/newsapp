import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:newsapp/view/sign_in.dart';

import 'dashboard.dart';

class MiddlePage extends StatefulWidget {
  const MiddlePage({ Key? key }) : super(key: key);

  @override
  _MiddlePageState createState() => _MiddlePageState();
}

class _MiddlePageState extends State<MiddlePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }


   void checkLogin()async{
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String? val = await sharedPreferences.getString("login");
    FlutterSecureStorage flutterSecureStorage = await FlutterSecureStorage();
    String? val = await flutterSecureStorage.read(key: "login");
    if(val!=null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>DashBoard()), (route) => false);
    }else{
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SignIn()), (route) => false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}