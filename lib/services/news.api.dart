import 'dart:convert';
import 'dart:developer';
import 'package:news_app/consts/api_consts.dart';
import 'package:news_app/consts/http_execption.dart';
import 'package:news_app/models/news_model.dart';
import 'package:http/http.dart' as http;

class NewsAPIServices {
  //"getAllNews" is a static function that uses the http package to make an HTTP GET request to the NewsAPI endpoint.
  // The function includes a URL with a keyword parameter, a page size parameter, and an API key parameter to authenticate the request.
  static Future<List<NewsModel>> getAllNews(
      {required int page, required String sortBy}) async {
    // var url = Uri.parse("https://newsapi.org/v2/everything?q=keyword&pageSize=5&apiKey=801b348a69a34073b54c90b6d7d34af1");

    // ------------- The benefit of using  Uri.http() constructor ---------------
    //Uri.http() constructor automatically encodes the query parameters for you, so you don't have to worry about manually encoding the values.
    //Uri.http() constructor can make your code more readable and maintainable, especially if you have a lot of query parameters to include in the URL.
    //Uri.http() constructor to construct URLs with query parameters can save you time and reduce the chances of introducing errors due to incorrect encoding or formatting of the URL.
    try {
      var uri = Uri.http(BASEURL, "v2/everything", {
        "country=us&category": "business",
        "pageSize": "7",
        "domains": "techcrunch.com",
        "page": page.toString(),
        "sortBy": sortBy
        // "apiKey" : API_KEY
      });
      var response = await http.get(uri, headers: {
        "X-Api-key": API_KEY
        //check the documentation for (Request parameters) https://newsapi.org/docs/endpoints/everything
      });
      //print the error code and its message
      // log('Response status: ${response.statusCode}');
      // log('Response body: ${response.body}');

      //The function then uses the "jsonDecode" function to convert the JSON string into a Map object.
      // It iterates over the "articles" list in the Map object using a for loop and adds each article to a temporary list called "newsTempList".
      Map data = jsonDecode(response.body);
      List newsTempList = [];

      //The ['code'] and ['message'] are based on the documentation of News API(error section)
      if (data['code'] != null) {
        throw HttpException(data['message']);
        // throw data['message'];
      }
      for (var v in data["articles"]) {
        newsTempList.add(v);
        log(v.toString());
      }
      //returns a list of NewsModel objects that is created by calling the "newsFromSnapshot" method of the NewsModel class.
      //The "newsFromSnapshot" method takes a list of JSON objects (in this case, the "newsTempList" variable)
      // and converts each JSON object into a NewsModel object using the "fromJson" method of the NewsModel class.
      print("Number of articles: ${data["articles"].length}");
      return NewsModel.newsFromSnapshot(newsTempList);
    } catch (error) {
      throw error.toString();
    }
  }

  //"getTopHeadlines" is a static function that uses the http package to make an HTTP GET request to the NewsAPI endpoint.
  // The function includes a URL with a keyword parameter, a page size parameter, and an API key parameter to authenticate the request.
  static Future<List<NewsModel>> getTopHeadlines() async {

    try {
      var uri = Uri.http(BASEURL, "v2/top-headlines", {'country': 'us'});
      var response = await http.get(uri, headers: {
        "X-Api-key": API_KEY
        //check the documentation for (Request parameters) https://newsapi.org/docs/endpoints/everything
      });
      //print the error code and its message
      log('Response status top headline: ${response.statusCode}');
      log('Response body for top headline: ${response.body}');

      //The function then uses the "jsonDecode" function to convert the JSON string into a Map object.
      // It iterates over the "articles" list in the Map object using a for loop and adds each article to a temporary list called "newsTempList".
      Map data = jsonDecode(response.body);
      List newsTempList = [];

      //The ['code'] and ['message'] are based on the documentation of News API(error section)
      if (data['code'] != null) {
        throw HttpException(data['message']);
        // throw data['message'];
      }
      for (var v in data["articles"]) {
        newsTempList.add(v);
        log(v.toString());
      }
      //returns a list of NewsModel objects that is created by calling the "newsFromSnapshot" method of the NewsModel class.
      //The "newsFromSnapshot" method takes a list of JSON objects (in this case, the "newsTempList" variable)
      // and converts each JSON object into a NewsModel object using the "fromJson" method of the NewsModel class.
      print("Number of articles: ${data["articles"].length}");
      return NewsModel.newsFromSnapshot(newsTempList);
    } catch (error) {
      throw error.toString();
    }
  }

  static Future<List<NewsModel>> searchNews(
      {required String query}) async {

    try {
      var uri = Uri.http(BASEURL, "v2/everything", {
        "q": query,
        "pageSize": "10",
        "domains": "techcrunch.com",
      });
      var response = await http.get(uri, headers: {
        "X-Api-key": API_KEY
        //check the documentation for (Request parameters) https://newsapi.org/docs/endpoints/everything
      });
      //print the error code and its message
      // log('Response status: ${response.statusCode}');
      // log('Response body: ${response.body}');

      //The function then uses the "jsonDecode" function to convert the JSON string into a Map object.
      // It iterates over the "articles" list in the Map object using a for loop and adds each article to a temporary list called "newsTempList".
      Map data = jsonDecode(response.body);
      List newsTempList = [];

      //The ['code'] and ['message'] are based on the documentation of News API(error section)
      if (data['code'] != null) {
        throw HttpException(data['message']);
        // throw data['message'];
      }
      for (var v in data["articles"]) {
        newsTempList.add(v);
        log(v.toString());
      }
      //returns a list of NewsModel objects that is created by calling the "newsFromSnapshot" method of the NewsModel class.
      //The "newsFromSnapshot" method takes a list of JSON objects (in this case, the "newsTempList" variable)
      // and converts each JSON object into a NewsModel object using the "fromJson" method of the NewsModel class.
      print("Number of articles: ${data["articles"].length}");
      return NewsModel.newsFromSnapshot(newsTempList);
    } catch (error) {
      throw error.toString();
    }
  }
}
