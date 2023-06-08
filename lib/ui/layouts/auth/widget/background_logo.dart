import 'package:flutter/material.dart';

class BackgroundLogo extends StatelessWidget {
  const BackgroundLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: builBoxDecoration(),
      child: Container(
        constraints: BoxConstraints(maxWidth: 400),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Image(
              image: AssetImage('assets/logoVertical.png'),
              width: 400,
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration builBoxDecoration() => BoxDecoration(
      image:
          DecorationImage(image: AssetImage('assets/cielo.jpg'), fit: BoxFit.cover));
}
