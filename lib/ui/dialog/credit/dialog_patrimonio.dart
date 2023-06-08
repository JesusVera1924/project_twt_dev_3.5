import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/mg0031.dart';
import 'package:devolucion_modulo/provider/credits_provider.dart';
import 'package:devolucion_modulo/ui/inputs/custom_inputs.dart';
import 'package:devolucion_modulo/ui/inputs/input_form.dart';
import 'package:devolucion_modulo/util/util_view.dart';
import 'package:devolucion_modulo/util/validation.dart';

Future dialogPatrimonio(
    BuildContext context, Mg0031 obj, CreditsProvider provider) async {
  final rgx = Validation();

  final _rd1N = TextEditingController(text: obj.rd1Nom);
  final _rd1U = TextEditingController(text: obj.rd1Ubi);
  final _rd1V = TextEditingController(text: "${obj.rd1Val}");

  final _rd2N = TextEditingController(text: obj.rd2Nom);
  final _rd2U = TextEditingController(text: obj.rd2Ubi);
  final _rd2V = TextEditingController(text: "${obj.rd2Val}");

  final _rd3N = TextEditingController(text: obj.rd3Nom);
  final _rd3U = TextEditingController(text: obj.rd3Ubi);
  final _rd3V = TextEditingController(text: "${obj.rd3Val}");

  String selectOp1 = obj.rd1Hip == "S" ? "Si" : "No";
  String selectOp2 = obj.rd2Hip == "S" ? "Si" : "No";
  String selectOp3 = obj.rd3Hip == "S" ? "Si" : "No";

  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text(
              'Patrimonio',
            ),
            content: Container(
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
                              hint: 'Nombre',
                              enable: true,
                              icon: Icons.perm_identity_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _rd1N,
                              regx: rgx.letras,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          flex: 2,
                          child: InputForm(
                              hint: 'Ubicacion',
                              enable: true,
                              icon: Icons.pin_drop_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _rd1U,
                              regx: rgx.letras,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Valor',
                              enable: true,
                              icon: Icons.monetization_on_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _rd1V,
                              regx: rgx.decimal,
                              length: 15,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectOp1,
                            onChanged: (value) {
                              setState(() {
                                selectOp1 = value!;
                                obj.rd1Hip = selectOp1.substring(0, 1);
                              });
                            },
                            items: UtilView.lisDecision.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
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
                  Divider(thickness: 1),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
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
                              controller: _rd2N,
                              regx: rgx.letras,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          flex: 2,
                          child: InputForm(
                              hint: 'Ubicacion',
                              enable: true,
                              icon: Icons.pin_drop_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _rd2U,
                              regx: rgx.letras,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Valor',
                              enable: true,
                              icon: Icons.monetization_on_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _rd2V,
                              regx: rgx.decimal,
                              length: 15,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectOp2,
                            onChanged: (value) {
                              setState(() {
                                selectOp2 = value!;
                                obj.rd2Hip = selectOp2.substring(0, 1);
                              });
                            },
                            items: UtilView.lisDecision.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
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
                  Divider(thickness: 1),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
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
                              controller: _rd3N,
                              regx: rgx.letras,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          flex: 2,
                          child: InputForm(
                              hint: 'Ubicacion',
                              enable: true,
                              icon: Icons.pin_drop_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _rd3U,
                              regx: rgx.letras,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Valor',
                              enable: true,
                              icon: Icons.monetization_on_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _rd3V,
                              regx: rgx.decimal,
                              length: 15,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectOp3,
                            onChanged: (value) {
                              setState(() {
                                selectOp3 = value!;
                                obj.rd3Hip = selectOp3.substring(0, 1);
                              });
                            },
                            items: UtilView.lisDecision.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
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
                    if (states.contains(MaterialState.hovered))
                      return Color(0x4024F181);
                    return Colors.transparent;
                  })),
                  onPressed: () {
                    obj.rd1Nom = _rd1N.text;
                    obj.rd1Ubi = _rd1U.text;
                    obj.rd1Val = double.parse(_rd1V.text);

                    obj.rd2Nom = _rd2N.text;
                    obj.rd2Ubi = _rd2U.text;
                    obj.rd2Val = double.parse(_rd2V.text);

                    obj.rd3Nom = _rd3N.text;
                    obj.rd3Ubi = _rd3U.text;
                    obj.rd3Val = double.parse(_rd3V.text);

                    provider.savePatrimonio(obj);
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Guardar'),
                  )),
              TextButton(
                  style: ButtonStyle(backgroundColor:
                      MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered))
                      return Color(0x1A24F181);
                    return Colors.transparent;
                  })),
                  onPressed: () {
                    _rd1N.clear();
                    _rd1U.clear();
                    _rd1V.clear();

                    _rd2N.clear();
                    _rd2U.clear();
                    _rd2V.clear();

                    _rd3N.clear();
                    _rd3U.clear();
                    _rd3V.clear();
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Cancelar'),
                  )),
            ],
          );
        });
      });
}
