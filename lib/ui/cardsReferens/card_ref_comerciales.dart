import 'package:flutter/material.dart';
import 'package:devolucion_modulo/ui/inputs/input_form.dart';
import 'package:devolucion_modulo/util/validation.dart';

// ignore: must_be_immutable
class CardRefComerciles extends StatelessWidget {
  TextEditingController protesto = TextEditingController();
  TextEditingController empresa = TextEditingController();
  TextEditingController ciudad = TextEditingController();
  TextEditingController telefono = TextEditingController();

  TextEditingController formaPago = TextEditingController();
  TextEditingController valorC = TextEditingController();
  TextEditingController plazoC = TextEditingController();
  TextEditingController cupoC = TextEditingController();
  TextEditingController plazoCc = TextEditingController();
  TextEditingController montoC = TextEditingController();
  TextEditingController plazoMc = TextEditingController();
  Validation rgx = Validation();

  CardRefComerciles({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InputForm(
                      hint: 'Numero de protesto',
                      enable: true,
                      icon: Icons.format_list_numbered_outlined,
                      validator: (value) {
                        return null;
                      },
                      controller: protesto,
                      regx: rgx.numeros,
                      length: 20,
                      onEditingComplete: () {},
                      onChanged: (value) {}),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: InputForm(
                      hint: 'Empresa',
                      enable: true,
                      icon: Icons.business_sharp,
                      validator: (value) {
                        return null;
                      },
                      controller: empresa,
                      regx: rgx.letras,
                      length: 20,
                      onEditingComplete: () {},
                      onChanged: (value) {}),
                ),
                const SizedBox(width: 8),
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
                      length: 15,
                      onEditingComplete: () {},
                      onChanged: (value) {}),
                ),
                const SizedBox(width: 8),
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
                      length: 20,
                      onEditingComplete: () {},
                      onChanged: (value) {}),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: InputForm(
                      hint: 'Forma de Pago',
                      enable: true,
                      icon: Icons.bookmark_rounded,
                      validator: (value) {
                        return null;
                      },
                      controller: formaPago,
                      regx: rgx.letras,
                      length: 7,
                      onEditingComplete: () {},
                      onChanged: (value) {}),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: InputForm(
                      hint: 'Valor de Credito',
                      enable: true,
                      icon: Icons.monetization_on_outlined,
                      validator: (value) {
                        return null;
                      },
                      controller: valorC,
                      regx: rgx.decimal,
                      length: 20,
                      onEditingComplete: () {},
                      onChanged: (value) {}),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: InputForm(
                      hint: 'Plazo de credito',
                      enable: true,
                      icon: Icons.access_time_rounded,
                      validator: (value) {
                        return null;
                      },
                      controller: plazoC,
                      regx: rgx.numeros,
                      length: 20,
                      onEditingComplete: () {},
                      onChanged: (value) {}),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: InputForm(
                      hint: 'Cupo de Credito',
                      enable: true,
                      icon: Icons.monetization_on_outlined,
                      validator: (value) {
                        return null;
                      },
                      controller: cupoC,
                      regx: rgx.decimal,
                      length: 15,
                      onEditingComplete: () {},
                      onChanged: (value) {}),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: InputForm(
                      hint: 'Plazo de cupo',
                      enable: true,
                      icon: Icons.access_time_rounded,
                      validator: (value) {
                        return null;
                      },
                      controller: plazoCc,
                      regx: rgx.numeros,
                      length: 20,
                      onEditingComplete: () {},
                      onChanged: (value) {}),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: InputForm(
                      hint: 'Monto de Compras',
                      enable: true,
                      icon: Icons.monetization_on_outlined,
                      validator: (value) {
                        return null;
                      },
                      controller: montoC,
                      regx: rgx.decimal,
                      length: 7,
                      onEditingComplete: () {},
                      onChanged: (value) {}),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: InputForm(
                      hint: 'Plazo de compras',
                      enable: true,
                      icon: Icons.access_time_rounded,
                      validator: (value) {
                        return null;
                      },
                      controller: plazoMc,
                      regx: rgx.numeros,
                      length: 7,
                      onEditingComplete: () {},
                      onChanged: (value) {}),
                ),
              ],
            ),
          ],
        ));
  }
}
