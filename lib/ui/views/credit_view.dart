import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:devolucion_modulo/api/credit_api.dart';
import 'package:devolucion_modulo/models/mg0030.dart';
import 'package:devolucion_modulo/models/mg0031.dart';
import 'package:devolucion_modulo/provider/credit_provider.dart';
import 'package:devolucion_modulo/router/router.dart';
import 'package:devolucion_modulo/services/navigation_services.dart';
import 'package:devolucion_modulo/services/notifications_service.dart';
import 'package:devolucion_modulo/ui/buttons/custom_form_button.dart';
import 'package:devolucion_modulo/ui/buttons/custom_icon_btn.dart';
import 'package:devolucion_modulo/ui/cardsReferens/card_banco.dart';
import 'package:devolucion_modulo/ui/cardsReferens/card_ref_comerciales.dart';
import 'package:devolucion_modulo/ui/cardsReferens/card_ref_familiares.dart';
import 'package:devolucion_modulo/ui/cardsReferens/card_ref_personales.dart';
import 'package:devolucion_modulo/ui/cardsReferens/card_ref_propiedades.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/dialog_terminos.dart';
import 'package:devolucion_modulo/ui/inputs/input_form.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels_form.dart';
import 'package:devolucion_modulo/util/desglose_lista.dart';
import 'package:devolucion_modulo/util/util_view.dart';
import 'package:devolucion_modulo/util/validation.dart';
import 'package:devolucion_modulo/ui/inputs/custom_inputs.dart';
import 'package:provider/provider.dart';

import 'package:group_radio_button/group_radio_button.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:file_picker/file_picker.dart';

class CreditView extends StatefulWidget {
  final String uid;

  const CreditView({Key? key, required this.uid}) : super(key: key);

  @override
  _CreditViewState createState() => _CreditViewState();
}

class _CreditViewState extends State<CreditView> {
  final inspectorValue = Validation();
  final creditApi = CreditApi();
  final extra = DesgloseLista();

  List<CardBanco> cardBan = [];
  List<CardRefFamiliares> cardFam = [];
  List<CardRefPersonales> cardPersonal = [];
  List<CardRefPropiedades> cardPropiedad = [];
  List<CardRefComerciles> cardComercial = [];
  List<Mg0030> listCiud = [];
  List<Mg0030> listProv = [];

  String lblEnvio = "Enviar Solicitud";
  bool sendMessage = false;
  bool isHover = false;
  late FocusNode myFocusNode;
  String version = "";

  Future _openFileExplorer(CreditProvider provider, String sufijo) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      if (file.extension == "pdf") {
        provider.listDocument.forEach((element) {
          if (element.sufijo == sufijo) {
            element.name = file.name;
            element.arrayBs64 = base64.encode(file.bytes!.toList());
            element.estado = true;
            element.requerido = "";
          }
        });
      } else {
        NotificationsService.showSnackbar(
            'Advertencia/ solo documento de tipo (.pdf)');
      }

      setState(() {});
    }
  }

  void llenarList() async {
    listCiud = await creditApi.querylist("03");
    listProv = await creditApi.querylist("02");
    setState(() {});
  }

  @override
  void initState() {
    llenarList();
    myFocusNode = FocusNode();

    buildDataForm(widget.uid);
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final creditProvider = Provider.of<CreditProvider>(context);
    final sizePage = MediaQuery.of(context).size;

    return Container(
      color: Colors.black26,
      child: (creditProvider.estaForm == "0")
          ? Container(
              alignment: Alignment.center,
              height: 300,
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            )
          : ListView(
              physics: ClampingScrollPhysics(),
              children: [
                Form(
                  key: creditProvider.formkey,
                  child: ResponsiveGridRow(children: [
                    ResponsiveGridCol(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 20, left: 20, right: 10, bottom: 5),
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                CustomLabelsForm(text: 'Solicitud de Credito'),
                                Spacer(),
                                CustomIconBtn(
                                    onPressed: () {
                                      NavigationService.replaceTo(
                                          Flurorouter.menuRoute);
                                    },
                                    color: Colors.blueGrey,
                                    msj: "Regresar",
                                    icon: Icons.exit_to_app_outlined),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    ResponsiveGridCol(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 5, left: 20, right: 10, bottom: 10),
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomLabelsForm(
                                  text: 'Datos del cliente',
                                  size: 22,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
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
                                            controller: creditProvider.nomRef,
                                            regx: inspectorValue.alfanumerico,
                                            length: 80,
                                            onEditingComplete: () {},
                                            onChanged: (value) {}),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        flex: 2,
                                        child: InputForm(
                                            hint: 'Nombre Comercial',
                                            enable: true,
                                            icon: Icons.perm_identity_outlined,
                                            validator: (value) {},
                                            controller: creditProvider.nmcRef,
                                            regx: inspectorValue.letras,
                                            length: 40,
                                            onEditingComplete: () {},
                                            onChanged: (value) {}),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        flex: 2,
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
                                            controller: creditProvider.dirRef,
                                            regx: inspectorValue.alfanumerico,
                                            length: 80,
                                            onEditingComplete: () {},
                                            onChanged: (value) {}),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: DropdownButtonFormField<String>(
                                          value: creditProvider.selectCity,
                                          onChanged: (value) {
                                            setState(() {
                                              creditProvider.selectCity =
                                                  value!;
                                            });
                                          },
                                          items: listCiud.map((item) {
                                            return DropdownMenuItem(
                                              value: item.codOcg,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    item.nomOcg,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )),
                                            );
                                          }).toList(),
                                          decoration:
                                              CustomInputs.formInputDecoration(
                                            hint: '',
                                            icon: Icons.location_on_outlined,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: DropdownButtonFormField<String>(
                                          value: creditProvider.selectProv,
                                          onChanged: (value) {
                                            setState(() {
                                              creditProvider.selectProv =
                                                  value!;
                                            });
                                          },
                                          items: listProv.map((item) {
                                            return DropdownMenuItem(
                                              value: item.codOcg,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    item.nomOcg,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )),
                                            );
                                          }).toList(),
                                          decoration:
                                              CustomInputs.formInputDecoration(
                                            hint: '',
                                            icon: Icons.location_on_outlined,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: InputForm(
                                            hint: 'Telefono negocio (opcional)',
                                            enable: true,
                                            icon: Icons.phone_rounded,
                                            validator: (value) {},
                                            controller: creditProvider.tlfRef,
                                            regx: inspectorValue.numeros,
                                            length: 10,
                                            onEditingComplete: () {},
                                            onChanged: (value) {}),
                                      ),
                                      SizedBox(width: 10),
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
                                            controller: creditProvider.mv1Ref,
                                            regx: inspectorValue.numeros,
                                            length: 10,
                                            onEditingComplete: () {},
                                            onChanged: (value) {}),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InputForm(
                                            hint: 'Correo',
                                            enable: true,
                                            icon: Icons.email_outlined,
                                            validator: (value) {
                                              if (!EmailValidator.validate(
                                                  value ?? ''))
                                                return 'Email no válido';

                                              return null;
                                            },
                                            controller: creditProvider.ce1Ref,
                                            regx: inspectorValue.correo,
                                            length: 40,
                                            onEditingComplete: () {},
                                            onChanged: (value) {}),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: InputForm(
                                            hint: 'Otro Correo (opcional)',
                                            enable: true,
                                            icon: Icons.email_outlined,
                                            validator: (String value) {
                                              if (value.length >= 1) {
                                                if (!EmailValidator.validate(
                                                    value))
                                                  return 'Email no válido';
                                              }
                                              return null;
                                            },
                                            controller: creditProvider.ce2Ref,
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
                      ),
                    ),
                    ResponsiveGridCol(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 5, left: 20, right: 10, bottom: 10),
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomLabelsForm(
                                  text:
                                      'Información del representante o propietario',
                                  size: 22,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: 10, left: 10, bottom: 10),
                                  child: Row(
                                    children: [
                                      CustomLabelsForm(
                                        text: 'Tipo de Negocio: ',
                                        size: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      RadioGroup<String>.builder(
                                        horizontalAlignment:
                                            MainAxisAlignment.center,
                                        direction: Axis.horizontal,
                                        activeColor: Colors.redAccent,
                                        // spacebetween: 5,
                                        groupValue: creditProvider
                                            .selectNegocio, // valor inicial
                                        onChanged: (value) => setState(() {
                                          creditProvider.selectNegocio =
                                              value.toString();
                                        }),
                                        items: UtilView.radiusNegocio,
                                        itemBuilder: (item) =>
                                            RadioButtonBuilder(
                                          item,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (creditProvider.isOpen)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10, bottom: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: InputForm(
                                              hint:
                                                  'Nombre del Representante legal',
                                              enable: true,
                                              icon:
                                                  Icons.perm_identity_outlined,
                                              validator: (value) {
                                                if (value.length == 0) {
                                                  return "Campo Requerido*";
                                                }
                                                return null;
                                              },
                                              controller: creditProvider.nomPer,
                                              regx: inspectorValue.letras,
                                              length: 80,
                                              onEditingComplete: () {},
                                              onChanged: (value) {}),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          flex: 2,
                                          child: InputForm(
                                              hint: 'Cedula Rep. legal',
                                              enable: true,
                                              icon:
                                                  Icons.perm_identity_outlined,
                                              validator: (value) {
                                                if (value.length == 0)
                                                  return "Obligatorio";
                                                if (value.length == 10)
                                                  return inspectorValue
                                                      .checkCedula(value);

                                                return null;
                                              },
                                              controller: creditProvider.nicPer,
                                              regx: inspectorValue.numeros,
                                              length: 10,
                                              onEditingComplete: () {},
                                              onChanged: (value) {}),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          flex: 2,
                                          child: InputForm(
                                              hint: 'Correo',
                                              enable: true,
                                              icon: Icons.email_outlined,
                                              validator: (value) {
                                                if (!EmailValidator.validate(
                                                    value ?? ''))
                                                  return 'Email no válido';

                                                return null;
                                              },
                                              controller: creditProvider.ce1Per,
                                              regx: inspectorValue.correo,
                                              length: 40,
                                              onEditingComplete: () {},
                                              onChanged: (value) {}),
                                        ),
                                        SizedBox(width: 10),
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
                                              controller: creditProvider.ciuPer,
                                              regx: inspectorValue.letras,
                                              length: 15,
                                              onEditingComplete: () {},
                                              onChanged: (value) {}),
                                        ),
                                      ],
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10, bottom: 10),
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
                                            controller: creditProvider.dirPer,
                                            regx: inspectorValue.alfanumerico,
                                            length: 80,
                                            onEditingComplete: () {},
                                            onChanged: (value) {}),
                                      ),
                                      SizedBox(width: 10),
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
                                            controller: creditProvider.tlfPer,
                                            regx: inspectorValue.numeros,
                                            length: 10,
                                            onEditingComplete: () {},
                                            onChanged: (value) {}),
                                      ),
                                      SizedBox(width: 10),
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
                                            controller: creditProvider.tltPer,
                                            regx: inspectorValue.numeros,
                                            length: 10,
                                            onEditingComplete: () {},
                                            onChanged: (value) {}),
                                      ),
                                      SizedBox(width: 10),
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
                                            controller: creditProvider.mv1Per,
                                            regx: inspectorValue.numeros,
                                            length: 10,
                                            onEditingComplete: () {},
                                            onChanged: (value) {}),
                                      ),
                                    ],
                                  ),
                                ),
                                if (creditProvider.selectSolicitud == 'Crédito')
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10, bottom: 10),
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
                                              controller: creditProvider.mntSol,
                                              regx: inspectorValue.decimal,
                                              length: 6,
                                              onEditingComplete: () {},
                                              onChanged: (value) {}),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: InputForm(
                                              hint:
                                                  'Plazo Solicitado (Plazo en Dias)',
                                              enable: true,
                                              icon: Icons.access_time,
                                              validator: (value) {
                                                if (value.length == 0) {
                                                  return "Campo Requerido*";
                                                }
                                                return null;
                                              },
                                              controller: creditProvider.plzSol,
                                              regx: inspectorValue.numeros,
                                              length: 6,
                                              onEditingComplete: () {},
                                              onChanged: (value) {}),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: InputForm(
                                              hint: 'Monto de Ingresos',
                                              enable: true,
                                              icon: Icons
                                                  .arrow_circle_up_outlined,
                                              validator: (value) {
                                                if (value.length == 0) {
                                                  return "Campo Requerido*";
                                                }
                                                return null;
                                              },
                                              controller: creditProvider.ingMes,
                                              regx: inspectorValue.decimal,
                                              length: 6,
                                              onEditingComplete: () {},
                                              onChanged: (value) {}),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: InputForm(
                                              hint: 'Monto de Gastos',
                                              enable: true,
                                              icon: Icons
                                                  .arrow_circle_down_rounded,
                                              validator: (value) {
                                                if (value.length == 0) {
                                                  return "Campo Requerido*";
                                                }
                                                return null;
                                              },
                                              controller: creditProvider.gasMes,
                                              regx: inspectorValue.decimal,
                                              length: 6,
                                              onEditingComplete: () {},
                                              onChanged: (value) {}),
                                        ),
                                      ],
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                            maxWidth: 300, minWidth: 100),
                                        child: DropdownButtonFormField<String>(
                                          value: creditProvider.selectCivil,
                                          onChanged: (value) {
                                            setState(() {
                                              creditProvider.selectCivil =
                                                  value!;
                                            });

                                            if (value == "Casado")
                                              myFocusNode.requestFocus();
                                          },
                                          items:
                                              UtilView.radiusCivil.map((item) {
                                            return DropdownMenuItem(
                                              value: item,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    item,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )),
                                            );
                                          }).toList(),
                                          decoration:
                                              CustomInputs.formInputDecoration(
                                            hint: '',
                                            icon: Icons.perm_identity_outlined,
                                          ),
                                        ),
                                      ),
                                      if (creditProvider.selectCivil ==
                                          'Casado')
                                        SizedBox(width: 10),
                                      if (creditProvider.selectCivil ==
                                          'Casado')
                                        Expanded(
                                          child: InputForm(
                                              hint:
                                                  'Cedula del conyuge (opcional)',
                                              enable: true,
                                              icon:
                                                  Icons.perm_identity_outlined,
                                              node: myFocusNode,
                                              validator: (value) {
                                                if (value.length >= 1) {
                                                  if (value.length == 10)
                                                    return inspectorValue
                                                        .checkCedula(value);
                                                }
                                                return null;
                                              },
                                              controller: creditProvider.nicCyg,
                                              regx: inspectorValue.numeros,
                                              length: 10,
                                              onEditingComplete: () {},
                                              onChanged: (value) {}),
                                        ),
                                      if (creditProvider.selectCivil ==
                                          'Casado')
                                        SizedBox(width: 10),
                                      if (creditProvider.selectCivil ==
                                          'Casado')
                                        Expanded(
                                          child: InputForm(
                                              hint:
                                                  'Nombres del conyuge (opcional)',
                                              enable: true,
                                              icon:
                                                  Icons.perm_identity_outlined,
                                              validator: (value) {},
                                              controller: creditProvider.nomCyg,
                                              regx: inspectorValue.letras,
                                              length: 40,
                                              onEditingComplete: () {},
                                              onChanged: (value) {}),
                                        ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    children: [
                                      CustomLabelsForm(
                                        text: 'Local Comercial: ',
                                        fontWeight: FontWeight.w400,
                                        size: 18,
                                      ),
                                      RadioGroup<String>.builder(
                                        horizontalAlignment:
                                            MainAxisAlignment.center,
                                        direction: Axis.horizontal,
                                        activeColor: Colors.redAccent,
                                        //spacebetween: 5,
                                        groupValue: creditProvider
                                            .selectLocal, // valor inicial
                                        onChanged: (value) => setState(() {
                                          creditProvider.selectLocal =
                                              value.toString();
                                        }),
                                        items: UtilView.radiusLocal,
                                        itemBuilder: (item) =>
                                            RadioButtonBuilder(
                                          item,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (creditProvider.selectSolicitud == 'Crédito')
                      ResponsiveGridCol(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 5, left: 20, right: 10, bottom: 10),
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomLabelsForm(
                                    text: 'Referencias Bancarias ',
                                    size: 22,
                                  ),
                                  LayoutBuilder(
                                      builder: (context, constraints) =>
                                          SizedBox(
                                            width: constraints.maxWidth,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              itemCount: cardBan.length,
                                              itemBuilder: (context, index) =>
                                                  cardBan[index],
                                            ),
                                          )),
                                  CustomFormButton(
                                      onPressed: () => addData(),
                                      text: 'Agregar +'),
                                  Divider(thickness: 1),
                                  CustomLabelsForm(
                                    text: 'Referencias Familiares ',
                                    size: 22,
                                  ),
                                  LayoutBuilder(
                                      builder: (context, constraints) =>
                                          SizedBox(
                                            width: constraints.maxWidth,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              itemCount: cardFam.length,
                                              itemBuilder: (context, index) =>
                                                  cardFam[index],
                                            ),
                                          )),
                                  CustomFormButton(
                                      onPressed: () => addData1(),
                                      text: 'Agregar +'),
                                  Divider(thickness: 1),
                                  CustomLabelsForm(
                                    text: 'Referencias Personales ',
                                    size: 22,
                                  ),
                                  LayoutBuilder(
                                      builder: (context, constraints) =>
                                          SizedBox(
                                            width: constraints.maxWidth,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              itemCount: cardPersonal.length,
                                              itemBuilder: (context, index) =>
                                                  cardPersonal[index],
                                            ),
                                          )),
                                  CustomFormButton(
                                      onPressed: () => addData2(),
                                      text: 'Agregar +'),
                                  Divider(thickness: 1),
                                  CustomLabelsForm(
                                    text: 'Referencia Patrimonio ',
                                    size: 22,
                                  ),
                                  LayoutBuilder(
                                      builder: (context, constraints) =>
                                          SizedBox(
                                            width: constraints.maxWidth,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              itemCount: cardPropiedad.length,
                                              itemBuilder: (context, index) =>
                                                  cardPropiedad[index],
                                            ),
                                          )),
                                  CustomFormButton(
                                      onPressed: () => addData3(),
                                      text: 'Agregar +'),
                                  Divider(thickness: 1),
                                  CustomLabelsForm(
                                    text: 'Referencias Comerciales ',
                                    size: 22,
                                  ),
                                  LayoutBuilder(
                                      builder: (context, constraints) =>
                                          SizedBox(
                                            width: constraints.maxWidth,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              itemCount: cardComercial.length,
                                              itemBuilder: (context, index) =>
                                                  cardComercial[index],
                                            ),
                                          )),
                                  CustomFormButton(
                                      onPressed: () => addData4(),
                                      text: 'Agregar +'),
                                  Divider(thickness: 1),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ResponsiveGridCol(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 5, left: 20, right: 10, bottom: 10),
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: CustomLabelsForm(
                                    text: 'Documentación',
                                    size: 22,
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            for (final _fieldValue
                                                in creditProvider
                                                    .listDocument) ...[
                                              if (_fieldValue.hide)
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          sizePage.width * 0.2,
                                                      child: CustomLabelsForm(
                                                        text:
                                                            _fieldValue.descp!,
                                                        size: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    CustomFormButton(
                                                      onPressed: () =>
                                                          _openFileExplorer(
                                                              creditProvider,
                                                              _fieldValue
                                                                  .sufijo),
                                                      text: 'Subir Archivo',
                                                      color: _fieldValue.estado
                                                          ? Colors.green
                                                          : Colors.redAccent,
                                                    ),
                                                    if (_fieldValue.requerido !=
                                                        "")
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8),
                                                        child: Text(
                                                            _fieldValue
                                                                .requerido,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontSize: 12)),
                                                      ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8),
                                                      child: Text(
                                                        _fieldValue.getName,
                                                        style: CustomLabels.h7,
                                                      ),
                                                    )
                                                  ],
                                                )
                                            ]
                                          ],
                                        ),
                                        if (sendMessage &&
                                            sizePage.width > 1250)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text(
                                                  'Si los cambios efectuados requieren nueva documentación por favor ',
                                                  style: CustomLabels.h8,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  'adjuntelos caso contrario su solicitud sera rechazada',
                                                  style: CustomLabels.h8,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          )
                                      ],
                                    )),
                                Divider(
                                  thickness: 1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomFormButton(
                                        onPressed: () async {
                                          if (buildArrayDocument(
                                              creditProvider)) {
                                            if (creditProvider.validateForm()) {
                                              final resp = await dialogTerminos(
                                                  context, 'Informacion');
                                              if (resp) {
                                                Mg0031 objSend = Mg0031(
                                                  codEmp: "01",
                                                  clsNic: creditProvider
                                                      .selectDocCodigo,
                                                  secNic: creditProvider
                                                      .secNic.text
                                                      .trim(),
                                                  numSdc: creditProvider
                                                              .numSdc.text !=
                                                          ""
                                                      ? creditProvider
                                                          .numSdc.text
                                                      : inspectorValue
                                                          .lastvalueNumber(
                                                              await creditApi
                                                                  .solicitudMax(),
                                                              9),
                                                  fecSdc: "null",
                                                  fecAdm: "null",
                                                  plzSol: creditProvider
                                                              .plzSol.text !=
                                                          ""
                                                      ? int.parse(creditProvider
                                                          .plzSol.text
                                                          .trim())
                                                      : 0,
                                                  mntSol: creditProvider
                                                              .mntSol.text !=
                                                          ""
                                                      ? double.parse(
                                                          creditProvider
                                                              .mntSol.text
                                                              .trim())
                                                      : 0.0,
                                                  codRtc: "",
                                                  nomRef: creditProvider
                                                      .nomRef.text
                                                      .trim(),
                                                  nmcRef: creditProvider
                                                      .nmcRef.text
                                                      .trim(),
                                                  dirRef: creditProvider
                                                      .dirRef.text
                                                      .trim(),
                                                  estRef:
                                                      creditProvider.selectProv,
                                                  ciuRef:
                                                      creditProvider.selectCity,
                                                  tlfRef: creditProvider
                                                      .tlfRef.text
                                                      .trim(),
                                                  ce1Ref: creditProvider
                                                      .ce1Ref.text
                                                      .toLowerCase(),
                                                  ce2Ref: creditProvider
                                                      .ce2Ref.text
                                                      .toLowerCase(),
                                                  mv1Ref: creditProvider
                                                      .mv1Ref.text
                                                      .toLowerCase(),
                                                  nomPer: creditProvider
                                                      .nomPer.text
                                                      .trim(),
                                                  nicPer: creditProvider
                                                      .nicPer.text
                                                      .trim(),
                                                  dirPer: creditProvider
                                                      .dirPer.text
                                                      .trim(),
                                                  ciuPer: creditProvider
                                                      .ciuPer.text
                                                      .trim(),
                                                  tlfPer: creditProvider
                                                      .tlfPer.text
                                                      .trim(),
                                                  tltPer: creditProvider
                                                      .tltPer.text
                                                      .trim(),
                                                  ce1Per: creditProvider
                                                      .ce1Per.text
                                                      .trim(),
                                                  mv1Per: creditProvider
                                                      .mv1Per.text,
                                                  ecrPer: creditProvider
                                                      .selectCivil
                                                      .substring(0, 1),
                                                  nomCyg: creditProvider
                                                      .nomCyg.text
                                                      .trim(),
                                                  nicCyg: creditProvider
                                                              .nicCyg.text
                                                              .trim() !=
                                                          ""
                                                      ? creditProvider
                                                          .nicCyg.text
                                                          .trim()
                                                      : "",
                                                  ingMes: creditProvider
                                                              .ingMes.text !=
                                                          ""
                                                      ? double.parse(
                                                          creditProvider
                                                              .ingMes.text
                                                              .trim())
                                                      : 0.0,
                                                  gasMes: creditProvider
                                                              .gasMes.text !=
                                                          ""
                                                      ? double.parse(
                                                          creditProvider
                                                              .gasMes.text
                                                              .trim())
                                                      : 0,
                                                  oiaMes: creditProvider
                                                      .oiaMes.text
                                                      .trim(),
                                                  tipRef: creditProvider
                                                      .selectNegocio
                                                      .substring(0, 1),
                                                  clsRef: creditProvider
                                                              .selectSolicitud ==
                                                          "Contado"
                                                      ? "2"
                                                      : "1",
                                                  locRef: creditProvider
                                                      .selectLocal
                                                      .substring(0, 1),
                                                  tdsRef: creditProvider
                                                              .selectPersona ==
                                                          "Persona Natural"
                                                      ? "0"
                                                      : "1",
                                                  dpnCcp: creditProvider
                                                          .listDocument[0]
                                                          .estado
                                                      ? "1"
                                                      : "0",
                                                  dpnCcc: "0",
                                                  dpnCrp: creditProvider
                                                          .listDocument[1]
                                                          .estado
                                                      ? "1"
                                                      : "0",
                                                  dpnCpf: creditProvider
                                                          .listDocument[6]
                                                          .estado
                                                      ? "1"
                                                      : "0",
                                                  dpnCsb: creditProvider
                                                          .listDocument[2]
                                                          .estado
                                                      ? "1"
                                                      : "0",
                                                  dpjCre: creditProvider
                                                          .listDocument[3]
                                                          .estado
                                                      ? "1"
                                                      : "0",
                                                  dpjCne: creditProvider
                                                          .listDocument[4]
                                                          .estado
                                                      ? "1"
                                                      : "0",
                                                  dpjCge: creditProvider
                                                          .listDocument[5]
                                                          .estado
                                                      ? "1"
                                                      : "0",
                                                  ntsSdc:
                                                      creditProvider.numVersion,
                                                  stsSdc: "P",
                                                );

                                                extra.desglozarLista(
                                                    cardBan, objSend);

                                                extra.desglozarLista1(
                                                    cardPropiedad, objSend);
                                                extra.desglozarLista2(
                                                    cardPersonal, objSend);
                                                extra.desglozarLista3(
                                                    cardComercial, objSend);
                                                extra.desglozarLista4(
                                                    cardFam, objSend);

                                                creditApi
                                                    .postFormCredit(objSend);

                                                creditProvider.listDocument
                                                    .forEach((e) {
                                                  if (e.arrayBs64 != "")
                                                    creditApi.uploadDocument(
                                                        e.arrayBs64,
                                                        e.sufijo +
                                                            "-" +
                                                            objSend.numSdc +
                                                            "-" +
                                                            objSend.stsSdc);
                                                });

                                                creditProvider.limpiarForm();
                                                cardBan = [];
                                                cardFam = [];
                                                cardPersonal = [];
                                                cardPropiedad = [];
                                                cardComercial = [];

                                                if (sendMessage) {
                                                  NotificationsService.showSnackbar(
                                                      'Solicitud de crédito actualizada');
                                                  //creditApi.sendEmail(objSend);
                                                } else {
                                                  creditApi.sendEmail(objSend);
                                                }
                                              }
                                            } else {
                                              NotificationsService.showSnackbar(
                                                  'Advertencia/por favor llene todos los campos requeridos');
                                            }
                                          } else {
                                            NotificationsService.showSnackbar(
                                                'Advertencia/cargar los documentos requeridos');
                                          }
                                        },
                                        text: lblEnvio,
                                        color: Colors.redAccent,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
    );
  }

  void addData() {
    if (cardBan.length >= 3) {
      return;
    }
    if (cardBan.length >= 1) {
      if (cardBan.elementAt(cardBan.length - 1).cta.text == "") {
        return;
      }
    }
    cardBan.add(new CardBanco());
    setState(() {});
  }

  void addData1() {
    if (cardFam.length >= 3) {
      return;
    }
    if (cardFam.length >= 1) {
      if (cardFam.elementAt(cardFam.length - 1).nombre.text == "") {
        return;
      }
    }
    cardFam.add(new CardRefFamiliares());
    setState(() {});
  }

  void addData2() {
    if (cardPersonal.length >= 3) {
      return;
    }
    if (cardPersonal.length >= 1) {
      if (cardPersonal.elementAt(cardPersonal.length - 1).nombre.text == "") {
        return;
      }
    }
    cardPersonal.add(new CardRefPersonales());
    setState(() {});
  }

  void addData3() {
    if (cardPropiedad.length >= 3) {
      return;
    }
    if (cardPropiedad.length >= 1) {
      if (cardPropiedad.elementAt(cardFam.length - 1).nombre.text == "") {
        return;
      }
    }
    cardPropiedad.add(new CardRefPropiedades());
    setState(() {});
  }

  void addData4() {
    if (cardComercial.length >= 3) {
      return;
    } else if (cardComercial.length >= 1) {
      if (cardComercial.elementAt(cardComercial.length - 1).empresa.text ==
          "") {
        return;
      }
    }
    cardComercial.add(new CardRefComerciles());
    setState(() {});
  }

  void buildValidetDocument(CreditProvider provider, opt) {
    if (opt == "1") {
      provider.setIsOpen(false);
      provider.listDocument.forEach((element) {
        if (element.sufijo == "CED" ||
            element.sufijo == "CSB" ||
            element.sufijo == "RCP") {
          element.hide = true;
          element.requerido = "Requerido*";
        } else {
          element.hide = false;
          element.requerido = "";
        }
        element.arrayBs64 = "";
        element.name = "";
        element.estado = false;
      });
    } else if (opt == "0") {
      provider.setIsOpen(false);
      provider.listDocument.forEach((element) {
        if (element.sufijo == "CED" ||
            element.sufijo == "CSB" ||
            element.sufijo == "RCP") {
          element.hide = true;
          element.requerido = "Requerido*";
        } else {
          element.hide = false;
          element.requerido = "";
        }
        element.arrayBs64 = "";
        element.name = "";
        element.estado = false;
      });
    } else if (opt == "4") {
      provider.setIsOpen(false);
      provider.listDocument.forEach((element) {
        if (element.sufijo == "CED" || element.sufijo == "CSB") {
          element.hide = true;
          element.requerido = "Requerido*";
        } else {
          element.hide = false;
          element.requerido = "";
        }
        element.arrayBs64 = "";
        element.name = "";
        element.estado = false;
      });
    } else {
      provider.setIsOpen(true);
      provider.listDocument.forEach((element) {
        if (element.sufijo == "CED" || element.sufijo == "RCP") {
          element.hide = false;
          element.requerido = "";
        } else {
          element.hide = true;
          element.requerido = "Requerido*";
          if (element.sufijo == "CPF") element.requerido = "No Requerido*";
        }
        element.arrayBs64 = "";
        element.name = "";
        element.estado = false;
      });
    }
  }

  void buildDataForm(value) async {
    final creditProvider = Provider.of<CreditProvider>(context, listen: false);
    final data = await creditApi.queryId(value);

    if (data.secNic != "") {
      creditProvider.numSdc.text = data.numSdc.toString();
      creditProvider.plzSol.text = data.plzSol.toString();
      creditProvider.mntSol.text = data.mntSol.toString();
      creditProvider.nomRef.text = data.nomRef.toUpperCase();

      creditProvider.nmcRef.text = data.nmcRef.toUpperCase();

      creditProvider.dirRef.text = data.dirRef.toUpperCase();
      creditProvider.selectProv = data.estRef.toUpperCase();
      creditProvider.selectCity = data.ciuRef.toUpperCase();
      creditProvider.tlfRef.text = data.tlfRef;
      creditProvider.ce1Ref.text = data.ce1Ref.toLowerCase();
      creditProvider.ce2Ref.text = data.ce2Ref.toLowerCase();
      creditProvider.mv1Ref.text = data.mv1Ref;
      creditProvider.nomPer.text = data.nomPer.toUpperCase();

      creditProvider.nicPer.text = data.nicPer.toUpperCase();
      creditProvider.dirPer.text = data.dirPer.toUpperCase();
      creditProvider.ciuPer.text = data.ciuPer.toUpperCase();
      creditProvider.tlfPer.text = data.tlfPer;
      creditProvider.tltPer.text = data.tltPer;
      creditProvider.ce1Per.text = data.ce1Per.toLowerCase();
      creditProvider.mv1Per.text = data.mv1Per.toLowerCase();
      creditProvider.ecrPer.text = data.ecrPer;

      creditProvider.nomCyg.text = data.nomCyg.toUpperCase();
      creditProvider.nicCyg.text = data.nicCyg.toUpperCase();
      creditProvider.ingMes.text = data.ingMes.toString();
      creditProvider.gasMes.text = data.gasMes.toString();
      creditProvider.oiaMes.text = data.oiaMes;
      //creditProvider.selectLocal = data.tipRef;

      /*     data.clsRef == "1"
          ? creditProvider.selectSolicitud = "Crédito"
          : creditProvider.selectSolicitud = "Contado"; */

      creditProvider.selectSolicitud = "Crédito";

      data.locRef == "P"
          ? creditProvider.selectLocal = "Propio"
          : creditProvider.selectLocal = "Alquilado";
      data.tdsRef == "0"
          ? creditProvider.selectPersona = "Persona Natural"
          : creditProvider.selectPersona = "Persona Juridica";

      creditProvider.numVersion = inspectorValue.upperVersion(data.ntsSdc);
      creditProvider.selectCivil = inspectorValue.getEstadoCivil(data.ecrPer);

      cardBan = extra.llenarLista(data);
      cardPropiedad = extra.llenarLista1(data);
      cardPersonal = extra.llenarLista2(data);
      cardComercial = extra.llenarLista3(data);
      cardFam = extra.llenarLista4(data);
      lblEnvio = "Enviar Solicitud de Credito";
      sendMessage = true;
      creditProvider.estaForm = "1";
    } else {
      creditProvider.estaForm = "0";
    }

    setState(() {});
  }

  bool buildArrayDocument(CreditProvider provider) {
    int val = 0;
    provider.listDocument.forEach((element) {
      if (element.requerido == "") {
        val++;
      }
    });
    return val == 7 ? true : false;
  }
}
