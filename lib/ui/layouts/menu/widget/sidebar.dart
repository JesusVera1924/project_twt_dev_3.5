import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:devolucion_modulo/services/navigation_services.dart';

import 'package:provider/provider.dart';
import 'package:devolucion_modulo/provider/banner_menu_provider.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      decoration: builBoxDecoration(),
      height: 80,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onDoubleTap: () => NavigationService.replaceTo('/menu'),
              child: Image.asset('assets/logoSinFondo.png',
                  width: 150, height: 100, fit: BoxFit.cover),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(0.8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    Provider.of<BannerMenuProvider>(context).currentTitle,
                    style: GoogleFonts.montserratAlternates(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  'Comercial Japonesa Automotriz Cía. Ltda.',
                  style: GoogleFonts.montserratAlternates(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  BoxDecoration builBoxDecoration() =>
      const BoxDecoration(color: Color(0xD9b22222));
}
