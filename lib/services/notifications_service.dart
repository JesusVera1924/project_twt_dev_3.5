import 'package:flutter/material.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

/*   static showSnackbarError(String message) {
    final snackBar = new SnackBar(
        backgroundColor: Color(0XFFCD5C5C),
        content:
            Text(message, style: TextStyle(color: Colors.white, fontSize: 20)));

    messengerKey.currentState!.showSnackBar(snackBar);
  } */

  static showSnackbar(String message) {
    final snackBar = SnackBar(
        content: Text(message,
            style: const TextStyle(color: Colors.white, fontSize: 20)));

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
