import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devolucion_modulo/provider/auth_provider.dart';
import 'package:devolucion_modulo/services/navigation_services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _url = 'https://www.cojapan.com';
    void _launchURL() async => await canLaunch(_url)
        ? await launch(_url)
        : throw 'Could not launch $_url';

    return Container(
      height: 45,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.8, color: Color(0xCC232d37)),
        ),
        color: Color.fromRGBO(234, 234, 234, 1),
      ),
      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, 0,
          MediaQuery.of(context).size.width * 0.05, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
/*                   InkWell(
                onTap: () => {},
                child: const Text('TwT',
                    style: TextStyle(color: Colors.blue, fontSize: 12)),
              ),
              Text(' | ',
                  style: TextStyle(fontSize: 12, color: Color(0xCC232d37))), */
                  InkWell(
                    onTap: () => NavigationService.replaceTo('/menu'),
                    child: const Text('Inicio',
                        style: TextStyle(color: Colors.blue, fontSize: 12)),
                  ),
                  const Text(' | ',
                      style: TextStyle(fontSize: 12, color: Color(0xCC232d37))),
                  InkWell(
                    onTap: () => _launchURL(),
                    child: const Text('Cojapan',
                        style: TextStyle(color: Colors.blue, fontSize: 12)),
                  )
                ],
              ),
              Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: const Text('Copyright © 2021 - 2023',
                      style: TextStyle(
                          color: Color(0xCC232d37),
                          fontSize: 12,
                          letterSpacing: 0.23)))
            ],
          ),
          InkWell(
            onTap: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
            child: Row(
              children: [
                const Icon(
                  Icons.exit_to_app_rounded,
                  size: 30,
                  color: Color(0xD9b22222),
                ),
                Text(
                  'Cerrar Sesión',
                  style: GoogleFonts.montserratAlternates(
                      fontSize: 18, color: const Color(0xD9b22222)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


/*  InkWell(
            onTap: () => {},
            child: Image.asset('assets/logoSinFondo.png',
                fit: BoxFit.contain, height: 45, width: 120),
          ), */

          /* Text(
              'Cojapan',
              style: GoogleFonts.roboto(fontSize: 22, color: Color(0xD9b22222)),
            ), */