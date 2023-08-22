import 'dart:math';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DateFormatter extends TextInputFormatter {
  static const _maxChars = 8;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = _format(newValue.text, '/'); //parseo

    return newValue.copyWith(text: text, selection: updateCursorPosition(text));
  }

  String _format(String value, String seperator) {
    value = value.replaceAll(seperator, '');
    var newString = '';
    int _min = min(value.length, _maxChars);
    for (int i = 0; i < _min; i++) {
      newString += value[i];
      if ((i == 1 || i == 3) && i != value.length - 1) {
        newString += seperator;
      }
    }
    if (newString.length == 10) {
      DateTime date = DateFormat('dd/MM/yyyy').parse(newString);
      newString =
          '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    }
    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}
