import 'package:flutter/material.dart';
import 'package:devolucion_modulo/router/router.dart';
import 'package:devolucion_modulo/services/navigation_services.dart';

class NoAccesPageView extends StatefulWidget {
  const NoAccesPageView({Key? key}) : super(key: key);

  @override
  _NoAccesPageViewState createState() => _NoAccesPageViewState();
}

class _NoAccesPageViewState extends State<NoAccesPageView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.only(top: 30.0),
              child: Image.asset(
                'assets/error.png',
                height: 160.0,
                fit: BoxFit.fill,
              )),
          Divider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Ups error.....!',
              style: TextStyle(fontSize: 32.0),
            ),
          ),
          Text(
            '400 - No tiene permiso para acceder al recurso solicitado',
            style: TextStyle(fontSize: 22.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Divider(
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
                icon: Icon(Icons.cancel_outlined),
                onPressed: () {
                  NavigationService.replaceTo(Flurorouter.menuRoute);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    return Color(0xD9b22222);
                  }),
                  elevation: MaterialStateProperty.resolveWith<double>(
                      (Set<MaterialState> states) {
                    return 2.0;
                  }),
                ),
                label: Text(
                  'Continuar',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                )),
          ),
        ],
      ),
    );
  }
}
