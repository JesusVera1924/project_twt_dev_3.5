import 'package:flutter/material.dart';
import 'package:devolucion_modulo/ui/buttons/link_text.dart';

class LinkBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        color: Colors.black,
        height: size.width > 1000 ? size.height * 0.07 : null,
        child: Wrap(
          alignment: WrapAlignment.start,
          children: [
            //Powered by TwT Copyrigh (c) 2021
            LinkText(
              text: 'Powered by TwT 1.0.0',
              onTap: () => {},
            ),
            if (size.width > 700) SizedBox(width: 460),
            LinkText(
              text: 'Copyrigh (c) 2021-2022',
              onTap: () => {},
            ),
          ],
        ));
  }
}