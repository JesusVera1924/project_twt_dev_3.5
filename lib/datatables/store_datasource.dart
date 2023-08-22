// ignore_for_file: use_build_context_synchronously

import 'package:devolucion_modulo/models/inner/ig0063Response.dart';
import 'package:devolucion_modulo/models/modifyModel/detail_bodega.dart';
import 'package:devolucion_modulo/provider/items_ig0063.dart';
import 'package:devolucion_modulo/ui/dialog/devolucion/show_dialog_alterno.dart';
import 'package:devolucion_modulo/ui/dialog/kardex/show_dialog_kardex.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog1.dart';
import 'package:devolucion_modulo/ui/dialog/mensajes/custom_dialog7.dart';
import 'package:devolucion_modulo/ui/inputs/input_bod.dart';
import 'package:devolucion_modulo/util/responsive.dart';
import 'package:devolucion_modulo/util/util_view.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StoreDataSource extends DataGridSource {
  final BuildContext context;
  final ItemsIg0063 provider;
  TextEditingController controller = TextEditingController();
  List<DataGridRow> _dataGridRows = [];

  StoreDataSource(this.context, this.provider) {
    buildDataGridRows();
  }

  void buildDataGridRows() {
    _dataGridRows = provider.listBodega.map<DataGridRow>((DetailBodega team) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(columnName: '1-codigo', value: team.item.codPro),
        DataGridCell<String>(
            columnName: '2-marca', value: team.item.obsSdv.split('::')[1]),
        DataGridCell<String>(
            columnName: '3-grupo', value: team.item.obsSdv.split('::')[2]),
        DataGridCell<DetailBodega>(columnName: '4-recibido', value: team),
        DataGridCell<String>(
            columnName: '9-solicitud', value: team.item.clsMdm),
        DataGridCell<Ig0063Response>(columnName: '11-kardex', value: team.item),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: _buildDataGridForDts(row));
  }

  List<Widget> _buildDataGridForDts(DataGridRow row) {
    List<Widget> list = [];

    if (Responsive.isTablet(context)) {
      list = [
        Tooltip(
          message:
              "MARCA: ${row.getCells()[1].value.toString()}\nGRUPO:${row.getCells()[2].value.toString()}",
          child: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.centerLeft,
              child: Text(row.getCells()[0].value.toString())),
        ),
        Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(
                "${row.getCells()[3].value.item.canB91} - ${row.getCells()[3].value.item.canB92}")),
        //----------------------------------------
        Row(
          children: [
            SizedBox(
              width: 55,
              height: 30,
              child: InputBod(
                  textAlign: TextAlign.right,
                  controller: row.getCells()[3].value.controller93,
                  enable: row.getCells()[3].value.diseable93,
                  hint: '',
                  regx: r'^(?:\+|-)?\d+$',
                  length: 6,
                  onChanged: (value) {
                    var e = row.getCells()[3].value;
                    if (value != "") {
                      e.check93 = false;
                      e.item.canB93 = double.parse(value);
                      if (e.item.canB92 <= e.item.canB91 &&
                          double.parse(value) <= e.item.canB91 &&
                          double.parse(value) <= e.item.canB92) {
                        e.item.canB93 = double.parse(value);

                        print("Variables para el calculo");
                        print(value);
                        print(e.item.canB92);

                        if ((double.parse(value) - e.item.canB92) == 0) {
                          if (e.controller93.text == "") e.diseable93 = false;
                          if (e.controller94.text == "") e.diseable94 = false;
                          if (e.controller95.text == "") e.diseable95 = false;
                          if (e.controller96.text == "") e.diseable96 = false;
                        }
                        /* setState(() {
                          vistaText = "1";
                          vistaCombo = "0";
                        }); */
                      } else {
                        customDialog1(context,
                            'Supero la cantida maxima de ítems recibido');
                        e.controller93.text = e.tempVal93;
                        e.item.canB93 = double.parse(e.tempVal93);
                      }
                    } else {
                      /*  setState(() {
                        vistaText = "0";
                        vistaCombo = "0";
                      }); */

                      e.item.canB93 = 0;
                      if (e.controller93.text == "") e.diseable93 = true;
                      if (e.controller94.text == "") e.diseable94 = true;
                      if (e.controller95.text == "") e.diseable95 = true;
                      if (e.controller96.text == "") e.diseable96 = true;
                    }
                    provider.proceso1(e);
                    notifyDataSourceListeners();
                  },
                  onEditingComplete: () {}),
            ),
            Checkbox(
                value: row.getCells()[3].value.check93,
                onChanged: (value) async {
                  var e = row.getCells()[3].value;
                  if (e.controller93.text == "") return;
                  var val = 0;
                  e.check93 = value ?? false;
                  if (e.check93) {
                    //modi++;
                    if (int.parse(e.controller93.text) >
                        int.parse(e.tempVal93)) {
                      val = int.parse(e.controller93.text) -
                          int.parse(e.tempVal93);

                      e.item.canB92 = e.item.canB92 - val;
                      provider.registroKardex(
                          e.item, "$val", "92", "-", e.item.canB92);
                      provider.registroKardex(
                          e.item, "$val", "93", "+", e.item.canB92);

                      provider.updateBodega(e.item.codPro, "93", "$val", "92");

                      e.item.obsMrm = controller.text != ""
                          ? e.item.obsMrm + "::" + controller.text
                          : "";

                      provider.postIg0063Update(e.item);
                    } else {
                      val = int.parse(e.tempVal93) -
                          int.parse(e.controller93.text);

                      e.item.canB92 = e.item.canB92 + val;

                      provider.registroKardex(
                          e.item, "$val", "93", "-", e.item.canB92);
                      provider.registroKardex(
                          e.item, "$val", "92", "+", e.item.canB92);

                      provider.updateBodega(e.item.codPro, "92", "$val", "93");

                      e.item.obsMrm = controller.text != ""
                          ? e.item.obsMrm + "::" + controller.text
                          : "";

                      provider.postIg0063Update(e.item);

                      if (e.item.canB91 >= e.item.canB92) {
                        e.diseable94 = true;
                        e.diseable95 = true;
                        e.diseable96 = true;
                      }
                    }
                  }

                  //vistaText = "0";
                  // vistaCombo = "0";

                  e.tempVal93 = e.controller93.text;
                  //setState(() {});
                  provider.proceso1(e);
                  notifyDataSourceListeners();
                })
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 55,
              height: 30,
              child: InputBod(
                  textAlign: TextAlign.right,
                  controller: row.getCells()[3].value.controller94,
                  enable: row.getCells()[3].value.diseable94,
                  hint: '',
                  regx: r'^(?:\+|-)?\d+$',
                  length: 6,
                  onChanged: (value) {
                    var e = row.getCells()[3].value;
                    if (value != "") {
                      e.check94 = false;
                      e.item.canB94 = double.parse(value);

                      if (e.item.canB92 <= e.item.canB91 &&
                          double.parse(value) <= e.item.canB91 &&
                          double.parse(value) <= e.item.canB92) {
                        e.item.canB94 = double.parse(value);

                        if (e.item.canB92 - double.parse(value) == 0) {
                          if (e.controller93.text == "") e.diseable93 = false;
                          if (e.controller94.text == "") e.diseable94 = false;
                          if (e.controller95.text == "") e.diseable95 = false;
                          if (e.controller96.text == "") e.diseable96 = false;
                        }
                        /*  setState(() {
                          //e.item.codRef
                          vistaCombo = "0"; //OJO
                          vistaText = "0";
                        }); */
                      } else {
                        customDialog1(context,
                            'Supero la cantida maxima de ítems recibido');
                        e.controller94.text = e.tempVal94;
                        e.item.canB94 = double.parse(e.tempVal94);
                      }
                    } else {
                      /*  setState(() {
                        vistaCombo = "0";
                        vistaText = "0";
                      }); */
                      e.item.canB94 = 0;

                      if (e.controller93.text == "") e.diseable93 = true;
                      if (e.controller94.text == "") e.diseable94 = true;
                      if (e.controller95.text == "") e.diseable95 = true;
                      if (e.controller96.text == "") e.diseable96 = true;
                    }
                    provider.proceso1(e);
                    notifyDataSourceListeners();
                  },
                  onEditingComplete: () {}),
            ),
            Checkbox(
                value: row.getCells()[3].value.check94,
                onChanged: (value) async {
                  var e = row.getCells()[3].value;
                  if (e.controller94.text == "") return;
                  var val = 0;
                  e.check94 = value ?? false;

                  if (e.check94) {
                    /*  modi++; */
                    if (int.parse(e.controller94.text) >
                        int.parse(e.tempVal94)) {
                      val = int.parse(e.controller94.text) -
                          int.parse(e.tempVal94);

                      e.item.canB92 = e.item.canB92 - val;
                      provider.registroKardex(
                          e.item, "$val", "92", "-", e.item.canB92);

                      provider.registroKardex(
                          e.item, "$val", "94", "+", e.item.canB92);

                      provider.updateBodega(e.item.codPro, "94", "$val", "92");

                      provider.postIg0063Update(e.item);
                    } else {
                      val = int.parse(e.tempVal94) -
                          int.parse(e.controller94.text);

                      e.item.canB92 = e.item.canB92 + val;

                      provider.registroKardex(
                          e.item, "$val", "94", "-", e.item.canB92);

                      provider.registroKardex(
                          e.item, "$val", "92", "+", e.item.canB92);

                      provider.updateBodega(e.item.codPro, "92", "$val", "94");

                      provider.postIg0063Update(e.item);

                      if (e.item.canB91 >= e.item.canB92) {
                        e.diseable93 = true;
                        e.diseable95 = true;
                        e.diseable96 = true;
                      }
                    }
                  }

                  //vistaText = "0";
                  //vistaCombo = "0";

                  e.tempVal94 = e.controller94.text;
                  //setState(() {});

                  provider.proceso1(e);
                  notifyDataSourceListeners();
                })
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 55,
              height: 30,
              child: InputBod(
                  textAlign: TextAlign.right,
                  controller: row.getCells()[3].value.controller95,
                  enable: row.getCells()[3].value.diseable95,
                  hint: '',
                  regx: r'^(?:\+|-)?\d+$',
                  length: 6,
                  onChanged: (value) {
                    var e = row.getCells()[3].value;
                    if (value != "") {
                      e.check95 = false;
                      e.item.canB95 = double.parse(value);

                      if (e.item.canB92 <= e.item.canB91 &&
                          double.parse(value) <= e.item.canB91 &&
                          double.parse(value) <= e.item.canB92) {
                        e.item.canB95 = double.parse(value);
                        if (e.item.canB92 - double.parse(value) == 0) {
                          if (e.controller93.text == "") e.diseable93 = false;
                          if (e.controller94.text == "") e.diseable94 = false;
                          if (e.controller95.text == "") e.diseable95 = false;
                          if (e.controller96.text == "") e.diseable96 = false;
                        }
                        /*  setState(() {
                          vistaText = "1";
                          vistaCombo = "0";
                        }); */
                      } else {
                        customDialog1(context,
                            'Supero la cantida maxima de ítems recibido');

                        e.controller95.text = e.tempVal95;

                        e.item.canB95 = double.parse(e.tempVal95);
                      }
                    } else {
                      /*    setState(() {
                        vistaText = "0";
                        vistaCombo = "0";
                      }); */
                      e.item.canB95 = 0;
                      if (e.controller93.text == "") e.diseable93 = true;
                      if (e.controller94.text == "") e.diseable94 = true;
                      if (e.controller95.text == "") e.diseable95 = true;
                      if (e.controller96.text == "") e.diseable96 = true;
                    }
                    provider.proceso1(e);
                    notifyDataSourceListeners();
                  },
                  onEditingComplete: () {}),
            ),
            Checkbox(
                value: row.getCells()[3].value.check95,
                onChanged: (value) async {
                  var e = row.getCells()[3].value;
                  if (e.controller95.text == "") return;
                  var val = 0;
                  e.check95 = value ?? false;
                  if (e.check95) {
                    /*  modi++; */
                    if (int.parse(e.controller95.text) >
                        int.parse(e.tempVal95)) {
                      val = int.parse(e.controller95.text) -
                          int.parse(e.tempVal95);

                      e.item.canB92 = e.item.canB92 - val;

                      provider.registroKardex(
                          e.item, "$val", "92", "-", e.item.canB92);
                      provider.registroKardex(
                          e.item, "$val", "95", "+", e.item.canB92);

                      provider.updateBodega(e.item.codPro, "95", "$val", "92");

                      e.item.obsMrm = controller.text != ""
                          ? e.item.obsMrm + "::" + controller.text
                          : "";

                      provider.postIg0063Update(e.item);
                    } else {
                      val = int.parse(e.tempVal95) -
                          int.parse(e.controller95.text);

                      e.item.canB92 = e.item.canB92 + val;

                      provider.registroKardex(
                          e.item, "$val", "95", "-", e.item.canB92);
                      provider.registroKardex(
                          e.item, "$val", "92", "+", e.item.canB92);

                      provider.updateBodega(e.item.codPro, "92", "$val", "95");

                      e.item.obsMrm = controller.text != ""
                          ? e.item.obsMrm + "::" + controller.text
                          : "";

                      provider.postIg0063Update(e.item);

                      if (e.item.canB91 >= e.item.canB92) {
                        e.diseable93 = true;
                        e.diseable94 = true;
                        e.diseable96 = true;
                      }
                    }
                  }

                  //vistaText = "0";
                  //vistaCombo = "0";

                  e.tempVal95 = e.controller95.text;
                  // setState(() {});
                  provider.proceso1(e);
                  notifyDataSourceListeners();
                })
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 55,
              height: 30,
              child: InputBod(
                  textAlign: TextAlign.right,
                  controller: row.getCells()[3].value.controller96,
                  enable: row.getCells()[3].value.diseable96,
                  hint: '',
                  regx: r'^(?:\+|-)?\d+$',
                  length: 6,
                  onChanged: (value) {
                    //row.getCells()[3].value.check96 = false;
                    var e = row.getCells()[3].value;
                    if (value != "") {
                      e.check96 = false;
                      e.item.canB96 = double.parse(value);

                      if (e.item.canB92 <= e.item.canB91 &&
                          double.parse(value) <= e.item.canB91 &&
                          double.parse(value) <= e.item.canB92) {
                        e.item.canB96 = double.parse(value);
                        if (e.item.canB92 - double.parse(value) == 0) {
                          if (e.controller93.text == "") e.diseable93 = false;
                          if (e.controller94.text == "") e.diseable94 = false;
                          if (e.controller95.text == "") e.diseable95 = false;
                          if (e.controller96.text == "") e.diseable96 = false;
                        }
                        /*  setState(() {
                          vistaText = "1";
                          vistaCombo = "0";
                        }); */
                      } else {
                        customDialog1(context,
                            'Supero la cantida maxima de ítems recibido');

                        e.controller96.text = e.tempVal96;

                        e.item.canB96 = double.parse(e.tempVal96);
                      }
                    } else {
                      /*  setState(() {
                        vistaText = "0";
                        vistaCombo = "0";
                      }); */
                      e.item.canB96 = 0;

                      if (e.controller93.text == "") e.diseable93 = true;
                      if (e.controller94.text == "") e.diseable94 = true;
                      if (e.controller95.text == "") e.diseable95 = true;
                      if (e.controller96.text == "") e.diseable96 = true;
                    }
                    provider.proceso1(e);
                    notifyDataSourceListeners();
                  },
                  onEditingComplete: () {}),
            ),
            Checkbox(
                value: row.getCells()[3].value.check96,
                onChanged: (value) async {
                  var e = row.getCells()[3].value;
                  if (e.controller96.text == "") {
                    return;
                  }

                  var val = 0;
                  e.check96 = value ?? false;
                  if (e.check96) {
                    //modi++;
                    if (int.parse(e.controller96.text) >
                        int.parse(e.tempVal96)) {
                      val = int.parse(e.controller96.text) -
                          int.parse(e.tempVal96);

                      e.item.canB92 = e.item.canB92 - val;

                      provider.registroKardex(
                          e.item, "$val", "92", "-", e.item.canB92);

                      provider.registroKardex(
                          e.item, "$val", "96", "+", e.item.canB92);

                      provider.updateBodega(e.item.codPro, "96", "$val", "92");

                      e.item.obsMrm = controller.text != ""
                          ? e.item.obsMrm + "::" + controller.text
                          : "";

                      provider.postIg0063Update(e.item);
                    } else {
                      val = int.parse(e.tempVal96) -
                          int.parse(e.controller96.text);

                      e.item.canB92 = e.item.canB92 + val;

                      provider.registroKardex(
                          e.item, "$val", "96", "-", e.item.canB92);

                      provider.registroKardex(
                          e.item, "$val", "92", "+", e.item.canB92);

                      provider.updateBodega(e.item.codPro, "92", "$val", "96");

                      e.item.obsMrm = controller.text != ""
                          ? e.item.obsMrm + "::" + controller.text
                          : "";

                      provider.postIg0063Update(e.item);

                      if (e.item.canB91 >= e.item.canB92) {
                        e.diseable93 = true;
                        e.diseable94 = true;
                        e.diseable95 = true;
                      }
                    }
                  }

                  //vistaText = "0";
                  //vistaCombo = "0";

                  e.tempVal96 = e.controller96.text;
                  //setState(() {});
                  provider.proceso1(e);
                  notifyDataSourceListeners();
                })
          ],
        ),

        //------------------------------------
        InkWell(
            onTap: () async => proceso2(row),
            child: const Icon(Icons.segment_sharp)),
        InkWell(
            onTap: () async => proceso3(row.getCells()[5].value),
            child: const Icon(Icons.info))
      ];
    } else {
      list = [
        InkWell(
          onTap: () async {
            showDialogAlternos(
                context, await provider.getAlternos(row.getCells()[0].value));
          },
          child: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.centerLeft,
              child: Text(row.getCells()[0].value.toString())),
        ),
        Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(row.getCells()[1].value.toString())),
        Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(row.getCells()[2].value.toString())),
        Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text("${row.getCells()[3].value.item.canB91}")),
        //----------------------------------------
        Row(
          children: [
            SizedBox(
              width: 55,
              height: 30,
              child: InputBod(
                  textAlign: TextAlign.right,
                  controller: row.getCells()[3].value.controller93,
                  enable: row.getCells()[3].value.diseable93,
                  hint: '',
                  regx: r'^(?:\+|-)?\d+$',
                  length: 6,
                  onChanged: (value) {
                    var e = row.getCells()[3].value;
                    if (value != "") {
                      e.check93 = false;
                      e.item.canB93 = double.parse(value);
                      if (e.item.canB92 <= e.item.canB91 &&
                          double.parse(value) <= e.item.canB91 &&
                          double.parse(value) <= e.item.canB92) {
                        e.item.canB93 = double.parse(value);

                        print("Variables para el calculo");
                        print(value);
                        print(e.item.canB92);

                        if ((double.parse(value) - e.item.canB92) == 0) {
                          if (e.controller93.text == "") e.diseable93 = false;
                          if (e.controller94.text == "") e.diseable94 = false;
                          if (e.controller95.text == "") e.diseable95 = false;
                          if (e.controller96.text == "") e.diseable96 = false;
                        }
                        /* setState(() {
                          vistaText = "1";
                          vistaCombo = "0";
                        }); */
                      } else {
                        customDialog1(context,
                            'Supero la cantida maxima de ítems recibido');
                        e.controller93.text = e.tempVal93;
                        e.item.canB93 = double.parse(e.tempVal93);
                      }
                    } else {
                      /*  setState(() {
                        vistaText = "0";
                        vistaCombo = "0";
                      }); */

                      e.item.canB93 = 0;
                      if (e.controller93.text == "") e.diseable93 = true;
                      if (e.controller94.text == "") e.diseable94 = true;
                      if (e.controller95.text == "") e.diseable95 = true;
                      if (e.controller96.text == "") e.diseable96 = true;
                    }
                    provider.proceso1(e);
                    notifyDataSourceListeners();
                  },
                  onEditingComplete: () {}),
            ),
            Checkbox(
                value: row.getCells()[3].value.check93,
                onChanged: (value) async {
                  var e = row.getCells()[3].value;
                  if (e.controller93.text == "") return;
                  var val = 0;
                  e.check93 = value ?? false;
                  if (e.check93) {
                    //modi++;
                    if (int.parse(e.controller93.text) >
                        int.parse(e.tempVal93)) {
                      val = int.parse(e.controller93.text) -
                          int.parse(e.tempVal93);

                      e.item.canB92 = e.item.canB92 - val;
                      provider.registroKardex(
                          e.item, "$val", "92", "-", e.item.canB92);
                      provider.registroKardex(
                          e.item, "$val", "93", "+", e.item.canB92);

                      provider.updateBodega(e.item.codPro, "93", "$val", "92");

                      e.item.obsMrm = controller.text != ""
                          ? e.item.obsMrm + "::" + controller.text
                          : "";

                      provider.postIg0063Update(e.item);
                    } else {
                      val = int.parse(e.tempVal93) -
                          int.parse(e.controller93.text);
                      e.item.canB92 = e.item.canB92 + val;

                      provider.registroKardex(
                          e.item, "$val", "93", "-", e.item.canB92);
                      provider.registroKardex(
                          e.item, "$val", "92", "+", e.item.canB92);

                      provider.updateBodega(e.item.codPro, "92", "$val", "93");

                      e.item.obsMrm = controller.text != ""
                          ? e.item.obsMrm + "::" + controller.text
                          : "";

                      provider.postIg0063Update(e.item);

                      if (e.item.canB91 >= e.item.canB92) {
                        e.diseable94 = true;
                        e.diseable95 = true;
                        e.diseable96 = true;
                      }
                    }
                  }

                  //vistaText = "0";
                  // vistaCombo = "0";

                  e.tempVal93 = e.controller93.text;
                  //setState(() {});
                  provider.proceso1(e);
                  notifyDataSourceListeners();
                })
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 55,
              height: 30,
              child: InputBod(
                  textAlign: TextAlign.right,
                  controller: row.getCells()[3].value.controller94,
                  enable: row.getCells()[3].value.diseable94,
                  hint: '',
                  regx: r'^(?:\+|-)?\d+$',
                  length: 6,
                  onChanged: (value) {
                    var e = row.getCells()[3].value;
                    if (value != "") {
                      e.check94 = false;
                      e.item.canB94 = double.parse(value);

                      if (e.item.canB92 <= e.item.canB91 &&
                          double.parse(value) <= e.item.canB91 &&
                          double.parse(value) <= e.item.canB92) {
                        e.item.canB94 = double.parse(value);

                        if (e.item.canB92 - double.parse(value) == 0) {
                          if (e.controller93.text == "") e.diseable93 = false;
                          if (e.controller94.text == "") e.diseable94 = false;
                          if (e.controller95.text == "") e.diseable95 = false;
                          if (e.controller96.text == "") e.diseable96 = false;
                        }
                        /*  setState(() {
                          //e.item.codRef
                          vistaCombo = "0"; //OJO
                          vistaText = "0";
                        }); */
                      } else {
                        customDialog1(context,
                            'Supero la cantida maxima de ítems recibido');
                        e.controller94.text = e.tempVal94;
                        e.item.canB94 = double.parse(e.tempVal94);
                      }
                    } else {
                      /*  setState(() {
                        vistaCombo = "0";
                        vistaText = "0";
                      }); */
                      e.item.canB94 = 0;

                      if (e.controller93.text == "") e.diseable93 = true;
                      if (e.controller94.text == "") e.diseable94 = true;
                      if (e.controller95.text == "") e.diseable95 = true;
                      if (e.controller96.text == "") e.diseable96 = true;
                    }
                    provider.proceso1(e);
                    notifyDataSourceListeners();
                  },
                  onEditingComplete: () {}),
            ),
            Checkbox(
                value: row.getCells()[3].value.check94,
                onChanged: (value) async {
                  var e = row.getCells()[3].value;
                  if (e.controller94.text == "") return;
                  var val = 0;
                  e.check94 = value ?? false;

                  if (e.check94) {
                    /*  modi++; */
                    if (int.parse(e.controller94.text) >
                        int.parse(e.tempVal94)) {
                      val = int.parse(e.controller94.text) -
                          int.parse(e.tempVal94);

                      e.item.canB92 = e.item.canB92 - val;
                      provider.registroKardex(
                          e.item, "$val", "92", "-", e.item.canB92);

                      provider.registroKardex(
                          e.item, "$val", "94", "+", e.item.canB92);

                      provider.updateBodega(e.item.codPro, "94", "$val", "92");

                      provider.postIg0063Update(e.item);
                    } else {
                      val = int.parse(e.tempVal94) -
                          int.parse(e.controller94.text);
                      e.item.canB92 = e.item.canB92 + val;

                      provider.registroKardex(
                          e.item, "$val", "94", "-", e.item.canB92);

                      provider.registroKardex(
                          e.item, "$val", "92", "+", e.item.canB92);

                      provider.updateBodega(e.item.codPro, "92", "$val", "94");

                      provider.postIg0063Update(e.item);

                      if (e.item.canB91 >= e.item.canB92) {
                        e.diseable93 = true;
                        e.diseable95 = true;
                        e.diseable96 = true;
                      }
                    }
                  }

                  //vistaText = "0";
                  //vistaCombo = "0";

                  e.tempVal94 = e.controller94.text;
                  //setState(() {});

                  provider.proceso1(e);
                  notifyDataSourceListeners();
                })
          ],
        ),

        Row(
          children: [
            SizedBox(
              width: 55,
              height: 30,
              child: InputBod(
                  textAlign: TextAlign.right,
                  controller: row.getCells()[3].value.controller95,
                  enable: row.getCells()[3].value.diseable95,
                  hint: '',
                  regx: r'^(?:\+|-)?\d+$',
                  length: 6,
                  onChanged: (value) {
                    var e = row.getCells()[3].value;
                    if (value != "") {
                      e.check95 = false;
                      e.item.canB95 = double.parse(value);

                      if (e.item.canB92 <= e.item.canB91 &&
                          double.parse(value) <= e.item.canB91 &&
                          double.parse(value) <= e.item.canB92) {
                        e.item.canB95 = double.parse(value);
                        if (e.item.canB92 - double.parse(value) == 0) {
                          if (e.controller93.text == "") e.diseable93 = false;
                          if (e.controller94.text == "") e.diseable94 = false;
                          if (e.controller95.text == "") e.diseable95 = false;
                          if (e.controller96.text == "") e.diseable96 = false;
                        }
                        /*  setState(() {
                          vistaText = "1";
                          vistaCombo = "0";
                        }); */
                      } else {
                        customDialog1(context,
                            'Supero la cantida maxima de ítems recibido');

                        e.controller95.text = e.tempVal95;

                        e.item.canB95 = double.parse(e.tempVal95);
                      }
                    } else {
                      /*    setState(() {
                        vistaText = "0";
                        vistaCombo = "0";
                      }); */
                      e.item.canB95 = 0;
                      if (e.controller93.text == "") e.diseable93 = true;
                      if (e.controller94.text == "") e.diseable94 = true;
                      if (e.controller95.text == "") e.diseable95 = true;
                      if (e.controller96.text == "") e.diseable96 = true;
                    }
                    provider.proceso1(e);
                    notifyDataSourceListeners();
                  },
                  onEditingComplete: () {}),
            ),
            Checkbox(
                value: row.getCells()[3].value.check95,
                onChanged: (value) async {
                  var e = row.getCells()[3].value;
                  if (e.controller95.text == "") return;
                  var val = 0;
                  e.check95 = value ?? false;
                  if (e.check95) {
                    /*  modi++; */
                    if (int.parse(e.controller95.text) >
                        int.parse(e.tempVal95)) {
                      val = int.parse(e.controller95.text) -
                          int.parse(e.tempVal95);

                      e.item.canB92 = e.item.canB92 - val;
                      provider.registroKardex(
                          e.item, "$val", "92", "-", e.item.canB92);
                      provider.registroKardex(
                          e.item, "$val", "95", "+", e.item.canB92);

                      provider.updateBodega(e.item.codPro, "95", "$val", "92");

                      e.item.obsMrm = controller.text != ""
                          ? e.item.obsMrm + "::" + controller.text
                          : "";

                      provider.postIg0063Update(e.item);
                    } else {
                      val = int.parse(e.tempVal95) -
                          int.parse(e.controller95.text);

                      e.item.canB92 = e.item.canB92 + val;

                      provider.registroKardex(
                          e.item, "$val", "95", "-", e.item.canB92);
                      provider.registroKardex(
                          e.item, "$val", "92", "+", e.item.canB92);

                      provider.updateBodega(e.item.codPro, "92", "$val", "95");

                      e.item.obsMrm = controller.text != ""
                          ? e.item.obsMrm + "::" + controller.text
                          : "";

                      provider.postIg0063Update(e.item);

                      if (e.item.canB91 >= e.item.canB92) {
                        e.diseable93 = true;
                        e.diseable94 = true;
                        e.diseable96 = true;
                      }
                    }
                  }

                  //vistaText = "0";
                  //vistaCombo = "0";

                  e.tempVal95 = e.controller95.text;
                  // setState(() {});
                  provider.proceso1(e);
                  notifyDataSourceListeners();
                })
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 55,
              height: 30,
              child: InputBod(
                  textAlign: TextAlign.right,
                  controller: row.getCells()[3].value.controller96,
                  enable: row.getCells()[3].value.diseable96,
                  hint: '',
                  regx: r'^(?:\+|-)?\d+$',
                  length: 6,
                  onChanged: (value) {
                    //row.getCells()[3].value.check96 = false;
                    var e = row.getCells()[3].value;
                    if (value != "") {
                      e.check96 = false;
                      e.item.canB96 = double.parse(value);

                      if (e.item.canB92 <= e.item.canB91 &&
                          double.parse(value) <= e.item.canB91 &&
                          double.parse(value) <= e.item.canB92) {
                        e.item.canB96 = double.parse(value);
                        if (e.item.canB92 - double.parse(value) == 0) {
                          if (e.controller93.text == "") e.diseable93 = false;
                          if (e.controller94.text == "") e.diseable94 = false;
                          if (e.controller95.text == "") e.diseable95 = false;
                          if (e.controller96.text == "") e.diseable96 = false;
                        }
                        /*  setState(() {
                          vistaText = "1";
                          vistaCombo = "0";
                        }); */
                      } else {
                        customDialog1(context,
                            'Supero la cantida maxima de ítems recibido');

                        e.controller96.text = e.tempVal96;

                        e.item.canB96 = double.parse(e.tempVal96);
                      }
                    } else {
                      /*  setState(() {
                        vistaText = "0";
                        vistaCombo = "0";
                      }); */
                      e.item.canB96 = 0;

                      if (e.controller93.text == "") e.diseable93 = true;
                      if (e.controller94.text == "") e.diseable94 = true;
                      if (e.controller95.text == "") e.diseable95 = true;
                      if (e.controller96.text == "") e.diseable96 = true;
                    }
                    provider.proceso1(e);
                    notifyDataSourceListeners();
                  },
                  onEditingComplete: () {}),
            ),
            Checkbox(
                value: row.getCells()[3].value.check96,
                onChanged: (value) async {
                  var e = row.getCells()[3].value;
                  if (e.controller96.text == "") {
                    return;
                  }

                  var val = 0;
                  e.check96 = value ?? false;
                  if (e.check96) {
                    //modi++;
                    if (int.parse(e.controller96.text) >
                        int.parse(e.tempVal96)) {
                      val = int.parse(e.controller96.text) -
                          int.parse(e.tempVal96);

                      e.item.canB92 = e.item.canB92 - val;

                      provider.registroKardex(
                          e.item, "$val", "92", "-", e.item.canB92);

                      provider.registroKardex(
                          e.item, "$val", "96", "+", e.item.canB92);

                      provider.updateBodega(e.item.codPro, "96", "$val", "92");

                      e.item.obsMrm = controller.text != ""
                          ? e.item.obsMrm + "::" + controller.text
                          : "";

                      provider.postIg0063Update(e.item);
                    } else {
                      val = int.parse(e.tempVal96) -
                          int.parse(e.controller96.text);

                      e.item.canB92 = e.item.canB92 + val;

                      provider.registroKardex(
                          e.item, "$val", "96", "-", e.item.canB92);

                      provider.registroKardex(
                          e.item, "$val", "92", "+", e.item.canB92);

                      provider.updateBodega(e.item.codPro, "92", "$val", "96");

                      e.item.obsMrm = controller.text != ""
                          ? e.item.obsMrm + "::" + controller.text
                          : "";

                      provider.postIg0063Update(e.item);

                      if (e.item.canB91 >= e.item.canB92) {
                        e.diseable93 = true;
                        e.diseable94 = true;
                        e.diseable95 = true;
                      }
                    }
                  }

                  //vistaText = "0";
                  //vistaCombo = "0";

                  e.tempVal96 = e.controller96.text;
                  //setState(() {});
                  provider.proceso1(e);
                  notifyDataSourceListeners();
                })
          ],
        ),

        //------------------------------------
        Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              row.getCells()[4].value == "D" ? "Devolución" : "Garantia",
              style: UtilView.getStatusTextStyle(row.getCells()[4].value),
            )),
        Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text("${row.getCells()[3].value.item.canB92}")),
        InkWell(
            onTap: () async => proceso2(row),
            child: const Icon(Icons.segment_sharp)),
        InkWell(
            onTap: () async => proceso3(row.getCells()[5].value),
            child: const Icon(Icons.info))
      ];
    }

    return list;
  }

  void proceso2(DataGridRow row) async {
    Ig0063Response x = row.getCells()[5].value;
    var lista =
        await provider.getListKardex(x.numSdv, x.codPro, x.numMov, x.clsSdv);
    await showDialogKardex(
        context, 'kardex :: ${x.numSdv} :: ${x.codPro} ', lista);
  }

  void proceso3(Ig0063Response objeto) async {
    customDialog7(context, "Información", objeto, provider);
  }
}
