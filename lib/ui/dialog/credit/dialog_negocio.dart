import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/mg0031.dart';
import 'package:devolucion_modulo/provider/credits_provider.dart';
import 'package:devolucion_modulo/ui/inputs/custom_inputs.dart';
import 'package:devolucion_modulo/ui/inputs/input_form.dart';
import 'package:devolucion_modulo/util/util_view.dart';
import 'package:devolucion_modulo/util/validation.dart';

Future dialogNegocio(
    BuildContext context, Mg0031 obj, CreditsProvider provider) async {
  String estadoCivil = obtenerEstado(obj.ecrPer);
  final inspectorValue = Validation();

  final _cNic = TextEditingController(text: obj.nicPer);
  final _cNom = TextEditingController(text: obj.nomPer);
  final _cCe1 = TextEditingController(text: obj.ce1Per);
  final _cCui = TextEditingController(text: obj.ciuPer);
  final _cDir = TextEditingController(text: obj.dirPer);
  final _cTlf = TextEditingController(text: obj.tlfPer);
  final _cTlt = TextEditingController(text: obj.tltPer);
  final _cMv1 = TextEditingController(text: obj.mv1Per);
  final _cMnt = TextEditingController(text: "${obj.mntSol}");
  final _cPlz = TextEditingController(text: "${obj.plzSol}");
  final _cIng = TextEditingController(text: "${obj.ingMes}");
  final _cGas = TextEditingController(text: "${obj.gasMes}");
  final _cNicC = TextEditingController(text: obj.nicCyg);
  final _cNomC = TextEditingController(text: obj.nomCyg);
  final formkey = new GlobalKey<FormState>();

  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text(
              'Datos del Negocio',
            ),
            content: Container(
              width: 1000,
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (obj.tdsRef == "1")
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Expanded(
                                child: InputForm(
                                    hint: 'Cedula Rep.legal',
                                    enable: true,
                                    icon: Icons.perm_identity_outlined,
                                    validator: (value) {
                                      if (value.length == 0)
                                        return "Obligatorio";
                                      if (value.length == 10)
                                        return inspectorValue
                                            .checkCedula(value);

                                      return null;
                                    },
                                    controller: _cNic,
                                    regx: inspectorValue.numeros,
                                    length: 10,
                                    onEditingComplete: () {},
                                    onChanged: (value) {})),
                            SizedBox(width: 5),
                            Expanded(
                              flex: 2,
                              child: InputForm(
                                  hint: 'Nombre Rep.legal',
                                  enable: true,
                                  icon: Icons.perm_identity_outlined,
                                  validator: (value) {
                                    if (value.length == 0) {
                                      return "Campo Requerido*";
                                    }
                                    return null;
                                  },
                                  controller: _cNom,
                                  regx: inspectorValue.letras,
                                  length: 80,
                                  onEditingComplete: () {},
                                  onChanged: (value) {}),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              flex: 2,
                              child: InputForm(
                                  hint: 'Correo',
                                  enable: true,
                                  icon: Icons.email_outlined,
                                  validator: (value) {
                                    if (!EmailValidator.validate(value ?? ''))
                                      return 'Email no válido';

                                    return null;
                                  },
                                  controller: _cCe1,
                                  regx: inspectorValue.correo,
                                  length: 40,
                                  onEditingComplete: () {},
                                  onChanged: (value) {}),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: InputForm(
                                  hint: 'Ciudad',
                                  enable: true,
                                  icon: Icons.directions_sharp,
                                  validator: (value) {
                                    if (value.length == 0) {
                                      return "Campo Requerido*";
                                    }
                                    return null;
                                  },
                                  controller: _cCui,
                                  regx: inspectorValue.letras,
                                  length: 15,
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
                            flex: 2,
                            child: InputForm(
                                hint: 'Direccion',
                                enable: true,
                                icon: Icons.directions,
                                validator: (value) {
                                  if (value.length == 0) {
                                    return "Campo Requerido*";
                                  }
                                  return null;
                                },
                                controller: _cDir,
                                regx: inspectorValue.alfanumerico,
                                length: 80,
                                onEditingComplete: () {},
                                onChanged: (value) {}),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: InputForm(
                                hint: 'Telefono domicilio',
                                enable: true,
                                icon: Icons.phone_rounded,
                                validator: (value) {
                                  if (value.length == 0) {
                                    return "Campo Requerido*";
                                  }
                                  return null;
                                },
                                controller: _cTlf,
                                regx: inspectorValue.numeros,
                                length: 10,
                                onEditingComplete: () {},
                                onChanged: (value) {}),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: InputForm(
                                hint: 'Telefono trabajo',
                                enable: true,
                                icon: Icons.phone_rounded,
                                validator: (value) {
                                  if (value.length == 0) {
                                    return "Campo Requerido*";
                                  }
                                  return null;
                                },
                                controller: _cTlt,
                                regx: inspectorValue.numeros,
                                length: 10,
                                onEditingComplete: () {},
                                onChanged: (value) {}),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: InputForm(
                                hint: 'Celular',
                                enable: true,
                                icon: Icons.phone_android_outlined,
                                validator: (value) {
                                  if (value.length == 0) {
                                    return "Campo Requerido*";
                                  }
                                  return null;
                                },
                                controller: _cMv1,
                                regx: inspectorValue.numeros,
                                length: 10,
                                onEditingComplete: () {},
                                onChanged: (value) {}),
                          ),
                        ],
                      ),
                    ),
                    if (obj.clsRef == "1")
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: InputForm(
                                  hint: 'Cupo Solicitado',
                                  enable: true,
                                  icon: Icons.confirmation_number,
                                  validator: (value) {
                                    if (value.length == 0) {
                                      return "Campo Requerido*";
                                    }
                                    return null;
                                  },
                                  controller: _cMnt,
                                  regx: inspectorValue.decimal,
                                  length: 6,
                                  onEditingComplete: () {},
                                  onChanged: (value) {}),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: InputForm(
                                  hint: 'Plazo Solicitado (Plazo en Dias)',
                                  enable: true,
                                  icon: Icons.access_time,
                                  validator: (value) {
                                    if (value.length == 0) {
                                      return "Campo Requerido*";
                                    }
                                    return null;
                                  },
                                  controller: _cPlz,
                                  regx: inspectorValue.numeros,
                                  length: 6,
                                  onEditingComplete: () {},
                                  onChanged: (value) {}),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: InputForm(
                                  hint: 'Monto de Ingresos',
                                  enable: true,
                                  icon: Icons.arrow_circle_up_outlined,
                                  validator: (value) {
                                    if (value.length == 0) {
                                      return "Campo Requerido*";
                                    }
                                    return null;
                                  },
                                  controller: _cIng,
                                  regx: inspectorValue.decimal,
                                  length: 6,
                                  onEditingComplete: () {},
                                  onChanged: (value) {}),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: InputForm(
                                  hint: 'Monto de Gastos',
                                  enable: true,
                                  icon: Icons.arrow_circle_down_rounded,
                                  validator: (value) {
                                    if (value.length == 0) {
                                      return "Campo Requerido*";
                                    }
                                    return null;
                                  },
                                  controller: _cGas,
                                  regx: inspectorValue.decimal,
                                  length: 6,
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
                          Container(
                            constraints:
                                BoxConstraints(maxWidth: 300, minWidth: 100),
                            child: DropdownButtonFormField<String>(
                              value: estadoCivil,
                              onChanged: (value) {
                                setState(() {
                                  estadoCivil = value!;
                                });
                              },
                              items: UtilView.radiusCivil.map((item) {
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
                          if (estadoCivil == 'Casado') SizedBox(width: 5),
                          if (estadoCivil == 'Casado')
                            Expanded(
                              child: InputForm(
                                  hint: 'Cedula del conyuge (opcional)',
                                  enable: true,
                                  icon: Icons.perm_identity_outlined,
                                  validator: (value) {
                                    if (value.length >= 1) {
                                      if (value.length == 10)
                                        return inspectorValue
                                            .checkCedula(value);
                                    }
                                    return null;
                                  },
                                  controller: _cNicC,
                                  regx: inspectorValue.numeros,
                                  length: 10,
                                  onEditingComplete: () {},
                                  onChanged: (value) {}),
                            ),
                          if (estadoCivil == 'Casado') SizedBox(width: 5),
                          if (estadoCivil == 'Casado')
                            Expanded(
                              child: InputForm(
                                  hint: 'Nombres del conyuge (opcional)',
                                  enable: true,
                                  icon: Icons.perm_identity_outlined,
                                  validator: (value) {},
                                  controller: _cNomC,
                                  regx: inspectorValue.letras,
                                  length: 40,
                                  onEditingComplete: () {},
                                  onChanged: (value) {}),
                            )
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
                    if (states.contains(MaterialState.hovered))
                      return Color(0x4024F181);
                    return Colors.transparent;
                  })),
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      obj.nicPer = _cNic.text;
                      obj.nomPer = _cNom.text;
                      obj.ce1Per = _cCe1.text;
                      obj.ciuPer = _cCui.text;
                      obj.dirPer = _cDir.text;
                      obj.tlfPer = _cTlf.text;
                      obj.tltPer = _cTlt.text;
                      obj.mv1Per = _cMv1.text;
                      obj.mntSol = double.parse(_cMnt.text);
                      obj.plzSol = int.parse(_cPlz.text);
                      obj.ingMes = double.parse(_cIng.text);
                      obj.gasMes = double.parse(_cGas.text);
                      obj.nicCyg = _cNicC.text;
                      obj.nomCyg = _cNomC.text;

                      obj.ecrPer = estadoCivil.substring(0, 1);
                      provider.saveNegocio(obj);
                      Navigator.of(context).pop();
                    }
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
                    _cNic.clear();
                    _cNom.clear();
                    _cCe1.clear();
                    _cCui.clear();
                    _cDir.clear();
                    _cTlf.clear();
                    _cTlt.clear();
                    _cMv1.clear();
                    _cMnt.clear();
                    _cPlz.clear();
                    _cIng.clear();
                    _cGas.clear();
                    _cNicC.clear();
                    _cNomC.clear();
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

String obtenerEstado(String estado) {
  String resp;

  switch (estado) {
    case "S":
      resp = "Soltero";
      break;
    case "C":
      resp = "Casado";
      break;
    case "U":
      resp = "Union libre";
      break;
    case "D":
      resp = "Divorciado";
      break;
    case "V":
      resp = "Viudo";
      break;
    default:
      resp = "Soltero";
      break;
  }

  return resp;
}
