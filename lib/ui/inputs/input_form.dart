import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:devolucion_modulo/ui/inputs/custom_inputs.dart';

class InputForm extends StatelessWidget {
  final Function validator;
  final Function onEditingComplete;
  final Function? onChanged;
  final TextEditingController controller;
  final int maxLines;
  final bool enable;
  final String regx;
  final int length;
  final String hint;
  final IconData icon;
  final bool formatt;
  final bool mayuscula;
  final FocusNode? node;

  const InputForm(
      {Key? key,
      required this.hint,
      required this.icon,
      required this.validator,
      required this.controller,
      required this.regx,
      required this.length,
      required this.onEditingComplete,
      this.node,
      this.mayuscula = false,
      this.formatt = false,
      this.onChanged,
      this.maxLines = 1,
      this.enable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => onChanged!(value),
      validator: (value) => validator(value),
      onEditingComplete: () => onEditingComplete(),
      enabled: enable,
      controller: controller,
      maxLines: maxLines,
      focusNode: node,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(regx)),
        LengthLimitingTextInputFormatter(length),
        //if (formatt) DateInputFormatter(),
        if (mayuscula) UpperCaseTextFormatter()
      ],
      style: const TextStyle(fontSize: 14),
      decoration: CustomInputs.formInputDecoration2(
        hint: hint,
        icon: icon,
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
