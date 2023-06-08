import 'package:flutter/material.dart';
import 'package:devolucion_modulo/ui/inputs/input_form.dart';
import 'package:devolucion_modulo/util/validation.dart';

// ignore: must_be_immutable
class CardBanco extends StatelessWidget {
  TextEditingController banco = TextEditingController();
  TextEditingController agencia = TextEditingController();
  TextEditingController telf = TextEditingController();
  TextEditingController cta = TextEditingController();
  TextEditingController tipo = TextEditingController();
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
                  hint: 'Banco',
                  enable: true,
                  icon: Icons.account_balance_outlined,
                  validator: (value) {
                    return null;
                  },
                  controller: banco,
                  regx: rgx.letras,
                  length: 40,
                  onEditingComplete: () {},
                  onChanged: (value) {}),
            ),
            SizedBox(width: 8),
            Expanded(
              child: InputForm(
                  hint: 'Agencia',
                  enable: true,
                  icon: Icons.holiday_village_outlined,
                  validator: (value) {
                    return null;
                  },
                  controller: agencia,
                  regx: rgx.letras,
                  length: 40,
                  onEditingComplete: () {},
                  onChanged: (value) {}),
            ),
            SizedBox(width: 8),
            Expanded(
              child: InputForm(
                  hint: 'N°.Cuenta',
                  enable: true,
                  icon: Icons.fact_check_outlined,
                  validator: (value) {
                    return null;
                  },
                  controller: cta,
                  regx: rgx.numeros,
                  length: 15,
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
                  controller: telf,
                  regx: rgx.numeros,
                  length: 10,
                  onEditingComplete: () {},
                  onChanged: (value) {}),
            ),
            SizedBox(width: 8),
            Expanded(
              child: InputForm(
                  hint: 'Tipo de Cuenta',
                  enable: true,
                  icon: Icons.bookmark_rounded,
                  validator: (value) {
                    return null;
                  },
                  controller: tipo,
                  regx: rgx.letras,
                  length: 7,
                  onEditingComplete: () {},
                  onChanged: (value) {}),
            ),
          ],
        ),
      ),
    );
  }
}
