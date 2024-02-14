import 'package:devolucion_modulo/util/util_view.dart';
import 'package:flutter/material.dart';
import 'package:devolucion_modulo/api/return_api.dart';
import 'package:devolucion_modulo/models/permisos.dart';
import 'package:devolucion_modulo/models/usuario.dart';
import 'package:devolucion_modulo/provider/auth_provider.dart';
import 'package:devolucion_modulo/provider/banner_menu_provider.dart';
import 'package:devolucion_modulo/services/local_storage.dart';
import 'package:devolucion_modulo/services/navigation_services.dart';
import 'package:devolucion_modulo/ui/cards/custom_card.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  late Usuario user;

  @override
  void initState() {
    user = Provider.of<AuthProvider>(context, listen: false).cliente!;
    /* Provider.of<Mg0031Provider>(context, listen: false).checkObj(user.nicUsr)!; */
    super.initState();
  }

  void navigateTo(String routeName) {
    NavigationService.replaceTo(routeName);
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<BannerMenuProvider>(context);
    final api = ReturnApi();

    return Container(
      color: Colors.black26,
      child: Center(
        child: FutureBuilder<List<Permisos>>(
          future: api.queryPermisos(user.codUsr),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    for (final _fieldValue in snapshot.data!) ...[
                      _fieldValue.hpvPry == "L"
                          ? CustomCard(
                              text: _fieldValue.nomPry,
                              color: Color(int.parse(_fieldValue.clxPry)),
                              onPressed: () {
                                LocalStorage.prefs
                                    .setString('permiss', _fieldValue.perAcc);
                                sideMenuProvider.setTitleBanner(
                                    _fieldValue.l01Pry.toUpperCase());
                                navigateTo(_fieldValue.rtxPry);
                              },
                              icon: getIndexIcon(_fieldValue.idxPry))
                          : _fieldValue.hpvPry == "H"
                              ? CustomCard(
                                  text: _fieldValue.nomPry,
                                  color: Color(int.parse(_fieldValue.clxPry)),
                                  fontWeight: FontWeight.bold,
                                  onPressed: () =>
                                      UtilView.launchUrl(_fieldValue.rtxPry),
                                  icon: getIndexIcon(_fieldValue.idxPry))
                              : CustomCard(
                                  text: _fieldValue.nomPry,
                                  color: Color(int.parse(_fieldValue.clxPry)),
                                  fontWeight: FontWeight.bold,
                                  onPressed: () {
                                    LocalStorage.prefs.setString(
                                        'permiss', _fieldValue.perAcc);
                                    sideMenuProvider.setTitleBanner(
                                        _fieldValue.l01Pry.toUpperCase());
                                    navigateTo(
                                        _fieldValue.rtxPry + user.nicUsr);
                                  },
                                  icon: getIndexIcon(_fieldValue.idxPry)),
                    ]
                  ],
                );
              } else {
                return Text(
                  'No tiene permiso para acceder a ningún proyecto',
                  style: CustomLabels.h10
                      .copyWith(fontSize: 30, color: Colors.black),
                );
              }
            } else if (snapshot.hasError) {
              return const Center(child: CircularProgressIndicator());
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

IconData getIndexIcon(int index) {
  List<IconData> listIcon = [
    Icons.assignment_ind_outlined,
    Icons.assignment,
    Icons.approval,
    Icons.storefront_outlined,
    Icons.store_sharp,
    Icons.credit_card_outlined
  ];

  return listIcon[index];
}
