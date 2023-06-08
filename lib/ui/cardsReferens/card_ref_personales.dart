import 'package:flutter/material.dart';
import 'package:devolucion_modulo/ui/inputs/input_form.dart';
import 'package:devolucion_modulo/util/validation.dart';

// ignore: must_be_immutable
class CardRefPersonales extends StatelessWidget {
  TextEditingController nombre = TextEditingController();
  TextEditingController parentesco = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController ciudad = TextEditingController();
  Validation rgx = Validation();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Expanded(
              child: InputForm(
                  hint: 'Nombre',
                  enable: true,
                  icon: Icons.perm_identity_outlined,
                  validator: (value) {
                    return null;
                  },
                  controller: nombre,
                  regx: rgx.letras,
                  length: 20,
                  onEditingComplete: () {},
                  onChanged: (value) {}),
            ),
            SizedBox(width: 8),
            Expanded(
              child: InputForm(
                  hint: 'Parentesco',
                  enable: true,
                  icon: Icons.family_restroom_outlined,
                  validator: (value) {
                    return null;
                  },
                  controller: parentesco,
                  regx: rgx.letras,
                  length: 20,
                  onEditingComplete: () {},
                  onChanged: (value) {}),
            ),
            SizedBox(width: 8),
            Expanded(
              child: InputForm(
                  hint: 'Telefono',
                  enable: true,
                  icon: Icons.phone_android_outlined,
                  validator: (value) {
                    return null;
                  },
                  controller: telefono,
                  regx: rgx.numeros,
                  length: 10,
                  onEditingComplete: () {},
                  onChanged: (value) {}),
            ),
            SizedBox(width: 8),
            Expanded(
              child: InputForm(
                  hint: 'Ciudad',
                  enable: true,
                  icon: Icons.location_city_outlined,
                  validator: (value) {
                    return null;
                  },
                  controller: ciudad,
                  regx: rgx.letras,
                  length: 20,
                  onEditingComplete: () {},
                  onChanged: (value) {}),
            ),
          ],
        ),
      ),
    );
  }
}
