class Archivo {
  String name;
  String arrayBs64;
  String sufijo;
  String? descp;
  String requerido;
  bool estado;
  bool hide;

  Archivo(
      {required this.name,
      required this.requerido,
      required this.arrayBs64,
      required this.estado,
      required this.hide,
      required this.sufijo,
      this.descp = "sin descripción"});

  String get getName => name;

  set setName(String name) {
    name = name;
  }

  String get getArrayBs64 => arrayBs64;

  set setArrayBs64(String arrayBs64) {
    arrayBs64 = arrayBs64;
  }

  String get getSufijo => sufijo;

  set setSufijo(String sufijo) {
    sufijo = sufijo;
  }

  @override
  String toString() {
    return name + " -- " + sufijo;
  }
}
