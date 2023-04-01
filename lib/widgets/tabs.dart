import 'package:flutter/material.dart';

// This TabsWidget widget class that creates a clickable container with a
// text label. The widget takes four required parameters: which shown as below

//to make the data more dynamically, we create this file
class TabsWidget extends StatelessWidget {
  const TabsWidget(
      {Key? key,
      required this.text,
      required this.color,
      required this.function,
      required this.fontSize})
      : super(key: key);

  final String text; //a string that represents the label of the container
  final Color color; //a color that represents the background color of the container
  final Function function; // a callback function that is called when the container is clicked
  final double fontSize; //a double that represents the font size of the label text

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: color),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
            ),
          )),
    );
  }
}
