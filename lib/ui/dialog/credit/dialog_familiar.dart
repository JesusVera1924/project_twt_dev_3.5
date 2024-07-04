import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/mg0031.dart';
import 'package:devolucion_modulo/provider/credits_provider.dart';
import 'package:devolucion_modulo/ui/inputs/input_form.dart';
import 'package:devolucion_modulo/util/validation.dart';

Future dialogFamilias(
    BuildContext context, Mg0031 obj, CreditsProvider provider) async {
  Validation rgx = Validation();

  TextEditingController _nombre = TextEditingController(text: obj.rf1Nom);
  TextEditingController _parentesco = TextEditingController(text: obj.rf1Nex);
  TextEditingController _telefono = TextEditingController(text: obj.rf1Tlf);
  TextEditingController _ciudad = TextEditingController(text: obj.rf1Ciu);

  TextEditingController _nombre2 = TextEditingController(text: obj.rf2Nom);
  TextEditingController _parentesco2 = TextEditingController(text: obj.rf2Nex);
  TextEditingController _telefono2 = TextEditingController(text: obj.rf2Tlf);
  TextEditingController _ciudad2 = TextEditingController(text: obj.rf2Ciu);

  TextEditingController _nombre3 = TextEditingController(text: obj.rf3Nom);
  TextEditingController _parentesco3 = TextEditingController(text: obj.rf2Nex);
  TextEditingController _telefono3 = TextEditingController(text: obj.rf3Tlf);
  TextEditingController _ciudad3 = TextEditingController(text: obj.rf3Ciu);

  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text('Referencias Familiares'),
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
                              hint: 'Nombre',
                              enable: true,
                              icon: Icons.perm_identity_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _nombre,
                              regx: rgx.letras,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Parentesco',
                              enable: true,
                              icon: Icons.family_restroom_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _parentesco,
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
                              controller: _ciudad,
                              regx: rgx.letras,
                              length: 20,
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
                              controller: _telefono,
                              regx: rgx.numeros,
                              length: 10,
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
                              hint: 'Nombre',
                              enable: true,
                              icon: Icons.perm_identity_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _nombre2,
                              regx: rgx.letras,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Parentesco',
                              enable: true,
                              icon: Icons.family_restroom_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _parentesco2,
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
                              controller: _ciudad2,
                              regx: rgx.letras,
                              length: 20,
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
                              controller: _telefono2,
                              regx: rgx.numeros,
                              length: 10,
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
                              hint: 'Nombre',
                              enable: true,
                              icon: Icons.perm_identity_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _nombre3,
                              regx: rgx.letras,
                              length: 20,
                              onEditingComplete: () {},
                              onChanged: (value) {}),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: InputForm(
                              hint: 'Parentesco',
                              enable: true,
                              icon: Icons.family_restroom_outlined,
                              validator: (value) {
                                return null;
                              },
                              controller: _parentesco3,
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
                              controller: _ciudad3,
                              regx: rgx.letras,
                              length: 20,
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
                              controller: _telefono3,
                              regx: rgx.numeros,
                              length: 10,
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
                    obj.rf1Nom = _nombre.text;
                    obj.rf1Nex = _parentesco.text;
                    obj.rf1Tlf = _telefono.text;
                    obj.rf1Ciu = _ciudad.text;

                    obj.rf2Nom = _nombre2.text;
                    obj.rf2Nex = _parentesco2.text;
                    obj.rf2Tlf = _telefono2.text;
                    obj.rf2Ciu = _ciudad2.text;

                    obj.rf3Nom = _nombre3.text;
                    obj.rf3Nex = _parentesco3.text;
                    obj.rf3Tlf = _telefono3.text;
                    obj.rf3Ciu = _ciudad3.text;

                    provider.saveFamiliar(obj);
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
                    _nombre.clear();
                    _parentesco.clear();
                    _telefono.clear();
                    _ciudad.clear();

                    _nombre2.clear();
                    _parentesco2.clear();
                    _telefono2.clear();
                    _ciudad2.clear();

                    _nombre3.clear();
                    _parentesco3.clear();
                    _telefono3.clear();
                    _ciudad3.clear();

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
