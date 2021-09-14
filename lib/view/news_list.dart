import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:newsapp/controller/home_page.dart';
import 'package:newsapp/model/news_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/instance_manager.dart';

class NewsListDetails extends StatelessWidget {
  final Data dataList;

  NewsListDetails({required this.dataList});

 final HomeController homeController = Get.put(HomeController());
 

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
           // top: MediaQuery.of(context).size.height * 0.23,
           bottom: 600,
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
                child: ListView(
                  shrinkWrap: true,
                 // crossAxisAlignment: CrossAxisAlignment.start,
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
                    ),
                    
                
                    for (int i = 0; i < homeController.categoriesList.value.data.length; i++)
                      if (homeController.news.length <= i)
                        Center(child: CircularProgressIndicator())
                      else 
                        ListView(
                          shrinkWrap: true,
                          children: homeController.news[i].data
                .map((e) => ListTile(
                      horizontalTitleGap: 20,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NewsListDetails(dataList: e)));
                      },
                      leading: Container(
                        height: 200,
                        width: 100,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: e.image.isEmpty
                                ? Image.network(
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png")
                                : Image.network(
                                    e.image,
                                    fit: BoxFit.cover,
                                  )),
                      ),
                      title: Text(e.heading),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(getCategoryName(e.categoryId)),
                          //     Text(outPutFormate
                          //         .format(DateTime.parse(
                          //             DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z")
                          //                 .parse(e.updatedAt)
                          //                 .toString()))
                          //         .toString()),
                          //   ],
                          // ),
                        ],
                      ),
                    ))
                .toList(),
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
