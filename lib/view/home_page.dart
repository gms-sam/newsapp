import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/controller/home_page.dart';
import 'package:newsapp/model/news_model.dart';
import 'package:newsapp/view/profile.dart';
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
          //color: Colors.grey
          ),
      child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(color: Colors.black),
          )),
    );
  }
  FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
  final HomeController homeController = Get.put(HomeController());

  List<Widget> getWidgets() {
    var outPutFormate = DateFormat('dd/MMMM/yyyy ');
    //var outPutFormate = DateFormat('dd/MMMM/yyyy hh:mm a');  add it instead of above date formate to get with time output.
    return [
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
                                    fit: BoxFit.cover,
                                  )),
                      ),
                      title: Text(e.heading),
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
                                  .toString()),
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
                    // height: MediaQuery.of(context).size.height,
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
                              style: TextStyle(fontSize: 35, color: Colors.black),
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
                                        title: Text("Name"),
                                        subtitle: Text(homeController.user.value.name),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.email),
                                        title: Text("Email"),
                                        subtitle: Text(homeController.user.value.email),
                                      ),
                                      ListTile(
                                        onTap: (){
                                          flutterSecureStorage.delete(key: "login");
                                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SignIn()), (route) => false);
                                        },
                                        leading: Icon(Icons.logout),
                                        title: Text("SignOut"),
                                      ),
                                    ],
                                  ),
                                );
                              });
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
                              // Get.bottomSheet(
                              //   Container(
                              //     child: Column(
                              //       children: [
                              //         ListTile(
                              //           leading: Icon(Icons.person),
                              //           // title: Text("Name"),
                              //           // subtitle: Text(homeController.user.value.name),
                              //         ),
                              //         ListTile(
                              //           leading: Icon(Icons.email),
                              //           // title: Text("Email"),
                              //           // subtitle: Text(homeController.user.value.email),
                              //         )
                              //       ],
                              //     ),
                              //   )
                              // );
                            },
                             icon: Icon(Icons.person))



                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Discover news in right way",
                          style: TextStyle(color: Colors.black),
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
                            // height: MediaQuery.of(context).size.height,
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
