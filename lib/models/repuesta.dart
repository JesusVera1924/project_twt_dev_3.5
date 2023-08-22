import 'dart:convert';

class Respuesta {
  int code;
  String msg;
  dynamic data;

  Respuesta({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory Respuesta.fromJson(String str) => Respuesta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Respuesta.fromMap(Map<String, dynamic> json) => Respuesta(
        code: json["code"],
        msg: json["msg"],
        data: json["data"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "msg": msg,
        "data": data.toMap(),
      };
}
