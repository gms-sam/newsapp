import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/controller/home_page.dart';
import 'package:newsapp/view/sign_in.dart';
import 'news_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget customTab({required String text}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.blueAccent)
          ),
      child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
           style: GoogleFonts.dmSans(textStyle: TextStyle(color: Colors.black),),
          )),
    );
  }
  FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
  final HomeController homeController = Get.put(HomeController());

  List<Widget> getWidgets() {
    var outPutFormate = DateFormat('dd/MMMM/yyyy ');
    return [
      for (int i = 0; i < homeController.categoriesList.value.data.length; i++)
        if (homeController.news.length <= i)
          Center(child: CircularProgressIndicator())
        else
          ListView(
          controller: homeController.scrollController[i],
            shrinkWrap: true,
            // children: homeController.news[i].data
            children: homeController.newsList[i]
                .map((e) => ListTile(
                      horizontalTitleGap: 20,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NewsListDetails(dataList: e, i: i,)));
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
                                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
                                                  return Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png");
                                                },
                                    fit: BoxFit.cover,
                                  )),
                      ),
                      title: Text(e.heading,style: GoogleFonts.dmSans()),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            //  Text(getCategoryName(e.categoryId)),
                              Text(outPutFormate
                                  .format(DateTime.parse(
                                      DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z")
                                          .parse(e.updatedAt)
                                          .toString()))
                                  .toString(),
                                  style: GoogleFonts.dmSans(),
                                  ),
                            ],
                          ),
                        ],
                      ),
                    ))
                .toList(),
          )
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: homeController.categoriesList.value.currentPage == -1
            ? Center(
                child: CircularProgressIndicator(),
              )
            : DefaultTabController(
                length: homeController.categoriesList.value.data.length,
                child: Scaffold(
                  body: Container(
                    margin: EdgeInsets.only(top: 20, left: 15, right: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "NewsMods",
                              style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 35, color: Colors.black))
                              //TextStyle(fontSize: 35, color: Colors.black),
                            ),
                            IconButton(onPressed: (){
                              showModalBottomSheet(context: context, builder: (context){
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                                  ),
                                  height: MediaQuery.of(context).size.height/4,
                                  child: Column(
                                    children: [
                                      ListTile(
                                         leading: Icon(Icons.person),
                                        title: Text("Name",style: GoogleFonts.dmSans()),
                                        subtitle: Text(homeController.user.value.name,style: GoogleFonts.dmSans()),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.email),
                                        title: Text("Email",style: GoogleFonts.dmSans()),
                                        subtitle: Text(homeController.user.value.email,style: GoogleFonts.dmSans()),
                                      ),
                                      ListTile(
                                        onTap: (){
                                          flutterSecureStorage.delete(key: "login");
                                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SignIn()), (route) => false);
                                        },
                                        leading: Icon(Icons.logout),
                                        title: Text("SignOut",style: GoogleFonts.dmSans()),
                                      ),
                                    ],
                                  ),
                                );
                              });
                            },
                             icon: Icon(Icons.person))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Discover news in right way",
                          style: GoogleFonts.dmSans()
                          //style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        
                        Container(
                            child: TabBar(
                          isScrollable: true,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.blueAccent),
                          unselectedLabelColor: Colors.grey,
                          indicatorSize: TabBarIndicatorSize.label,
                          tabs: homeController.categoriesList.value.data
                              .map(
                                (e) => Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Tab(
                                    child: customTab(
                                        text: homeController.getCategoryName(
                                            categoryId: e.id)),
                                  ),
                                ),
                              )
                              .toList(),
                        )),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 20),
                            child: TabBarView(children: getWidgets()),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
