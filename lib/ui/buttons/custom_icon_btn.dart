import 'package:flutter/material.dart';

class CustomIconBtn extends StatelessWidget {
  final Function onPressed;
  final Color color;
  final bool isFilled;
  final IconData icon;
  final String msj;

  const CustomIconBtn({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.msj,
    this.color = Colors.redAccent,
    this.isFilled = false,
  }) : super(key: key);
//Color(0xFFEE376E)
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: msj,
      child: OutlinedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(const StadiumBorder()),
            backgroundColor: MaterialStateProperty.all(color.withOpacity(0.5)),
            overlayColor: MaterialStateProperty.all(color.withOpacity(0.9)),
          ),
          onPressed: () => onPressed(),
          child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(icon, color: Colors.black, size: 21))),
    );
  }
}
