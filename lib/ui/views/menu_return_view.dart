import 'package:flutter/material.dart';
import 'package:devolucion_modulo/provider/banner_menu_provider.dart';
import 'package:devolucion_modulo/router/router.dart';
import 'package:devolucion_modulo/services/navigation_services.dart';
import 'package:devolucion_modulo/ui/cards/custom_card.dart';
import 'package:provider/provider.dart';

class MenuReturnView extends StatefulWidget {
  @override
  _MenuReturnViewState createState() => _MenuReturnViewState();
}

class _MenuReturnViewState extends State<MenuReturnView> {
  void navigateTo(String routeName) {
    NavigationService.replaceTo(routeName);
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<BannerMenuProvider>(context);
    return Container(
      color: Colors.black26,
      child: Center(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            CustomCard(
                text: 'Solicitud de Devolución o garantia',
                fontWeight: FontWeight.w400,
                color: Colors.blueAccent,
                onPressed: () {
                  sideMenuProvider
                      .setTitleBanner('Solicitud de Devolución o garantía');
                  navigateTo(Flurorouter.requestRoute);
                },
                icon: Icons.assignment),
            CustomCard(
                text: 'Seguimiento de Devolución',
                fontWeight: FontWeight.w400,
                color: Colors.greenAccent,
                onPressed: () {
                  sideMenuProvider
                      .setTitleBanner('Consulta de Devolución o garantía');
                  navigateTo(Flurorouter.traicingRoute);
                },
                icon: Icons.assignment),
            CustomCard(
                text: 'Atras',
                fontWeight: FontWeight.w400,
                color: Colors.redAccent,
                onPressed: () {
                  sideMenuProvider.setTitleBanner('Menu Principal - Cojapan');
                  navigateTo(Flurorouter.menuRoute);
                },
                icon: Icons.arrow_back_outlined),
          ],
        ),
      ),
    );
  }
}
