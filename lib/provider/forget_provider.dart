import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/usuario.dart';

class ForgetProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController codRef = TextEditingController();
  TextEditingController nomRef = TextEditingController();

  Usuario? user;

  clearValue() {
    email.clear();
    codRef.clear();
    nomRef.clear();
  }

  validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
