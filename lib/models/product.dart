import 'dart:convert';

class Product {
  Product({
    this.producto = "",
    this.grupo = "",
    this.marca = "",
  });

  String producto;
  String grupo;
  String marca;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        producto: json["producto"],
        grupo: json["grupo"],
        marca: json["marca"],
      );

  Map<String, dynamic> toMap() => {
        "producto": producto,
        "grupo": grupo,
        "marca": marca,
      };
}
