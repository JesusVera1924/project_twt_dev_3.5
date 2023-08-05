import 'package:flutter/material.dart';

class ResetFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String codigo = '';
  String password = '';
  String password2 = '';

  clearValue() {
    codigo = '';
    password = '';
    password2 = '';
  }

  validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
