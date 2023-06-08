import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:devolucion_modulo/ui/inputs/custom_inputs.dart';

class InputDialog extends StatelessWidget {
  final Function? validator;
  final Function onEditingComplete;
  final Function? onChanged;
  final TextEditingController controller;
  final int maxLines;
  final bool enable;
  final String regx;
  final int length;
  final String hint;

  const InputDialog(
      {Key? key,
      required this.hint,
      required this.controller,
      required this.regx,
      required this.length,
      required this.onEditingComplete,
      this.validator,
      this.onChanged,
      this.maxLines = 1,
      this.enable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => onChanged!(value),
      validator: (value) => validator!(value),
      onEditingComplete: () => onEditingComplete(),
      enabled: enable,
      controller: controller,
      maxLines: maxLines,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(regx)),
        LengthLimitingTextInputFormatter(length),
      ],
      style: const TextStyle(fontSize: 11),
      decoration: CustomInputs.dialogInputDecoration(hint: hint),
    );
  }
}
