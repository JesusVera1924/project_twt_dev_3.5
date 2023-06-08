import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
/*             SizedBox(
              height: 10,
            ),
            Image.asset('logoSinFondo.png',
                width: 120, height: 60, fit: BoxFit.cover), */
            SizedBox(
              height: 40,
            ),
            FittedBox(
              child: Text(
                'Bienvenido al Sistema',
                textAlign: TextAlign.start,
                style: GoogleFonts.montserratAlternates(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
