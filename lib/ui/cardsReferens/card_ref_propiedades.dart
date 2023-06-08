import 'package:flutter/material.dart';
import 'package:devolucion_modulo/ui/inputs/input_form.dart';
import 'package:devolucion_modulo/util/validation.dart';

// ignore: must_be_immutable
class CardRefPropiedades extends StatelessWidget {
  final TextEditingController nombre = TextEditingController();
  final TextEditingController ubicacion = TextEditingController();
  final TextEditingController valor = TextEditingController();
  final TextEditingController hipoteca = TextEditingController();
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
                  hint: 'Ubicacion',
                  enable: true,
                  icon: Icons.pin_drop_outlined,
                  validator: (value) {
                    return null;
                  },
                  controller: ubicacion,
                  regx: rgx.letras,
                  length: 20,
                  onEditingComplete: () {},
                  onChanged: (value) {}),
            ),
            SizedBox(width: 8),
            Expanded(
              child: InputForm(
                  hint: 'Valor',
                  enable: true,
                  icon: Icons.monetization_on_outlined,
                  validator: (value) {
                    return null;
                  },
                  controller: valor,
                  regx: rgx.decimal,
                  length: 15,
                  onEditingComplete: () {},
                  onChanged: (value) {}),
            ),
            SizedBox(width: 8),
            Expanded(
              child: InputForm(
                  hint: 'Hipoteca',
                  enable: true,
                  icon: Icons.house,
                  validator: (value) {
                    return null;
                  },
                  controller: hipoteca,
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
