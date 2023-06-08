import 'package:flutter/material.dart';
import 'package:devolucion_modulo/ui/labels/custom_labels.dart';

Future<bool> dialogTerminos(BuildContext context, String title) async {
  bool resp = false;
  await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Row(
            children: [
              Icon(
                Icons.contact_support_outlined,
                color: Colors.blue,
                size: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  title,
                  style: CustomLabels.h5,
                ),
              ),
              Icon(
                Icons.contact_support_outlined,
                color: Colors.blue,
                size: 24,
              ),
            ],
          ),
          content: Container(
            width: 380,
            height: 250,
            child: RichText(
              //overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: 'Autorizo a ',
                style: CustomLabels.h6,
                children: <TextSpan>[
                  TextSpan(
                      text: 'COMERCIAL JAPONESA AUTOMOTRIZ CIA.LTDA (COJAPAN)',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      style: CustomLabels.h6,
                      text:
                          ' , para que pueda recabar, reportar o informar a cualquier buró de crédito sobre mi comprtamiento crediticio. Renuncio a domicilio,me someto a jueces de este cantón y trámite verbal sumario o ejecutivo.Firmo como suscritor autorizado en la fecha indicada porcedente a nombre propio y/o de la compradora, sin protesto. Declaro bajo juramento que el origen de los fondos entregados a '),
                  TextSpan(
                      text: 'COMERCIAL JAPONESA AUTOMOTRIZ CIA.LTDA (COJAPAN)',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      style: CustomLabels.h6,
                      text:
                          ' , provienen de actividades lícitas, y que los fondos y/o bienes que recibio de'),
                  TextSpan(
                      text: ' COMERCIAL JAPONESA AUTOMOTRIZ CIA.LTDA',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      style: CustomLabels.h6,
                      text:
                          ' , no seran destinado a la realización o financiamiento de alguna actividade ilícita.'),
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
                  resp = false;
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar', style: CustomLabels.h4)),
            TextButton(
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered))
                    return Colors.greenAccent;
                  return Colors.transparent;
                })),
                onPressed: () {
                  resp = true;
                  Navigator.of(context).pop();
                },
                child: Text('Aceptar', style: CustomLabels.h4))
          ],
        );
      });
  return resp;
}
