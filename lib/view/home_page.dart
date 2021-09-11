import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/controller/home_page.dart';
import 'package:newsapp/model/news_model.dart';
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


  String getCategoryName(int categoryId){
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

  final HomeController homeController = Get.put(HomeController());

  List<Widget> getWidgets() {
    var outPutFormate = DateFormat('dd/MMMM/yyyy hh:mm a');
    final cat = homeController.categories;
    if (homeController.newsData.value.to == -1) {
      return homeController.categories
          .map((data) => Center(
                child: CircularProgressIndicator(),
              ))
          .toList();
    } 

    else {
      return homeController.categories
          .map((item) {
            List<Data> e = homeController.getData(item);
            return ListView(
            shrinkWrap: true,
            children:
            e.map((e) => ListTile(
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
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(getCategoryName(e.categoryId)),
                        Text(outPutFormate.format(DateTime.parse(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z").parse(e.updatedAt).toString())).toString()),
                      ],
                    ),
                  ],
                ),
                    )).toList(),
          );
          })
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: homeController.categoriesList.value.currentPage==-1
            ? Center(
                child: CircularProgressIndicator(),
              )
            : DefaultTabController(
                length: homeController.categories.length,
                child: Scaffold(
                  body: Container(
                   // height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.only(top: 20, left: 15, right: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
        
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
                              isScrollable: true,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.blueAccent),
                          unselectedLabelColor: Colors.grey,
                          indicatorSize: TabBarIndicatorSize.label,
                          tabs: homeController.categories
                              .map(
                                (e) => Container(
                                  width: MediaQuery.of(context).size.width/4,
                                  child: Tab(
                                    child: customTab(text: homeController.getCategoryName(categoryId: e)),
                                  ),
                                ),
                              )
                              .toList(),
                        )),
                        Expanded(
                          child: Container(
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
