import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';

class GlobalMethods {
  //The purpose of formattedDateText() method is to convert a date/time string into a formatted string that can be displayed in a user-friendly format.

  static String formattedDateText(String publishedAt) {
    //convert the publishedAt string into a DateTime object. The parsedData variable holds this DateTime object.
    final parsedData = DateTime.parse(publishedAt);
    //DateFormat is a pub.dev package(intl). For more information, please check: https://pub.dev/packages/intl
    //DateFormat class is used to format the parsedData DateTime object into a string with the desired format. The formatted string is stored in the formattedDate variable.
    String formattedDate = DateFormat("yyyy-MM-dd hh:mm:ss").format(parsedData);
    //to convert the formatted date string back into a DateTime object, which can then be used to extract various date and time properties.
    DateTime publishedDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(formattedDate);

    //returns a string in a specific format
    return "${publishedDate.day}/${publishedDate.month}/${publishedDate.year} At ${publishedDate.hour}:${publishedDate.minute}";
  }

  //since showDialog is Future type, we need to use Future method.
  //we need to make it static in order to access it directly from the GlobalMethods class
  static Future<void> errorDialog(
      {required String errorMessage, required BuildContext context}) async {
    // since we are inside the state class, we can access the context here
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(errorMessage),
            title: (Row(
              children: const [
                Icon(
                  IconlyBold.danger,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 8,
                ),
                Text("An Error Occurred!")
              ],
            )),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Okay',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          );
        });
  }
}
