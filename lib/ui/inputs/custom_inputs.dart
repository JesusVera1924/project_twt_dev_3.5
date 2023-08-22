import 'package:flutter/material.dart';

class CustomInputs {
  static InputDecoration loginInputDecoration(
      {required String hint, required String label, required IconData icon}) {
    return InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        hintText: hint,
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: Colors.grey,
        ),
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.grey));
  }

  static InputDecoration boxInputDecoration2({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      hintText: hint,
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      prefixIcon: Icon(icon, color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration boxInputDecorationDatePicker(
      {required String labelText, required Function fc}) {
    return InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
        labelText: labelText,
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
        suffixIcon: InkWell(
          onTap: () => fc(),
          child: const Icon(Icons.calendar_today),
        ));
  }

  static InputDecoration cantInputDecoration({required String hint}) {
    return InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green.withOpacity(0.4)),
        ),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
        labelStyle: TextStyle(color: Colors.grey, fontSize: 14));
  }

  static InputDecoration searchInputDecoration(
      {required String hint, required IconData icon}) {
    return InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: Colors.grey,
        ),
        labelStyle: TextStyle(color: Colors.grey),
        hintStyle: TextStyle(color: Colors.grey));
  }

  static InputDecoration formInputDecoration(
      {required String hint, required IconData icon}) {
    return InputDecoration(
        filled: true,
        isDense: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none),
        hintText: hint,
        prefixIcon: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(icon, size: 20, color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          // borderSide: BorderSide(color: kTitleTextColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Color(0xFFEE376E))),
        contentPadding: EdgeInsets.all(5),
        labelStyle: TextStyle(color: Colors.grey),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14));
  }

  static InputDecoration formInputDecoration2(
      {required String hint, required IconData icon}) {
    return InputDecoration(
        filled: true,
        isDense: true,
        labelText: hint,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none),
        hintText: hint,
        prefixIcon: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(icon, size: 20, color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          // borderSide: BorderSide(color: kTitleTextColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Color(0xFFEE376E))),
        contentPadding: EdgeInsets.all(5),
        labelStyle: TextStyle(color: Colors.grey),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14));
  }

  static InputDecoration dialogInputDecoration({required String hint}) {
    return InputDecoration(
        filled: true,
        isDense: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.blueGrey),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.blueGrey),
        ),
        hintText: hint,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Color(0xFFEE376E))),
        contentPadding: const EdgeInsets.only(top: 12, bottom: 12, left: 8),
        labelStyle: const TextStyle(color: Colors.grey),
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14));
  }
}
