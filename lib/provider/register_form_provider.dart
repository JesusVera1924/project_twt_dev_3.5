import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String dni = '';
  String usuario = '';
  String codRef = '';
  String nomRef = '';
  String tlfRef = '';

  clearValue() {
    email = '';
    password = '';
    dni = '';
    usuario = '';
    codRef = '';
    nomRef = '';
    tlfRef = '';
  }

  validateForm() {
    if (formKey.currentState!.validate()) {
      if (nomRef != "" && codRef != "") {
        return true;
      }
      return false;
    } else {
      return false;
    }
  }
}
