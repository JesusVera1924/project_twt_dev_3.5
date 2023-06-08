import 'package:flutter/material.dart';
import 'package:devolucion_modulo/ui/layouts/auth/widget/background_logo.dart';
import 'package:devolucion_modulo/ui/layouts/auth/widget/custom_title.dart';
import 'package:devolucion_modulo/ui/layouts/auth/widget/links_bar.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;

  const AuthLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Scrollbar(
      //isAlwaysShown: true,
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          (size.width > 1000)
              ? _DesktopBody(child: child) //desktop
              : _MobileBody(child: child), //Mobile

          //linkBar
          LinkBar()
        ],
      ),
    ));
  }
}

class _MobileBody extends StatelessWidget {
  final Widget child;

  const _MobileBody({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          CustomTitle(),
          Container(
            width: double.infinity,
            height: 410,
            child: child,
          ),
          Container(
            width: double.infinity,
            height: 400,
            child: BackgroundLogo(),
          )
        ],
      ),
    );
  }
}

class _DesktopBody extends StatelessWidget {
  final Widget child;

  const _DesktopBody({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.95,
      color: Colors.black,
      child: Row(
        children: [
          //background logo empresa
          Expanded(child: BackgroundLogo()),
          Container(
            width: 600,
            height: double.infinity,
            color: Colors.black,
            child: Column(
              children: [
                CustomTitle(),
                SizedBox(
                  height: 40,
                ),
                Expanded(child: child)
              ],
            ),
          )
        ],
      ),
    );
  }
}
