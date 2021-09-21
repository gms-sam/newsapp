import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:newsapp/model/categories.dart';
import 'package:newsapp/model/news_model.dart';
import 'package:newsapp/model/user_2.dart';
import 'package:newsapp/services/api_manager.dart';

class HomeController extends GetxController {

  List<RxList<Data>> newsList=[<Data>[].obs];
  List<ScrollController> scrollController=<ScrollController>[];

  RxList<NewsModel> news =<NewsModel>[].obs;
  Rx<User> user = User(email: "",name: "",id:0,createdAt: "",updatedAt: "",emailVerifiedAt: "").obs;

  Rx<CategoriesList> categoriesList =
      CategoriesList(data: [], currentPage: -1).obs;
  // Rx<NewsModel> newsData = NewsModel(
  //         path: "",
  //         data: [],
  //         to: -1,
  //         total: 0,
  //         firstPageUrl: "",
  //         currentPage: 0,
  //         from: 0,
  //         lastPage: 0,
  //         perPage: 0,
  //         links: [],
  //         lastPageUrl: "",
  //         prevPageUrl: "",
  //         nextPageUrl: '')
  //     .obs;

  RxList<int> categories=<int>[].obs;
  Future<void>getCatogoriesList() async {
    categoriesList.value = (await ApiManager().getCategoryList())!;
    newsList=List.generate(categoriesList.value.data.length, (index) => <Data>[].obs);
    scrollController=List.generate(categoriesList.value.data.length, (index) => ScrollController());
    for(int i=0;i<scrollController.length;i++){
      scrollController[i].addListener(() {
        listner(i);
      });
    }
  //  categories.value=newsData.value.data.map((e) => e.categoryId).toSet().toList();
  }

  void listner(int index)async{
    if(scrollController[index].position.maxScrollExtent)
    news[index]=await ApiManager().getMoreNews(news[index].nextPageUrl);
    newsList[index].addAll(news[index].data);
  }

  String getCategoryName({required int categoryId}){
    return categoriesList.value.data.firstWhere((element) => element.id==categoryId).name;
     }
  
  // List<Data> getData(int categoryId) {
  //   return newsData.value.data.where((element) => element.categoryId==categoryId).toList();
  // }

  // Future<void> getNewsList(String newsCategory, int index) async {
  //   newsData.value = (await ApiManager().getNews(newsCategory));
  //   newsList[index].addAll(newsData.value.data);
  // }

  Future<User> getUserData() async {
   String? userData = await FlutterSecureStorage().read(key: "user");
   if(userData == null){
     throw "error";
   }
   else{
     User user = User.fromJson(userData);
     this.user.value = user;
     return user;
   }
  }
  

  

  @override
  void onInit() {
    super.onInit();
    getCatogoriesList().then((value)async{
      for(int i=0;i<categoriesList.value.data.length;i++){
      NewsModel newsModel = await ApiManager().getNews(categoriesList.value.data[i].name);
      news.add(newsModel);
      }
      categoriesList.value.data.forEach((element)async {
      });
    });
    getUserData();
  }
}
