import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/mg0031.dart';

import 'package:devolucion_modulo/provider/credits_provider.dart';
import 'package:devolucion_modulo/ui/inputs/custom_inputs.dart';
import 'package:devolucion_modulo/ui/inputs/input_form.dart';
import 'package:devolucion_modulo/util/util_view.dart';
import 'package:devolucion_modulo/util/validation.dart';

Future dialogBanco(
    BuildContext context, Mg0031 obj, CreditsProvider provider) async {
  String selectCta1 = obj.rb1Tip == "C" ? "Corriente" : "Ahorro";
  String selectCta2 = obj.rb2Tip == "C" ? "Corriente" : "Ahorro";
  String selectCta3 = obj.rb3Tip == "C" ? "Corriente" : "Ahorro";

  final rgx = Validation();

  final _rb1B = TextEditingController(text: obj.rb1Bco);
  final _rb1A = TextEditingController(text: obj.rb1Agn);
  final _rb1C = TextEditingController(text: obj.rb1Cta);
  final _rb1T = TextEditingController(text: obj.rb1Tlf);

  final _rb2B = TextEditingController(text: obj.rb2Bco);
  final _rb2A = TextEditingController(text: obj.rb2Agn);
  final _rb2C = TextEditingController(text: obj.rb2Cta);
  final _rb2T = TextEditingController(text: obj.rb2Tlf);

  final _rb3B = TextEditingController(text: obj.rb3Bco);
  final _rb3A = TextEditingController(text: obj.rb3Agn);
  final _rb3C = TextEditingController(text: obj.rb3Cta);
  final _rb3T = TextEditingController(text: obj.rb3Tlf);

  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text('Referencias Bancarias'),
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
                          flex: 2,
                          child: InputForm(
                              hint: 'Banco',
                              enable: true,
                              icon: Icons.account_balance_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _rb1B,
                              regx: rgx.letras,
                              length: 40,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          flex: 2,
                          child: InputForm(
                              hint: 'Agencia',
                              enable: true,
                              icon: Icons.holiday_village_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _rb1A,
                              regx: rgx.letras,
                              length: 40,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          flex: 2,
                          child: InputForm(
                              hint: 'N°.Cuenta',
                              enable: true,
                              icon: Icons.fact_check_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _rb1C,
                              regx: rgx.numeros,
                              length: 15,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          flex: 2,
                          child: InputForm(
                              hint: 'Telefono',
                              enable: true,
                              icon: Icons.phone_android_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _rb1T,
                              regx: rgx.numeros,
                              length: 10,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectCta1,
                            onChanged: (value) {
                              setState(() {
                                selectCta1 = value!;
                                obj.rb1Tip = selectCta1.substring(0, 1);
                              });
                            },
                            items: UtilView.listTipoCta.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    )),
                              );
                            }).toList(),
                            decoration: CustomInputs.dialogInputDecoration(
                              hint: '',
                            ),
                          ),
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
                          flex: 2,
                          child: InputForm(
                              hint: 'Banco',
                              enable: true,
                              icon: Icons.account_balance_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _rb2B,
                              regx: rgx.letras,
                              length: 40,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          flex: 2,
                          child: InputForm(
                              hint: 'Agencia',
                              enable: true,
                              icon: Icons.holiday_village_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _rb2A,
                              regx: rgx.letras,
                              length: 40,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          flex: 2,
                          child: InputForm(
                              hint: 'N°.Cuenta',
                              enable: true,
                              icon: Icons.fact_check_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _rb2C,
                              regx: rgx.numeros,
                              length: 15,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          flex: 2,
                          child: InputForm(
                              hint: 'Telefono',
                              enable: true,
                              icon: Icons.phone_android_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _rb2T,
                              regx: rgx.numeros,
                              length: 10,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectCta2,
                            onChanged: (value) {
                              setState(() {
                                selectCta2 = value!;
                                obj.rb2Tip = selectCta2.substring(0, 1);
                              });
                            },
                            items: UtilView.listTipoCta.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    )),
                              );
                            }).toList(),
                            decoration: CustomInputs.dialogInputDecoration(
                              hint: '',
                            ),
                          ),
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
                          flex: 2,
                          child: InputForm(
                              hint: 'Banco',
                              enable: true,
                              icon: Icons.account_balance_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _rb3B,
                              regx: rgx.letras,
                              length: 40,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          flex: 2,
                          child: InputForm(
                              hint: 'Agencia',
                              enable: true,
                              icon: Icons.holiday_village_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _rb3A,
                              regx: rgx.letras,
                              length: 40,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          flex: 2,
                          child: InputForm(
                              hint: 'N°.Cuenta',
                              enable: true,
                              icon: Icons.fact_check_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _rb3C,
                              regx: rgx.numeros,
                              length: 15,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          flex: 2,
                          child: InputForm(
                              hint: 'Telefono',
                              enable: true,
                              icon: Icons.phone_android_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _rb3T,
                              regx: rgx.numeros,
                              length: 10,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectCta3,
                            onChanged: (value) {
                              setState(() {
                                selectCta3 = value!;
                                obj.rb3Tip = selectCta3.substring(0, 1);
                              });
                            },
                            items: UtilView.listTipoCta.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    )),
                              );
                            }).toList(),
                            decoration: CustomInputs.dialogInputDecoration(
                              hint: '',
                            ),
                          ),
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
                    obj.rb1Bco = _rb1B.text;
                    obj.rb1Agn = _rb1A.text;
                    obj.rb1Cta = _rb1C.text;
                    obj.rb1Tlf = _rb1T.text;

                    obj.rb2Bco = _rb2B.text;
                    obj.rb2Agn = _rb2A.text;
                    obj.rb2Cta = _rb2C.text;
                    obj.rb2Tlf = _rb2T.text;

                    obj.rb3Bco = _rb3B.text;
                    obj.rb3Agn = _rb3A.text;
                    obj.rb3Cta = _rb3C.text;
                    obj.rb3Tlf = _rb3T.text;

                    provider.saveBanco(obj);
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
                    _rb1B.clear();
                    _rb1A.clear();
                    _rb1C.clear();
                    _rb1T.clear();

                    _rb2B.clear();
                    _rb2A.clear();
                    _rb2C.clear();
                    _rb2T.clear();

                    _rb3B.clear();
                    _rb3A.clear();
                    _rb3C.clear();
                    _rb3T.clear();
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
