import 'package:flutter/material.dart';

import '../models/menuItem.dart';

class MenusItems extends StatelessWidget {
  final MenuItem item;

  const MenusItems({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 16),
        const SizedBox(width: 10),
        Text(item.text,
            maxLines: 2,
            style: const TextStyle(color: Colors.white, fontSize: 13)),
      ],
    );
  }
}
