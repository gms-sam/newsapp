import 'package:newsapp/model/categories.dart';
import 'package:newsapp/model/news_model.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  final String baseUrl = "https://newsmods.com/api";
  Future<NewsModel> getNews(String newsCategory) async {
    var url = baseUrl + "/$newsCategory/news";
    Uri uri = Uri.parse(url);
    NewsModel? newsModel;
    try {
      final response =
          await http.get(uri, headers: {"Accept": "application/json"});
      if (response.statusCode == 200) {
        newsModel = NewsModel.fromJson(response.body);
        return newsModel;
      } else {
        throw "error";
      }
    } catch (e) {
      rethrow;
    }
  }


  Future<NewsModel> getMoreNews(String url)async{
      Uri uri = Uri.parse(url);
    NewsModel? newsModel;
    try {
      final response =
          await http.get(uri, headers: {"Accept": "application/json"});
      if (response.statusCode == 200) {
        newsModel = NewsModel.fromJson(response.body);
        return newsModel;
      } else {
        throw "error";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CategoriesList?> getCategoryList() async {
    var url = baseUrl + "/category/list/";
    Uri uri = Uri.parse(url);
    try {
      final http.Response response = await http.get(uri,headers: {"Accept": "application/json"});
      if (response.statusCode == 200) {
        return CategoriesList.fromJson(response.body);
      }
      return null;
    } catch (e) {
      print(e);
    }
  }
}
