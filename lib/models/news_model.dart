// " NewsModel" class which represents a news article.
// The purpose of this class is to provide a way to convert JSON data (which is a common format for exchanging data on the web)
// into an instance of the NewsModel class, and vice versa.
import 'package:flutter/material.dart';
import 'package:news_app/services/global_methods.dart';
import 'package:reading_time/reading_time.dart';

//ChangeNotifier is a way to make the NewsModel class a provider in Flutter,
// meaning that it can notify its listeners when its state changes.
//it capable of notifying its listeners about changes to its state.
//commonly used for classes that manage some kind of data in a Flutter app, such as a user profile, shopping cart
class NewsModel with ChangeNotifier{
  //several properties, which represent different attributes of a news article.
  String newsId,
      sourceName,
      authorName,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      dateToShow,
      content,
      readingTimeText;

  //constructor
  NewsModel({
    required this.newsId,
    required this.sourceName,
    required this.authorName,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.dateToShow,
    required this.content,
    required this.readingTimeText,
  });

  //this method is a special constructor that takes a dynamic object
  // (in this case, a JSON object) and returns an instance of the NewsModel class.
  //This method maps the JSON object's properties to the corresponding properties of the NewsModel object.
  factory NewsModel.fromJson(dynamic json){
    //please check carefully the ["name here"] should be exactly same. May use Postman to check.

    //initialize since we want to use these 3 properties for readingTimeText property.
    String title =  json["title"] ?? "";
    String content = json["content"] ?? "";
    String description = json["description"] ?? "";
    String dateToShow = "";
    //check the publishedAt is not null, then pass the formattedDateText from global_methods.dart file, to the dateToShow property.
    if(json["publishedAt"] != null) {
      dateToShow = GlobalMethods.formattedDateText(json["publishedAt"]);
    }

    return NewsModel(newsId: json["source"]["id"] ?? "",
        sourceName: json["source"]["name"] ?? "",
        authorName: json["author"] ?? "",
        title: title,
        description: description,
        url: json["url"] ?? "",
        urlToImage: json["urlToImage"] ?? "https://cdn-2.tstatic.net/jatim/foto/bank/images/Chat-GPT-merupakan-produk-dari-OpenAI.jpg",
        publishedAt: json["publishedAt"] ?? "",
        content: content,
        dateToShow: dateToShow,
        //readingTime is a package from pub.dev, for more information, check: https://pub.dev/packages/reading_time
        readingTimeText: readingTime(title + description + content).msg,
    );
  }

  //this method takes a list of JSON objects, and maps each of them to an instance of the NewsModel class using
  // the "fromJson" method. It returns a list of NewsModel objects.
  static List<NewsModel> newsFromSnapshot (List newSnapshot){
    return newSnapshot.map((json) {
      return NewsModel.fromJson(json);
    }).toList();
  }

  //this method takes an instance of the NewsModel class and converts it into a JSON object.
  // It does this by creating a new Map object and adding the NewsModel properties as key-value pairs.
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = {};
    data["NewsId"] = newsId;
    data["sourceName"] = sourceName;
    data["authorName"] = authorName;
    data["title"] = title;
    data["description"] = description;
    data["url"] = url;
    data["urlToImage"] = urlToImage;
    data["publishedAt"] = publishedAt;
    data["dateToShow"] = dateToShow;
    data["content"] = content;
    data["readingTimeText"] = readingTimeText;
    return data;
  }

  // @override
  // String toString() {
  //   return "news {news_id: $newsId}";
  // }
}