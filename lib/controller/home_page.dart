import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/model/categories.dart';
import 'package:newsapp/model/news_model.dart';
import 'package:newsapp/services/api_manager.dart';

class HomeController extends GetxController {
  Rx<CategoriesList> categoriesList =
      CategoriesList(data: [], currentPage: 0).obs;
  Rx<NewsModel> newsData = NewsModel(
          path: "",
          data: [],
          to: -1,
          total: 0,
          firstPageUrl: "",
          currentPage: 0,
          from: 0,
          lastPage: 0,
          perPage: 0,
          links: [],
          lastPageUrl: "",
          prevPageUrl: "",
          nextPageUrl: '')
      .obs;

  RxList<int> categories=<int>[].obs;
  void getCatogoriesList() async {
    categoriesList.value = (await ApiManager().getCategoryList())!;
   await getNewsList();
   categories.value=newsData.value.data.map((e) => e.categoryId).toSet().toList();
  }

  String getCategoryName({required int categoryId}){
    return categoriesList.value.data.firstWhere((element) => element.id==categoryId).name;
  }
  
  List<Data> getData(int categoryId) {
    return newsData.value.data.where((element) => element.categoryId==categoryId).toList();
  }

  Future<void> getNewsList() async {
    newsData.value = (await ApiManager().getNews());
  }

  

  @override
  void onInit() {
    super.onInit();
    getCatogoriesList();
  }
}
