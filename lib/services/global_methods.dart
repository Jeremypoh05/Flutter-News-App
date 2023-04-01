import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class GlobalMethods {
  //since showDialog is Future type, we need to use Future method.
  //we need to make it static in order to access it directly from the GlobalMethods class
  static Future<void> errorDialog({required String errorMessage, required BuildContext context}) async {
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