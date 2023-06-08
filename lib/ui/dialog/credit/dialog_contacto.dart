import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/mg0031.dart';
import 'package:devolucion_modulo/provider/credits_provider.dart';
import 'package:devolucion_modulo/ui/inputs/input_form.dart';
import 'package:devolucion_modulo/util/validation.dart';

Future dialogFamiliar(
    BuildContext context, Mg0031 obj, CreditsProvider provider) async {
  Validation rgx = Validation();

  TextEditingController _ct1N = TextEditingController(text: obj.ct1Nom);
  TextEditingController _ct1C = TextEditingController(text: obj.ct1Crg);
  TextEditingController _ct1T = TextEditingController(text: obj.ct1Tlf);
  TextEditingController _ct1E = TextEditingController(text: obj.ct1Ext);
  TextEditingController _ct1Co = TextEditingController(text: obj.ct1Cor);

  TextEditingController _ct2N = TextEditingController(text: obj.ct2Nom);
  TextEditingController _ct2C = TextEditingController(text: obj.ct2Crg);
  TextEditingController _ct2T = TextEditingController(text: obj.ct2Tlf);
  TextEditingController _ct2E = TextEditingController(text: obj.ct2Ext);
  TextEditingController _ct2Co = TextEditingController(text: obj.ct2Cor);

  TextEditingController _ct3N = TextEditingController(text: obj.ct3Nom);
  TextEditingController _ct3C = TextEditingController(text: obj.ct3Crg);
  TextEditingController _ct3T = TextEditingController(text: obj.ct3Tlf);
  TextEditingController _ct3E = TextEditingController(text: obj.ct3Ext);
  TextEditingController _ct3Co = TextEditingController(text: obj.ct3Cor);

  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text(
              'Personas a Contactar',
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
                          child: InputForm(
                              hint: 'Nombre',
                              enable: true,
                              icon: Icons.perm_identity_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _ct1N,
                              regx: rgx.letras,
                              length: 40,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Cargo',
                              enable: true,
                              icon: Icons.business_center_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _ct1C,
                              regx: rgx.letras,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Telefono',
                              enable: true,
                              icon: Icons.phone_android_rounded,
                              validator: (value) {
                                return null;
                              },
                              controller: _ct1T,
                              regx: rgx.numeros,
                              length: 10,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Extencion',
                              enable: true,
                              icon: Icons.phone_android_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _ct1E,
                              regx: rgx.numeros,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          flex: 2,
                          child: InputForm(
                              hint: 'Correo electronico',
                              enable: true,
                              icon: Icons.email_outlined,
                              validator: (value) {
                                if (value.length >= 1) {
                                  if (!EmailValidator.validate(value))
                                    return 'Email no válido';
                                }
                                return null;
                              },
                              controller: _ct1Co,
                              regx: rgx.correo,
                              length: 40,
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
                              hint: 'Nombre',
                              enable: true,
                              icon: Icons.perm_identity_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _ct2N,
                              regx: rgx.letras,
                              length: 40,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Cargo',
                              enable: true,
                              icon: Icons.business_center_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _ct2C,
                              regx: rgx.letras,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Telefono',
                              enable: true,
                              icon: Icons.phone_android_rounded,
                              validator: (value) {
                                return null;
                              },
                              controller: _ct2T,
                              regx: rgx.numeros,
                              length: 10,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Extencion',
                              enable: true,
                              icon: Icons.phone_android_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _ct2E,
                              regx: rgx.numeros,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          flex: 2,
                          child: InputForm(
                              hint: 'Correo electronico',
                              enable: true,
                              icon: Icons.email_outlined,
                              validator: (value) {
                                if (value.length >= 1) {
                                  if (!EmailValidator.validate(value))
                                    return 'Email no válido';
                                }
                                return null;
                              },
                              controller: _ct2Co,
                              regx: rgx.correo,
                              length: 40,
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
                              hint: 'Nombre',
                              enable: true,
                              icon: Icons.perm_identity_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _ct3N,
                              regx: rgx.letras,
                              length: 40,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Cargo',
                              enable: true,
                              icon: Icons.business_center_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _ct3C,
                              regx: rgx.letras,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Telefono',
                              enable: true,
                              icon: Icons.phone_android_rounded,
                              validator: (value) {
                                return null;
                              },
                              controller: _ct3T,
                              regx: rgx.numeros,
                              length: 10,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Extencion',
                              enable: true,
                              icon: Icons.phone_android_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _ct3E,
                              regx: rgx.numeros,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          flex: 2,
                          child: InputForm(
                              hint: 'Correo electronico',
                              enable: true,
                              icon: Icons.email_outlined,
                              validator: (value) {
                                if (value.length >= 1) {
                                  if (!EmailValidator.validate(value))
                                    return 'Email no válido';
                                }
                                return null;
                              },
                              controller: _ct3Co,
                              regx: rgx.correo,
                              length: 40,
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
                    if (states.contains(MaterialState.hovered))
                      return Color(0x4024F181);
                    return Colors.transparent;
                  })),
                  onPressed: () {
                    obj.ct1Nom = _ct1N.text;
                    obj.ct1Crg = _ct1C.text;
                    obj.ct1Tlf = _ct1T.text;
                    obj.ct1Ext = _ct1E.text;
                    obj.ct1Cor = _ct1Co.text;

                    obj.ct2Nom = _ct2N.text;
                    obj.ct2Crg = _ct2C.text;
                    obj.ct2Tlf = _ct2T.text;
                    obj.ct2Ext = _ct2E.text;
                    obj.ct2Cor = _ct2Co.text;

                    obj.ct3Nom = _ct3N.text;
                    obj.ct3Crg = _ct3C.text;
                    obj.ct3Tlf = _ct3T.text;
                    obj.ct3Ext = _ct3E.text;
                    obj.ct3Cor = _ct3Co.text;

                    provider.saveContacto(obj);
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
                    _ct1N.clear();
                    _ct1C.clear();
                    _ct1T.clear();
                    _ct1E.clear();
                    _ct1Co.clear();

                    _ct2N.clear();
                    _ct2C.clear();
                    _ct2T.clear();
                    _ct2E.clear();
                    _ct2Co.clear();

                    _ct3N.clear();
                    _ct3C.clear();
                    _ct3T.clear();
                    _ct3E.clear();
                    _ct3Co.clear();

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
