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
        physics: const ClampingScrollPhysics(),
        children: [
          (size.width > 1000)
              ? _DesktopBody(child: child) //desktop
              : _MobileBody(child: child), //Mobile

          //linkBar
          const LinkBar()
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
          const SizedBox(height: 20),
          const CustomTitle(),
          SizedBox(
              height: MediaQuery.of(context).size.height - 300, child: child),
          const SizedBox(
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
          const Expanded(child: BackgroundLogo()),
          Container(
            width: 600,
            height: double.infinity,
            color: Colors.black,
            child: Column(
              children: [
                const CustomTitle(),
                const SizedBox(height: 40),
                Expanded(child: child)
              ],
            ),
          )
        ],
      ),
    );
  }
}
