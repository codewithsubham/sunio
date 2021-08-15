import 'package:flutter/material.dart';

class ShowMessage {
  static onErrorMessage(BuildContext context , String errMessage) {
    ScaffoldMessenger.of(context).showSnackBar(_displayMessage(errMessage));
  }

  static onCompletedMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(_displayMessage("completed"));
  }

  static SnackBar _displayMessage(String message) {
    return new SnackBar(
        content: Row(
          children: <Widget>[
            // add your preferred icon here
            Icon(
              Icons.close,
              color: Colors.white,
            ),
            // add your preferred text content here
            Text(message),
          ],
        ),
        backgroundColor: Colors.red,
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code tos undo the change.
            }));
  }
}
//asdad