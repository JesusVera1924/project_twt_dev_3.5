import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final IconData icon;

  const CustomIconButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.color = Colors.redAccent,
    this.isFilled = false,
  }) : super(key: key);
//Color(0xFFEE376E)
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(StadiumBorder()),
          backgroundColor: MaterialStateProperty.all(color.withOpacity(0.5)),
          overlayColor: MaterialStateProperty.all(color.withOpacity(0.9)),
        ),
        onPressed: () => onPressed(),
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ));
  }
}
