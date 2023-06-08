import 'package:flutter/material.dart';
import 'package:devolucion_modulo/ui/layouts/menu/widget/footer.dart';
import 'package:devolucion_modulo/ui/layouts/menu/widget/sidebar.dart';

class MenuLayout extends StatelessWidget {
  final Widget child;

  const MenuLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SideBar(), Expanded(child: child), Footer()],
        ),
      ),
    );
  }
}
