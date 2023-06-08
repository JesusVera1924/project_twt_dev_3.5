import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final List<Widget> listW;
  final String titulo;
  const Navbar({Key? key, required this.listW, required this.titulo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(top: 8, right: 10, left: 10),
      decoration: buildBoxDecoration(),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(titulo,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
          const Spacer(),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 250),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var item in listW) ...[
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: item)
                ]
              ],
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      color: Colors.white,
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]);
}
