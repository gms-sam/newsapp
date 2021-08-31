import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/controller/home_page.dart';
import 'package:newsapp/model/categories.dart';
import 'package:newsapp/model/news_model.dart';
import 'package:newsapp/services/api_manager.dart';
import 'package:newsapp/view/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final HomeController homeController = Get.put(HomeController());

  List<Widget> getWidgets() {
    if (homeController.newsData.value.to == -1) {
      return homeController.categoriesList.value.data
          .map((data) => Center(
                child: CircularProgressIndicator(),
              ))
          .toList();
    } else {
      return homeController.categoriesList.value.data
          .map((e) => Container(
                child: ListView(
                  children: homeController
                      .getData(e.id)
                      .map((e) => Container(
                            child: Text(e.heading),
                          ))
                      .toList(),
                ),
              ))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: homeController.categoriesList.value == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : DefaultTabController(
                length: homeController.categoriesList.value!.data.length,
                child: Scaffold(
                  body: Container(
                    height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.only(top: 20, left: 15, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //  mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Browse",
                          style: TextStyle(fontSize: 35, color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Discover things of this world",
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            child: TabBar(
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.blueAccent),
                          unselectedLabelColor: Colors.grey,
                          indicatorSize: TabBarIndicatorSize.label,
                          tabs: homeController.categoriesList.value.data
                              .map(
                                (e) => Tab(
                                  child: customTab(text: e.name),
                                ),
                              )
                              .toList(),
                        )),
                        SizedBox(
                          height: 300,
                          child: TabBarView(children: getWidgets()),
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

class CategoryItemCard extends StatelessWidget {
  final int id;
  CategoryItemCard({required this.id});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [],
    );
  }
}
