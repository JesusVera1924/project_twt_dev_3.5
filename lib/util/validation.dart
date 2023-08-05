class Validation {
  String numeros = r'^(?:\+|-)?\d+$';
  String fecha =
      r'^(0?[1-9]|[12][0-9]|3[01])[\/](0?[1-9]|1[012])[/\\/](19|20)\d{2}$';
  String decimal = r'^(\d+)?\.?\d{0,3}';
  String letras = r'(^[a-zA-Z ]*$)';
  String alfanumerico = r'(^[a-zA-Z 0-9.-]*$)';
  String correo = r'(^[a-zA-Z0-9-_@. ]*$)';
  List<String> listError = [];

  String? checkCedula(String value) {
    if (value.length == 10) {
      int _regionDigito = int.parse(value.substring(0, 2));
      if (_regionDigito >= 1 && _regionDigito <= 24) {
        var _ultimoDigito = value.substring(9, 10);
        var pares = int.parse(value.substring(1, 2)) +
            int.parse(value.substring(3, 4)) +
            int.parse(value.substring(5, 6)) +
            int.parse(value.substring(7, 8));

        int numero1 = int.parse(value.substring(0, 1));
        numero1 = (numero1 * 2);
        if (numero1 > 9) {
          numero1 = (numero1 - 9);
        }

        int numero3 = int.parse(value.substring(2, 3));
        numero3 = (numero3 * 2);
        if (numero3 > 9) {
          numero3 = (numero3 - 9);
        }

        int numero5 = int.parse(value.substring(4, 5));
        numero5 = (numero5 * 2);
        if (numero5 > 9) {
          numero5 = (numero5 - 9);
        }

        int numero7 = int.parse(value.substring(6, 7));
        numero7 = (numero7 * 2);
        if (numero7 > 9) {
          numero7 = (numero7 - 9);
        }

        int numero9 = int.parse(value.substring(8, 9));
        numero9 = (numero9 * 2);
        if (numero9 > 9) {
          numero9 = (numero9 - 9);
        }

        var impares = numero1 + numero3 + numero5 + numero7 + numero9;
        String _sumaTotal = "${pares + impares}";
        var _primeDigito = _sumaTotal.substring(0, 1);
        var decena = (int.parse(_primeDigito) + 1) * 10;
        var _digitoValidador = decena - int.parse(_sumaTotal);
        if (_digitoValidador == 10) _digitoValidador = 0;
        if (_digitoValidador == int.parse(_ultimoDigito)) {
          return null;
        } else {
          return 'La cedula: $value es incorrecta';
        }
      } else {
        return 'Esta cedula no pertenece a ninguna region';
      }
    } else {
      return 'Esta cedula tiene menos de 10 Digitos';
    }
  }

  String? checkRuc(String value) {
    var number = value;
    var dto = number.length;
    int valor;
    var acu = 0;
    if (number == "") {
      return 'No has ingresado ningún dato, porfavor ingresar los datos correspondientes.';
    } else {
      for (var i = 0; i < dto; i++) {
        valor = int.parse(number.substring(i, i + 1));
        if (valor == 0 ||
            valor == 1 ||
            valor == 2 ||
            valor == 3 ||
            valor == 4 ||
            valor == 5 ||
            valor == 6 ||
            valor == 7 ||
            valor == 8 ||
            valor == 9) {
          acu = acu + 1;
        }
      }
      if (acu == dto) {
        while (int.parse(number.substring(10, 13)) != 001) {
          /*  print('Los tres últimos dígitos no tienen el código del RUC 001.'); */
          return 'RUC incorrecto';
        }
        while (int.parse(number.substring(0, 2)) > 24) {
          /*  print('Los dos primeros dígitos no pueden ser mayores a 24.'); */
          return 'RUC incorrecto';
        }
        /*   print('El RUC está escrito correctamente');
        print('Se procederá a analizar el respectivo RUC.'); */
        int porcion1 = int.parse(number.substring(2, 3));
        if (porcion1 < 6) {
          /*  print(
              'El tercer dígito es menor a 6, por lo \ntanto el usuario es una persona natural.\n'); */
          // return 'Ruc: Persona Natural';
          return null;
        } else {
          if (porcion1 == 6) {
            /*  print(
                'El tercer dígito es igual a 6, por lo \ntanto el usuario es una entidad pública.\n'); */
            // return 'Ruc: Entidad Publica';
            return null;
          } else {
            if (porcion1 == 9) {
              /*  print(
                  'El tercer dígito es igual a 9, por lo \ntanto el usuario es una sociedad privada.\n'); */
              // return 'Ruc Persona Juridica';
              return null;
            }
          }
        }
      } else {
        /* print("ERROR: Por favor no ingrese texto"); */
        return "ERROR: Por favor no ingrese texto";
      }
      return '';
    }
  }

  String dniCodigo(String selectedItem) {
    var map = {"Cedula": "1", "Ruc": "2"};
    return map[selectedItem] ?? "3";
  }

  String? identifyRuc(String value) {
    var number = value;
    var dto = number.length;
    int valor;
    var acu = 0;
    if (number == "") {
      //No has ingresado ningún dato,
      return '0';
    } else {
      for (var i = 0; i < dto; i++) {
        valor = int.parse(number.substring(i, i + 1));
        if (valor == 0 ||
            valor == 1 ||
            valor == 2 ||
            valor == 3 ||
            valor == 4 ||
            valor == 5 ||
            valor == 6 ||
            valor == 7 ||
            valor == 8 ||
            valor == 9) {
          acu = acu + 1;
        }
      }
      if (acu == dto) {
        while (int.parse(number.substring(10, 13)) != 001) {
          /*Los tres últimos dígitos no tienen el código del RUC 001.*/
          return '0';
        }
        while (int.parse(number.substring(0, 2)) > 24) {
          /*Los dos primeros dígitos no pueden ser mayores a 24*/
          return '0';
        }
        /*El RUC está escrito correctamente, Se procederá a analizar el respectivo RUC. */
        int porcion1 = int.parse(number.substring(2, 3));
        if (porcion1 < 6) {
          /* El tercer dígito es menor a 6, por lo \ntanto el usuario es una persona natural */
          // return 'Ruc: Persona Natural';
          return "1";
        } else {
          if (porcion1 == 6) {
            /* El tercer dígito es igual a 6, por lo \ntanto el usuario es una entidad pública. */
            // return 'Ruc: Entidad Publica';
            return "2";
          } else {
            if (porcion1 == 9) {
              /* El tercer dígito es igual a 9, por lo \ntanto el usuario es una sociedad privada. */
              // return 'Ruc Persona Juridica';
              return "2";
            }
          }
        }
      } else {
        /* ERROR: Por favor no a ingrese texto */
        return "0";
      }
      return '0';
    }
  }

  String lastvalueNumber(String numero, int log) {
    int fix = numero.length; //tamaño del numero
    String resp = ""; // nuevo String a devolver
    String nuevo = "${int.parse(numero) + 1}";
    if (fix <= log) {
      resp = nuevo.padLeft(log, '0');
    }
    return resp;
  }

  String upperVersion(String version) {
    double val = double.parse(version);
    val = val + 0.5;
    return "$val";
  }

  String getEstadoCivil(String id) {
    var map = {
      "S": "Soltero",
      "C": "Casado",
      "U": "Union libre",
      "D": "Divorciado",
      "v": "Viudo"
    };

    return map[id] ?? "N/A";
  }

  String relleno(String numero, int log) {
    int fix = numero.length;
    String resp = "";
    if (fix <= log) {
      resp = numero.padLeft(log, '0');
    }
    return resp;
  }
}
