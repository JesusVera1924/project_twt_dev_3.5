import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();

  String usuario = '';
  String password = '';

  bool validateForm() {
    if (formkey.currentState!.validate()) {
      /* print('Se ingreso a login de manera correcta');
      print('$email ====== $password'); */
      return true;
/*       if (usuario == password) {
        return true;
      } else {
        return false;
      } */
    } else {
      //print('No valido los campos');
      return false;
    }
  }
}
