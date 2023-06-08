import 'package:flutter/material.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';

class CustomLabelsForm extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight fontWeight;

  const CustomLabelsForm(
      {Key? key,
      required this.text,
      this.size = 18,
      this.fontWeight = FontWeight.bold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        text,
        style: CustomLabels.h2.copyWith(fontSize: size, fontWeight: fontWeight),
      ),
    );
  }
}
