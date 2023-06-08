import 'package:intl/intl.dart';
import 'package:devolucion_modulo/models/mg0031.dart';
import 'package:devolucion_modulo/util/save_file_web.dart';
import 'package:devolucion_modulo/util/util_view.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'package:flutter/services.dart';

class CreateFileWeb {
  Future fillFormFields(
      bool isFlatten, Mg0031 obj, String ciu, String pro) async {
    final PdfDocument document =
        PdfDocument(inputBytes: await _readData('solicitud.pdf'));

    //Asignacion de valores en el formulario
    final PdfForm form = document.form;

    final PdfTextBoxField propietario =
        document.form.fields[0] as PdfTextBoxField;
    propietario.text = obj.nomPer;

    final PdfRadioButtonListField gender =
        form.fields[1] as PdfRadioButtonListField;
    gender.selectedIndex = obj.locRef == "A" ? 1 : 0;

    final PdfRadioButtonListField negocio =
        form.fields[2] as PdfRadioButtonListField;
    negocio.selectedIndex =
        UtilView.selectTipoNegocio(obj.tipRef); //obj.tipRef;

    final PdfTextBoxField email1 = document.form.fields[3] as PdfTextBoxField;
    email1.text = obj.ce1Ref;

    final PdfTextBoxField dirDomicilio =
        document.form.fields[4] as PdfTextBoxField;
    dirDomicilio.text = obj.dirPer;

    final PdfTextBoxField dirComercial =
        document.form.fields[5] as PdfTextBoxField;
    dirComercial.text = obj.dirRef;

    final PdfTextBoxField nomComercial =
        document.form.fields[6] as PdfTextBoxField;
    nomComercial.text = obj.nmcRef;

    final PdfTextBoxField razon = document.form.fields[7] as PdfTextBoxField;
    razon.text = obj.nomRef;

    final PdfTextBoxField telfDomcilio =
        document.form.fields[8] as PdfTextBoxField;
    telfDomcilio.text = obj.tlfPer;

    final PdfTextBoxField telfComercial =
        document.form.fields[9] as PdfTextBoxField;
    telfComercial.text = obj.tlfRef;

    final PdfTextBoxField ruc = document.form.fields[10] as PdfTextBoxField;
    ruc.text = obj.secNic;

    final PdfTextBoxField provincia =
        document.form.fields[11] as PdfTextBoxField;
    provincia.text = pro;

    final PdfTextBoxField celular = document.form.fields[12] as PdfTextBoxField;
    celular.text = obj.mv1Per;

    final PdfTextBoxField estadoCivil =
        document.form.fields[13] as PdfTextBoxField;
    estadoCivil.text = obj.ecrPer;

    final PdfTextBoxField ingresos =
        document.form.fields[14] as PdfTextBoxField;
    ingresos.text = obj.oiaMes;

    final PdfTextBoxField banco2 = document.form.fields[15] as PdfTextBoxField;
    banco2.text = obj.rb2Bco;

    final PdfTextBoxField cuenta3 = document.form.fields[16] as PdfTextBoxField;
    cuenta3.text = obj.rb3Cta;

    final PdfTextBoxField cuenta2 = document.form.fields[17] as PdfTextBoxField;
    cuenta2.text = obj.rb2Cta;

    final PdfTextBoxField cuenta1 = document.form.fields[18] as PdfTextBoxField;
    cuenta1.text = obj.rb1Cta;

    final PdfTextBoxField banco1 = document.form.fields[19] as PdfTextBoxField;
    banco1.text = obj.rb1Bco;
    final PdfTextBoxField banco3 = document.form.fields[20] as PdfTextBoxField;
    banco3.text = obj.rb3Bco;

    final PdfTextBoxField cedula = document.form.fields[21] as PdfTextBoxField;
    cedula.text = obj.secNic;

    final PdfTextBoxField email2 = document.form.fields[22] as PdfTextBoxField;
    email2.text = obj.ce2Ref;

    final PdfTextBoxField ciudad = document.form.fields[23] as PdfTextBoxField;
    ciudad.text = ciu;

    final PdfTextBoxField casa3 = document.form.fields[24] as PdfTextBoxField;
    casa3.text = obj.rc3Emp;
    final PdfTextBoxField casa2 = document.form.fields[25] as PdfTextBoxField;
    casa2.text = obj.rc2Emp;
    final PdfTextBoxField casa1 = document.form.fields[26] as PdfTextBoxField;
    casa1.text = obj.rc1Emp;

    final PdfTextBoxField monto3 = document.form.fields[27] as PdfTextBoxField;
    monto3.text = obj.rc3Vcr.toStringAsFixed(2);
    final PdfTextBoxField monto2 = document.form.fields[28] as PdfTextBoxField;
    monto2.text = obj.rc2Vcr.toStringAsFixed(2);
    final PdfTextBoxField monto1 = document.form.fields[29] as PdfTextBoxField;
    monto1.text = obj.rc1Vcr.toStringAsFixed(2);

    final PdfTextBoxField ciudadRef3 =
        document.form.fields[30] as PdfTextBoxField;
    ciudadRef3.text = obj.rc3Ciu;
    final PdfTextBoxField ciudadRef2 =
        document.form.fields[31] as PdfTextBoxField;
    ciudadRef2.text = obj.rc2Ciu;
    final PdfTextBoxField ciudadRef1 =
        document.form.fields[32] as PdfTextBoxField;
    ciudadRef1.text = obj.rc1Ciu;

    final PdfTextBoxField tlfRef2 = document.form.fields[33] as PdfTextBoxField;
    tlfRef2.text = obj.rc2Tlf;
    final PdfTextBoxField tlfRef1 = document.form.fields[34] as PdfTextBoxField;
    tlfRef1.text = obj.rc1Tlf;

    final PdfTextBoxField detalle = document.form.fields[35] as PdfTextBoxField;
    detalle.text = "";

    final PdfTextBoxField negado = document.form.fields[36] as PdfTextBoxField;
    negado.text = obj.stsSdc == "R"
        ? "Rechazado"
        : obj.stsSdc == "A"
            ? "Aprobado"
            : "";

    final PdfTextBoxField maxCredit =
        document.form.fields[37] as PdfTextBoxField;
    maxCredit.text = "${obj.cupSdc}";

    final PdfTextBoxField comite = document.form.fields[38] as PdfTextBoxField;
    comite.text = "";

    final PdfTextBoxField aprobado =
        document.form.fields[39] as PdfTextBoxField;
    aprobado.text = obj.uapSdc;

    final PdfTextBoxField nacionalidad =
        document.form.fields[40] as PdfTextBoxField;
    nacionalidad.text = "Ecuador";

    final PdfTextBoxField vendedor =
        document.form.fields[41] as PdfTextBoxField;
    vendedor.text = obj.codRtc;

    final PdfTextBoxField codigoInterno =
        document.form.fields[42] as PdfTextBoxField;
    codigoInterno.text = "";

    final PdfTextBoxField codigo = document.form.fields[43] as PdfTextBoxField;
    codigo.text = obj.codRef;

    final PdfTextBoxField fecha = document.form.fields[45] as PdfTextBoxField;
    fecha.text = DateFormat('MMMM d, yyyy').format(DateTime.now());

    final PdfTextBoxField tlfRef3 = document.form.fields[44] as PdfTextBoxField;
    tlfRef3.text = obj.rc3Tlf;

    final PdfTextBoxField tipo = document.form.fields[46] as PdfTextBoxField;
    tipo.text = obj.clsRef == "1" ? "CREDITO" : "CONTADO";

    form.setDefaultAppearance(false);

    if (isFlatten) {
      form.flattenAllFields();
    }

    final List<int> bytes = await document.save();

    document.dispose();

    await FileSaveHelper.saveAndLaunchFile(
        bytes, isFlatten ? 'solicitudCredito.pdf' : 'Form.pdf');
  }

  Future<List<int>> _readData(String name) async {
    final ByteData data = await rootBundle.load('assets/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}
