import 'package:devolucion_modulo/inputs/custom_inputs.dart';
import 'package:devolucion_modulo/models/inner/ig0063Response.dart';
import 'package:devolucion_modulo/provider/items_ig0063.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';
import 'package:devolucion_modulo/util/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<bool> customDialog7(BuildContext context, String title,
    Ig0063Response objeto, ItemsIg0063 provider) async {
  bool resp = false;
  final txtComent = TextEditingController(text: objeto.obsMrm);
  bool _isHover = false;
  final _width = ScreenQueries.instance.width(context);

  await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: Row(
                children: [
                  const Icon(Icons.info, color: Colors.blueGrey),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(title, style: CustomLabels.h5),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (objeto.clsMdm != "G")
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const SizedBox(
                                width: 90,
                                child: Text(
                                  "MOTIVO:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                              SizedBox(
                                width: _width * 0.2,
                                child: Text(
                                  objeto.obsMdm,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const SizedBox(
                              width: 90,
                              child: Text("OBSERVACIÓN:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            ),
                            SizedBox(
                              width: _width * 0.2,
                              child: Text(
                                objeto.ofsSdv == ""
                                    ? "NO SE INGRESO INFORMACION"
                                    : objeto.ofsSdv,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (objeto.clsMdm == "G")
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const SizedBox(
                                  width: 90,
                                  child: Text("DOCUMENTO:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                ),
                                SizedBox(
                                    width: _width * 0.2,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.download,
                                            color: Colors.green),
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          onEnter: (_) =>
                                              setState(() => _isHover = true),
                                          onExit: (_) =>
                                              setState(() => _isHover = false),
                                          child: GestureDetector(
                                            onTap: () async {
                                              await provider
                                                  .downloadDocument(objeto);
                                            },
                                            child: const Text(
                                              "DESCARGAR INF.TECNICO",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Colors.green,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        )
                                      ],
                                    ))
                              ],
                            )),
                      ],
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: _width * 0.2 + 70,
                          child: TextFormField(
                              controller: txtComent,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'(^[a-zA-Z 0-9.-]*$)')),
                                LengthLimitingTextInputFormatter(200),
                              ],
                              maxLines: 2,
                              style: const TextStyle(fontSize: 12),
                              decoration: CustomInputs.dialogInputDecoration(
                                  hint: "Ingresar Comentario...")),
                        ),
                        SizedBox(
                          width: 20,
                          child: Tooltip(
                              message: "Guardar comentario",
                              child: InkWell(
                                onTap: () async {
                                  objeto.obsMrm = txtComent.text;
                                  await provider.saveComentario(objeto);
                                },
                                child: const Icon(
                                  Icons.save_as_rounded,
                                  color: Colors.blueGrey,
                                  size: 32,
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      });
  return resp;
}
