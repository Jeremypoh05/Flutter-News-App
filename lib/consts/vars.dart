import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//enum used to define a set of named constants
//it is used to define the different types of news articles that can be displayed in the app.
enum NewsType {
  // constants defined in the NewsType enum, and they represent the two types of news articles that can be displayed
  //which means there are two possible values of the "NewsType" data type
  topTrending,
  allNews,
}

enum SortByEnum {
  relevancy, //articles more closely related to q come first
  popularity, //articles from popular sources and publishers come first
  publishedAt, //newest articles comes first
}

//declare the TextStyle and its fontSize to smallTextStyle variable
TextStyle smallTextStyle = GoogleFonts.montserrat(fontSize: 15);
TextStyle titleTextStyle = GoogleFonts.oswald(fontSize: 28, fontWeight: FontWeight.bold);

const List<String> searchKeywords = [
  "Sports",
  "Crypto",
  "War",
  "Movies",
  "Entertainment",
  "Weather",
  "Technology",
  "Business",
  "Health"
];