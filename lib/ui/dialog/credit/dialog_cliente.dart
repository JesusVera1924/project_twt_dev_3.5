import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/mg0031.dart';
import 'package:devolucion_modulo/provider/credits_provider.dart';
import 'package:devolucion_modulo/ui/inputs/custom_inputs.dart';
import 'package:devolucion_modulo/ui/inputs/input_form.dart';
import 'package:devolucion_modulo/util/validation.dart';

Future dialogCliente(
    BuildContext context, Mg0031 obj, CreditsProvider provider) async {
  String city = obj.ciuRef;
  String province = obj.estRef;
  Validation inspectorValue = Validation();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController _razon = TextEditingController(text: obj.nomRef);
  TextEditingController _comercio = TextEditingController(text: obj.nmcRef);
  TextEditingController _direccion = TextEditingController(text: obj.dirRef);
  TextEditingController _tlfN = TextEditingController(text: obj.tlfRef);
  TextEditingController _celu = TextEditingController(text: obj.mv1Ref);
  TextEditingController _correo1 = TextEditingController(text: obj.ce1Ref);
  TextEditingController _correo2 = TextEditingController(text: obj.ce2Ref);

  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              'Datos del Cliente',
            ),
            content: SizedBox(
              width: 1000,
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Expanded(
                              child: InputForm(
                                  hint: 'Razón Social',
                                  enable: true,
                                  icon: Icons.local_offer_outlined,
                                  validator: (value) {
                                    if (value.length == 0) {
                                      return "Campo Requerido*";
                                    }
                                    return null;
                                  },
                                  controller: _razon,
                                  regx: inspectorValue.alfanumerico,
                                  length: 80,
                                  onEditingComplete: () {},
                                  onChanged: (value) {})),
                          const SizedBox(width: 5),
                          Expanded(
                            child: InputForm(
                                hint: 'Nombre Comercial',
                                enable: true,
                                icon: Icons.perm_identity_outlined,
                                validator: (value) {},
                                controller: _comercio,
                                regx: inspectorValue.letras,
                                length: 40,
                                onEditingComplete: () {},
                                onChanged: (value) {}),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: InputForm(
                                hint: 'Direccion comercial',
                                enable: true,
                                icon: Icons.directions,
                                validator: (value) {
                                  if (value.length == 0) {
                                    return "Campo Requerido*";
                                  }
                                  return null;
                                },
                                controller: _direccion,
                                regx: inspectorValue.alfanumerico,
                                length: 80,
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
                            child: DropdownButtonFormField<String>(
                              value: city,
                              onChanged: (value) {
                                setState(() {
                                  city = value!;
                                });
                              },
                              items: provider.listCiud.map((item) {
                                return DropdownMenuItem(
                                  value: item.codOcg,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        item.nomOcg,
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
                          const SizedBox(width: 5),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: province,
                              onChanged: (value) {
                                setState(() {
                                  province = value!;
                                  obj.estRef = province;
                                });
                              },
                              items: provider.listProv.map((item) {
                                return DropdownMenuItem(
                                  value: item.codOcg,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        item.nomOcg,
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
                          const SizedBox(width: 5),
                          Expanded(
                            child: InputForm(
                                hint: 'Telefono negocio (opcional)',
                                enable: true,
                                icon: Icons.phone_rounded,
                                validator: (value) {},
                                controller: _tlfN,
                                regx: inspectorValue.numeros,
                                length: 10,
                                onEditingComplete: () {},
                                onChanged: (value) {}),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: InputForm(
                                hint: 'Celular negocio',
                                enable: true,
                                icon: Icons.phone_rounded,
                                validator: (value) {
                                  if (value.length == 0) {
                                    return "Campo Requerido*";
                                  }
                                  return null;
                                },
                                controller: _celu,
                                regx: inspectorValue.numeros,
                                length: 10,
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
                                hint: 'Correo',
                                enable: true,
                                icon: Icons.email_outlined,
                                validator: (value) {
                                  if (!EmailValidator.validate(value ?? '')) {
                                    return 'Email no válido';
                                  }

                                  return null;
                                },
                                controller: _correo1,
                                regx: inspectorValue.correo,
                                length: 40,
                                onEditingComplete: () {},
                                onChanged: (value) {}),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: InputForm(
                                hint: 'Otro Correo (opcional)',
                                enable: true,
                                icon: Icons.email_outlined,
                                validator: (String value) {
                                  if (value.length >= 1) {
                                    if (!EmailValidator.validate(value)) {
                                      return 'Email no válido';
                                    }
                                  }
                                  return null;
                                },
                                controller: _correo2,
                                regx: inspectorValue.correo,
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
                    if (formkey.currentState!.validate()) {
                      obj.nomRef = _razon.text;
                      obj.nmcRef = _comercio.text;
                      obj.dirRef = _direccion.text;
                      obj.tlfRef = _tlfN.text;
                      obj.mv1Ref = _celu.text;
                      obj.ce1Ref = _correo1.text;
                      obj.ce2Ref = _correo2.text;
                      obj.estRef = province;
                      obj.ciuRef = city;

                      provider.saveObj(obj);
                      Navigator.of(context).pop();
                    }
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
                      return const Color(0x4024F181);
                    }
                    return Colors.transparent;
                  })),
                  onPressed: () {
                    _razon.clear();
                    _comercio.clear();
                    _direccion.clear();
                    _tlfN.clear();
                    _celu.clear();
                    _correo1.clear();
                    _correo2.clear();
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
