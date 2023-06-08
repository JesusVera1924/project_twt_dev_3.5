import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/mg0031.dart';
import 'package:devolucion_modulo/models/motivo.dart';
import 'package:devolucion_modulo/provider/auth_provider.dart';
import 'package:devolucion_modulo/provider/credits_provider.dart';
import 'package:devolucion_modulo/ui/inputs/custom_inputs.dart';
import 'package:devolucion_modulo/ui/inputs/input_form.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';
import 'package:devolucion_modulo/util/validation.dart';
import 'package:provider/provider.dart';

Future<String> dialogApproval(BuildContext context, CreditsProvider provider,
    Mg0031 obj, List<Motivo> lista) async {
  String respuesta = "";
  String code = "01";
  String tipo = obj.clsRef == "1" ? "Crédito" : "Contado";
  String vendedor = "V018";
  String msg = "";

  final rgx = Validation();
  final formkey = new GlobalKey<FormState>();
  final _codigo = TextEditingController(text: obj.codRef);
  final _palzo = TextEditingController(text: "${obj.plzSdc}");
  final _cupo = TextEditingController(text: "${obj.cupSdc}");
  final listVendedor =
      Provider.of<CreditsProvider>(context, listen: false).listVendedor;

  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            //backgroundColor: Color(0xff092042),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text(
              'Datos de Aprobación ($tipo)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Container(
              width: 400,
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: InputForm(
                              hint: 'Codigo',
                              enable: true,
                              icon: Icons.code_off_outlined,
                              validator: (value) {
                                if (value.length == 0) {
                                  return "Campo Requerido*";
                                }
                                return null;
                              },
                              controller: _codigo,
                              regx: rgx.alfanumerico,
                              length: 4,
                              onEditingComplete: () {},
                              onChanged: (value) async {
                                if (value.length == 4) {
                                  final x = await provider.checkCodigo(value);
                                  x ? msg = "" : msg = "Codigo ya registrado";
                                  setState(() {});
                                }
                              }),
                        ),
                        if (obj.clsRef == "1") SizedBox(width: 5),
                        if (obj.clsRef == "1")
                          Expanded(
                            child: InputForm(
                                hint: 'Cupo',
                                enable: true,
                                icon: Icons.monetization_on_outlined,
                                validator: (value) {
                                  if (value.length == 0) {
                                    return "Campo Requerido*";
                                  }
                                  return null;
                                },
                                controller: _cupo,
                                regx: rgx.decimal,
                                length: 10,
                                onEditingComplete: () {},
                                onChanged: (value) {}),
                          ),
                        if (obj.clsRef == "1") SizedBox(width: 5),
                        if (obj.clsRef == "1")
                          Expanded(
                            child: InputForm(
                                hint: 'Plazo',
                                enable: true,
                                icon: Icons.timer,
                                validator: (value) {
                                  if (value.length == 0) {
                                    return "Campo Requerido*";
                                  }
                                  return null;
                                },
                                controller: _palzo,
                                regx: rgx.numeros,
                                length: 6,
                                onEditingComplete: () {},
                                onChanged: (value) {}),
                          ),
                      ],
                    ),
                    if (obj.clsRef == "1") SizedBox(height: 10),
                    if (obj.clsRef == "1")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: DropdownButtonFormField<String>(
                              value: code,
                              onChanged: (value) {
                                setState(() {
                                  code = value!;
                                });
                              },
                              items: lista.map((item) {
                                return DropdownMenuItem(
                                  value: item.codCmg,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        item.nomCmg,
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
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Vendedores",
                          textAlign: TextAlign.center,
                          style: CustomLabels.h6
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: vendedor,
                            menuMaxHeight: 300,
                            onChanged: (value) {
                              setState(() {
                                vendedor = value!;
                              });
                            },
                            items: listVendedor.map((item) {
                              return DropdownMenuItem(
                                value: item.codRef,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item.nomRef,
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
                    Text(
                      msg,
                      textAlign: TextAlign.center,
                      style: CustomLabels.h9,
                    )
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
                      return Colors.greenAccent;
                    return Colors.transparent;
                  })),
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      obj.codRef = _codigo.text;
                      obj.uacSdc =
                          Provider.of<AuthProvider>(context, listen: false)
                              .cliente!
                              .nomUsr;
                      obj.plzSdc = int.parse(_palzo.text);
                      obj.cupSdc = double.parse(_cupo.text);
                      obj.fdpSdc = code;
                      obj.clsSdc = obj.clsRef == "2" ? "04" : "01";
                      obj.codRtc = vendedor;
                      //usuario que creo la solicitud
                      obj.stsSdc = "A";

                      provider.saveApproval(obj);
                      provider.insertCorreo(obj);
                      provider.insertCliente(obj);

                      respuesta = "1";
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Aprobar', style: CustomLabels.h4)),
              TextButton(
                  style: ButtonStyle(backgroundColor:
                      MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered))
                      return Colors.greenAccent;
                    return Colors.transparent;
                  })),
                  onPressed: () {
                    _codigo.clear();
                    _palzo.clear();
                    _cupo.clear();
                    respuesta = "0";

                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar', style: CustomLabels.h4)),
            ],
          );
        });
      });
  return respuesta;
}
