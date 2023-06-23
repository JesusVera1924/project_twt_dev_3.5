// ignore_for_file: use_build_context_synchronously

import 'package:devolucion_modulo/provider/items_provider.dart';
import 'package:devolucion_modulo/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:devolucion_modulo/models/inner/ig0062Response.dart';
import 'package:devolucion_modulo/ui/dialog/show_dialog_transport2.dart';
import 'package:devolucion_modulo/util/constants.dart';
import 'package:devolucion_modulo/util/screen_size.dart';

class OtherDetails extends StatefulWidget {
  const OtherDetails({Key? key, required this.data, required this.provider})
      : super(key: key);
  final Ig0062Response data;
  final ItemsProvider provider;

  @override
  State<OtherDetails> createState() => _OtherDetailsState();
}

class _OtherDetailsState extends State<OtherDetails> {
  Iterable<MapEntry<String, String>> get _fieldValues =>
      _onGenerateFields(widget.data).entries;

  @override
  Widget build(BuildContext context) {
    bool _isHover = false;
    final _width = ScreenQueries.instance.width(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                width:
                    Responsive.isTablet(context) ? _width * 0.2 : _width * 0.1,
                child: const Text('Datos del Envio',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => _isHover = true),
              onExit: (_) => setState(() => _isHover = false),
              child: GestureDetector(
                  onTap: () async {
                    final data = {
                      "cod_cop": widget.data.codCop,
                      "nom_cop": widget.data.nomCop,
                      "ngr_cop": widget.data.ngrCop.toString(),
                      "frg_cop": widget.data.fgrCop,
                      "blt_cop": widget.data.bltCop.toString(),
                      "destino": widget.data.destino == ""
                          ? "MATRIZ"
                          : widget.data.destino
                    };

                    var val = await showDialogTransport2(
                        context, widget.data.numSdv, data, true);
                    if (val != null) {
                      widget.provider
                          .getUpdateTransport(widget.data.numSdv, val);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Tooltip(
                      message: "Editar", child: Icon(Icons.edit))),
            ),
            const CloseButton(),
          ],
        ),
        for (final _fieldValue in _fieldValues) ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: Responsive.isTablet(context)
                      ? _width * 0.2
                      : _width * 0.1,
                  child: Text(_fieldValue.key),
                ),
                SizedBox(
                  width: Responsive.isTablet(context)
                      ? _width * 0.2
                      : _width * 0.1,
                  child: Text(
                    _fieldValue.value,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ],
      ],
    );
  }

  Map<String, String> _onGenerateFields(Ig0062Response data) {
    final _fieldValues = {
      DataTableConstants.colCod: data.codCop,
      DataTableConstants.colNom: data.nomCop,
      DataTableConstants.colNgr: data.ngrCop,
      DataTableConstants.colFgr: data.fgrCop.toString(),
      DataTableConstants.colBlt: data.bltCop.toString(),
      DataTableConstants.destino: data.destino.toString(),
    };

    return _fieldValues;
  }
}
