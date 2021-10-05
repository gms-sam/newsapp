import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/controller/home_page.dart';
import 'package:newsapp/model/news_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/instance_manager.dart';

class NewsListDetails extends StatefulWidget {
  final Data dataList;
  final int i;
  NewsListDetails({required this.dataList, required this.i});

  @override
  State<NewsListDetails> createState() => _NewsListDetailsState();
}

class _NewsListDetailsState extends State<NewsListDetails> {
  String getCategoryName(int categoryId) {
    switch (categoryId) {
      case 1:
        return "Technology";
      case 2:
        return "Bussiness";
      case 3:
        return "Entertainment";
      case 4:
        return "Genral";
      case 5:
        return "Health";
      case 6:
        return "Science";
      case 7:
        return "Sports";
      default:
        return "default";
    }
  }


  bool closeTopContainer = false;

  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
  }
late double containerHeight = MediaQuery.of(context).size.height * 0.7;
  
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
              widget.dataList.image,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png");
              },
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.4,
            ),
          ),
          // Positioned(
          //   bottom: 600,
          //   left: 20,
          //   right: 10,
          //   child: Text(
          //     dataList.heading,
          //     maxLines: 3,
          //       style: GoogleFonts.dmSans(
          //         textStyle: TextStyle(
          //         color: Colors.white,
          //         fontSize: 25,
          //         fontWeight: FontWeight.bold),
          //       )
          //   ),
          // ),
          Positioned(
            bottom: 0,
            child: AnimatedContainer(
              duration: Duration(microseconds: 1000),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35))),
              height:containerHeight,
              width: MediaQuery.of(context).size.width,
              child: Padding(
              key: ValueKey(closeTopContainer),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                        controller: homeController.details,

                  child: Column(
                    children: [
                      //Text(dataList.),
                      Text(widget.dataList.heading,
                          //maxLines: 3,
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                //color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),

                      Padding(
                        padding: const EdgeInsets.only(right: 10, top: 10),
                        child: Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blueAccent,
                                ),
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(getCategoryName(
                                    widget.dataList.categoryId))),
                            Text(
                              DateFormat('EEEE, MMM dd yyyy - hh:mm a ')
                                  .format(
                                      DateTime.parse(widget.dataList.updatedAt))
                                  .toString(),
                              style: GoogleFonts.dmSans(),
                            ),
                            Text("IST"),
                          ],
                        ),
                      ),

                      // SizedBox(height:10),
                      //           Align(
                      //             alignment: Alignment.bottomLeft,
                      //             child: Text(
                      //               "Description",
                      //                style: GoogleFonts.dmSans(textStyle: TextStyle(color: Colors.blueAccent,fontSize: 20, fontWeight: FontWeight.bold,),)
                      //             ),
                      //           ),

                      //           SizedBox(
                      //             width: 10,
                      //           ),
                      //            Align(
                      //   alignment: Alignment.bottomLeft,
                      //   child: dataList.author!=null?Text("Auther : ${dataList.author.toString()}",style: GoogleFonts.dmSans(color: Colors.grey),):Text("Auther : None",style: GoogleFonts.dmSans(color: Colors.grey)),
                      // ),

                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text("Description",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.dataList.content,
                        style: GoogleFonts.dmSans(
                            textStyle: TextStyle(fontSize: 18)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widget.dataList.author != null
                              ? Text(
                                  "Auther : ${widget.dataList.author.toString()}",
                                  style: GoogleFonts.dmSans(color: Colors.grey),
                                )
                              : Text("Auther : None",
                                  style:
                                      GoogleFonts.dmSans(color: Colors.grey)),
                          TextButton(
                              onPressed: () {
                                if (widget.dataList.source != null) {
                                  _launchUrl(widget.dataList.source.toString());
                                } else {
                                  _launchUrl("www.google.com");
                                }
                              },
                              child: Text(
                                "See More",
                                style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(color: Colors.white)),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blueAccent))),
                        ],
                      ),
                      Divider(),
                      ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: homeController.news[widget.i].data
                            .map((e) => ListTile(
                                  horizontalTitleGap: 20,
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NewsListDetails(
                                                  dataList: e,
                                                  i: widget.i,
                                                )));
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
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                                  return Image.network(
                                                      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png");
                                                },
                                                fit: BoxFit.cover,
                                              )),
                                  ),
                                  title: Text(
                                    e.heading,
                                    style: GoogleFonts.dmSans(),
                                  ),
                                  subtitle: Text(getCategoryName(e.categoryId),
                                      style: GoogleFonts.dmSans()),
                                ))
                            .toList(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  _launchUrl(String url) async {
    launch(url);
  }
}
