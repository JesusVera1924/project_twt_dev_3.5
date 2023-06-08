import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:devolucion_modulo/ui/inputs/custom_inputs.dart';

class InputBod extends StatelessWidget {
  final Function onEditingComplete;
  final Function? onChanged;
  final bool enable;
  final String regx;
  final int length;
  final String hint;
  final TextEditingController? controller;
  final bool formatt;
  final TextAlign textAlign;

  const InputBod(
      {Key? key,
      required this.hint,
      required this.regx,
      required this.length,
      required this.onEditingComplete,
      required this.onChanged,
      this.textAlign = TextAlign.start,
      this.formatt = false,
      this.controller,
      this.enable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: textAlign,
      onChanged: (value) => onChanged!(value),
      onEditingComplete: () => onEditingComplete(),
      enabled: enable,
      controller: controller,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(regx)),
        LengthLimitingTextInputFormatter(length),
        //if (formatt) DateInputFormatter()
      ],
      style: TextStyle(fontSize: 14),
      decoration: CustomInputs.dialogInputDecoration(hint: hint),
    );
  }
}
