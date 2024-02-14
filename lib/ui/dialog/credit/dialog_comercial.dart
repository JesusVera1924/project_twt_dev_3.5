import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/mg0031.dart';
import 'package:devolucion_modulo/provider/credits_provider.dart';
import 'package:devolucion_modulo/ui/inputs/input_form.dart';
import 'package:devolucion_modulo/util/validation.dart';

Future dialogComercial(
    BuildContext context, Mg0031 obj, CreditsProvider provider) async {
  Validation rgx = Validation();

  TextEditingController protesto = TextEditingController(text: "${obj.rc1Chp}");
  TextEditingController empresa = TextEditingController(text: obj.rc1Emp);
  TextEditingController ciudad = TextEditingController(text: obj.rc1Ciu);
  TextEditingController telefono = TextEditingController(text: obj.rc1Tlf);

  TextEditingController formaPago = TextEditingController(text: obj.rc1Fdp);
  TextEditingController valorC = TextEditingController(text: "${obj.rc1Vcr}");
  TextEditingController plazoC = TextEditingController(text: "${obj.rc1Pcr}");
  TextEditingController cupoC = TextEditingController(text: "${obj.rc1Ccr}");
  TextEditingController plazoCc = TextEditingController(text: "${obj.rc1Pcr}");
  TextEditingController montoC = TextEditingController(text: "${obj.rc1Mmc}");
  TextEditingController plazoMc = TextEditingController(text: "${obj.rc1Pdp}");

  TextEditingController protesto2 =
      TextEditingController(text: "${obj.rc2Chp}");
  TextEditingController empresa2 = TextEditingController(text: obj.rc2Emp);
  TextEditingController ciudad2 = TextEditingController(text: obj.rc2Ciu);
  TextEditingController telefono2 = TextEditingController(text: obj.rc2Tlf);

  TextEditingController formaPago2 = TextEditingController(text: obj.rc2Fdp);
  TextEditingController valorC2 = TextEditingController(text: "${obj.rc2Vcr}");
  TextEditingController plazoC2 = TextEditingController(text: "${obj.rc2Pcr}");
  TextEditingController cupoC2 = TextEditingController(text: "${obj.rc2Ccr}");
  TextEditingController plazoCc2 = TextEditingController(text: "${obj.rc2Pcr}");
  TextEditingController montoC2 = TextEditingController(text: "${obj.rc2Mmc}");
  TextEditingController plazoMc2 = TextEditingController(text: "${obj.rc2Pdp}");

  TextEditingController protesto3 =
      TextEditingController(text: "${obj.rc3Chp}");
  TextEditingController empresa3 = TextEditingController(text: obj.rc3Emp);
  TextEditingController ciudad3 = TextEditingController(text: obj.rc3Ciu);
  TextEditingController telefono3 = TextEditingController(text: obj.rc3Tlf);

  TextEditingController formaPago3 = TextEditingController(text: obj.rc3Fdp);
  TextEditingController valorC3 = TextEditingController(text: "${obj.rc3Vcr}");
  TextEditingController plazoC3 = TextEditingController(text: "${obj.rc3Pcr}");
  TextEditingController cupoC3 = TextEditingController(text: "${obj.rc3Ccr}");
  TextEditingController plazoCc3 = TextEditingController(text: "${obj.rc3Pcr}");
  TextEditingController montoC3 = TextEditingController(text: "${obj.rc3Mmc}");
  TextEditingController plazoMc3 = TextEditingController(text: "${obj.rc3Pdp}");

  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text('Referencias Comerciales'),
            content: SizedBox(
              width: 1000,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
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
                        const SizedBox(width: 5),
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
                        const SizedBox(width: 5),
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
                        const SizedBox(width: 5),
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
                        const SizedBox(width: 5),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
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
                        const SizedBox(width: 5),
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
                        const SizedBox(width: 5),
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
                        const SizedBox(width: 5),
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
                        const SizedBox(width: 5),
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
                        const SizedBox(width: 5),
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
                  ),
                  const Divider(thickness: 1),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: InputForm(
                              hint: 'Numero de protesto',
                              enable: true,
                              icon: Icons.format_list_numbered_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: protesto2,
                              regx: rgx.numeros,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Empresa',
                              enable: true,
                              icon: Icons.business_sharp,
                              validator: (value) {
                                return null;
                              },
                              controller: empresa2,
                              regx: rgx.letras,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Ciudad',
                              enable: true,
                              icon: Icons.location_city_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: ciudad2,
                              regx: rgx.letras,
                              length: 15,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Telefono',
                              enable: true,
                              icon: Icons.phone_android_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: telefono2,
                              regx: rgx.numeros,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Forma de Pago',
                              enable: true,
                              icon: Icons.bookmark_rounded,
                              validator: (value) {
                                return null;
                              },
                              controller: formaPago2,
                              regx: rgx.letras,
                              length: 7,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: InputForm(
                              hint: 'Valor de Credito',
                              enable: true,
                              icon: Icons.monetization_on_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: valorC2,
                              regx: rgx.decimal,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Plazo de credito',
                              enable: true,
                              icon: Icons.access_time_rounded,
                              validator: (value) {
                                return null;
                              },
                              controller: plazoC2,
                              regx: rgx.numeros,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Cupo de Credito',
                              enable: true,
                              icon: Icons.monetization_on_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: cupoC2,
                              regx: rgx.decimal,
                              length: 15,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Plazo de cupo',
                              enable: true,
                              icon: Icons.access_time_rounded,
                              validator: (value) {
                                return null;
                              },
                              controller: plazoCc2,
                              regx: rgx.numeros,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Monto de Compras',
                              enable: true,
                              icon: Icons.monetization_on_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: montoC2,
                              regx: rgx.decimal,
                              length: 7,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Plazo de compras',
                              enable: true,
                              icon: Icons.access_time_rounded,
                              validator: (value) {
                                return null;
                              },
                              controller: plazoMc2,
                              regx: rgx.numeros,
                              length: 7,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 1),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: InputForm(
                              hint: 'Numero de protesto',
                              enable: true,
                              icon: Icons.format_list_numbered_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: protesto3,
                              regx: rgx.numeros,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Empresa',
                              enable: true,
                              icon: Icons.business_sharp,
                              validator: (value) {
                                return null;
                              },
                              controller: empresa3,
                              regx: rgx.letras,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Ciudad',
                              enable: true,
                              icon: Icons.location_city_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: ciudad3,
                              regx: rgx.letras,
                              length: 15,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Telefono',
                              enable: true,
                              icon: Icons.phone_android_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: telefono3,
                              regx: rgx.numeros,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Forma de Pago',
                              enable: true,
                              icon: Icons.bookmark_rounded,
                              validator: (value) {
                                return null;
                              },
                              controller: formaPago3,
                              regx: rgx.letras,
                              length: 7,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: InputForm(
                              hint: 'Valor de Credito',
                              enable: true,
                              icon: Icons.monetization_on_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: valorC3,
                              regx: rgx.decimal,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Plazo de credito',
                              enable: true,
                              icon: Icons.access_time_rounded,
                              validator: (value) {
                                return null;
                              },
                              controller: plazoC3,
                              regx: rgx.numeros,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Cupo de Credito',
                              enable: true,
                              icon: Icons.monetization_on_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: cupoC3,
                              regx: rgx.decimal,
                              length: 15,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Plazo de cupo',
                              enable: true,
                              icon: Icons.access_time_rounded,
                              validator: (value) {
                                return null;
                              },
                              controller: plazoCc3,
                              regx: rgx.numeros,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Monto de Compras',
                              enable: true,
                              icon: Icons.monetization_on_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: montoC3,
                              regx: rgx.decimal,
                              length: 7,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Plazo de compras',
                              enable: true,
                              icon: Icons.access_time_rounded,
                              validator: (value) {
                                return null;
                              },
                              controller: plazoMc3,
                              regx: rgx.numeros,
                              length: 7,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  style: ButtonStyle(backgroundColor:
                      MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return const Color(0x4024F181);
                    }
                    return Colors.transparent;
                  })),
                  onPressed: () {
                    obj.rc1Emp = empresa.text;
                    obj.rc1Ciu = ciudad.text;
                    obj.rc1Tlf = telefono.text;

                    obj.rc1Vcr = double.parse(valorC.text);

                    obj.rc1Dcr = int.parse(plazoCc.text);
                    obj.rc1Pcr = int.parse(plazoC.text);
                    obj.rc1Ccr = double.parse(cupoC.text);

                    obj.rc1Fdp = formaPago.text;
                    obj.rc1Chp = int.parse(protesto.text);
                    obj.rc1Mmc = double.parse(montoC.text);
                    obj.rc1Pdp = double.parse(plazoMc.text);

                    obj.rc2Emp = empresa2.text;
                    obj.rc2Ciu = ciudad2.text;
                    obj.rc2Tlf = telefono2.text;

                    obj.rc2Vcr = double.parse(valorC2.text);

                    obj.rc2Dcr = int.parse(plazoCc2.text);
                    obj.rc2Pcr = int.parse(plazoC2.text);
                    obj.rc2Ccr = double.parse(cupoC2.text);

                    obj.rc2Fdp = formaPago2.text;
                    obj.rc2Chp = int.parse(protesto2.text);
                    obj.rc2Mmc = double.parse(montoC2.text);
                    obj.rc2Pdp = double.parse(plazoMc2.text);

                    obj.rc3Emp = empresa3.text;
                    obj.rc3Ciu = ciudad3.text;
                    obj.rc3Tlf = telefono3.text;

                    obj.rc3Vcr = double.parse(valorC3.text);

                    obj.rc3Dcr = int.parse(plazoCc3.text);
                    obj.rc3Pcr = int.parse(plazoC3.text);
                    obj.rc3Ccr = double.parse(cupoC3.text);

                    obj.rc3Fdp = formaPago3.text;
                    obj.rc3Chp = int.parse(protesto3.text);
                    obj.rc3Mmc = double.parse(montoC3.text);
                    obj.rc3Pdp = double.parse(plazoMc3.text);

                    Navigator.of(context).pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Guardar'),
                  )),
              TextButton(
                  style: ButtonStyle(backgroundColor:
                      MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return const Color(0x1A24F181);
                    }
                    return Colors.transparent;
                  })),
                  onPressed: () {
                    protesto.clear();
                    empresa.clear();
                    ciudad.clear();
                    telefono.clear();
                    formaPago.clear();
                    valorC.clear();
                    plazoC.clear();
                    cupoC.clear();
                    plazoCc.clear();
                    montoC.clear();
                    plazoMc.clear();

                    protesto2.clear();
                    empresa2.clear();
                    ciudad2.clear();
                    telefono2.clear();
                    formaPago2.clear();
                    valorC2.clear();
                    plazoC2.clear();
                    cupoC2.clear();
                    plazoCc2.clear();
                    montoC2.clear();
                    plazoMc2.clear();

                    protesto3.clear();
                    empresa3.clear();
                    ciudad3.clear();
                    telefono3.clear();
                    formaPago3.clear();
                    valorC3.clear();
                    plazoC3.clear();
                    cupoC3.clear();
                    plazoCc3.clear();
                    montoC3.clear();
                    plazoMc3.clear();

                    Navigator.of(context).pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Cancelar'),
                  )),
            ],
          );
        });
      });
}
