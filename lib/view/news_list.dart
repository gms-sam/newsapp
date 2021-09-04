import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:newsapp/model/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsListDetails extends StatelessWidget {
  final Data dataList;

  NewsListDetails({required this.dataList});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            //width: double.infinity,
            //height: double.infinity,
          ),
          Container(
              child: Image.network(
            dataList.image,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.4,
          )),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.23,
            left: 20,
            right: 10,
            child: Text(
              dataList.heading,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ), 
          ),
          
          Positioned(
           bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(35),topRight: Radius.circular(35))
              ),
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Description",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text(dataList.content,style: TextStyle(fontSize: 18),),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){
                            _launchUrl();
                          },
                          child: Text("See More",style: TextStyle(color: Colors.blueAccent),))
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  _launchUrl()async{ 
    const url = "https://www.google.com/";
    launch(url);
  }
}
