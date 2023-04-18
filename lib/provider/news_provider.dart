import 'package:flutter/cupertino.dart';
import 'package:news_app/services/news.api.dart';
import 'package:provider/provider.dart';

import '../models/news_model.dart';

//ChangeNotifier is a special class that enables the class to notify its listeners when a change is made to its data.
class NewsProvider with ChangeNotifier {

  List<NewsModel> newsList = [];

  //fetchAllNews method is a method that returns a future that resolves to a list of NewsModel objects.
  //It fetches the news data using the NewsAPIServices.getAllNews() method,
  // which is an asynchronous method that returns a list of NewsModel objects.
  Future<List<NewsModel>> fetchAllNews({required int pageIndex, required String sortBy}) async {
    newsList = await NewsAPIServices.getAllNews(page: pageIndex, sortBy: sortBy);
    return newsList;
  }

  //fetchTopHeadlines method is a method that returns a future that resolves to a list of NewsModel objects.
  //It fetches the news data using the NewsAPIServices.getAllNews() method,
  // which is an asynchronous method that returns a list of NewsModel objects.
  Future<List<NewsModel>> fetchTopHeadlines() async {
    newsList = await NewsAPIServices.getTopHeadlines();
    return newsList;
  }

  Future<List<NewsModel>> searchNewsProvider({required String query}) async {
    newsList = await NewsAPIServices.searchNews(query: query);
    return newsList;
  }

  //The method searches for the first occurrence of a NewsModel object in the newsList list
  // where the publishedAt property of the object matches the publishedAt parameter passed to the method.
  //In other words, the method is used to find a specific NewsModel object
  // from a list of NewsModel objects based on its publishedAt property value.
  NewsModel findByDate({required String? publishedAt}){
    return newsList.firstWhere((newsModel) => newsModel.publishedAt == publishedAt);
  }
}