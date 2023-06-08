import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/cliente.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';

Future<String> customDialog4(BuildContext context, List<Cliente> ticket) async {
  String op = "";
  // ignore: unused_local_variable
  bool isHover = false;
  await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text(
              'Seleccione un codigo de referencia',
              style: CustomLabels.h6,
            ),
            content: Container(
              width: 60,
              height: 80,
              child: ListView.builder(
                  itemCount: ticket.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: GestureDetector(
                          onTap: () {
                            op = ticket[i].codRef;
                            Navigator.of(context).pop();
                          },
                          child: Column(
                            children: [
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                onEnter: (event) =>
                                    setState(() => isHover = true),
                                onExit: (event) =>
                                    setState(() => isHover = false),
                                child: Text(
                                  '${ticket[i].codRef}',
                                  style: CustomLabels.h8,
                                ),
                              ),
                              Divider(thickness: 1)
                            ],
                          )),
                    );
                  }),
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
                    op = "true";
                    Navigator.of(context).pop();
                  },
                  child: Text('Aceptar', style: CustomLabels.h4)),
            ],
          );
        });
      });
  return op;
}
