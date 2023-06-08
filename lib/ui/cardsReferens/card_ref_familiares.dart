import 'package:flutter/material.dart';
import 'package:devolucion_modulo/ui/inputs/input_form.dart';
import 'package:devolucion_modulo/util/validation.dart';

// ignore: must_be_immutable
class CardRefFamiliares extends StatelessWidget {
  TextEditingController nombre = TextEditingController();
  TextEditingController cargo = TextEditingController();
  TextEditingController telfono = TextEditingController();
  TextEditingController extencion = TextEditingController();
  TextEditingController correo = TextEditingController();
  Validation rgx = Validation();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: InputForm(
                  hint: 'Nombre',
                  enable: true,
                  icon: Icons.perm_identity_outlined,
                  validator: (value) {
                    return null;
                  },
                  controller: nombre,
                  regx: rgx.letras,
                  length: 40,
                  onEditingComplete: () {},
                  onChanged: (value) {}),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: InputForm(
                  hint: 'Cargo',
                  enable: true,
                  icon: Icons.business_center_outlined,
                  validator: (value) {
                    return null;
                  },
                  controller: cargo,
                  regx: rgx.letras,
                  length: 20,
                  onEditingComplete: () {},
                  onChanged: (value) {}),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: InputForm(
                  hint: 'Correo electronico',
                  enable: true,
                  icon: Icons.email_outlined,
                  validator: (value) {
                    return null;
                  },
                  controller: correo,
                  regx: rgx.correo,
                  length: 40,
                  onEditingComplete: () {},
                  onChanged: (value) {}),
            ),
            SizedBox(width: 8),
            Expanded(
              child: InputForm(
                  hint: 'Telefono',
                  enable: true,
                  icon: Icons.phone_android_rounded,
                  validator: (value) {
                    return null;
                  },
                  controller: telfono,
                  regx: rgx.numeros,
                  length: 15,
                  onEditingComplete: () {},
                  onChanged: (value) {}),
            ),
            SizedBox(width: 8),
            Expanded(
              child: InputForm(
                  hint: 'Extencion',
                  enable: true,
                  icon: Icons.phone_android_outlined,
                  validator: (value) {
                    return null;
                  },
                  controller: extencion,
                  regx: rgx.numeros,
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
