// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

KnowMoreDiscountsModel welcomeFromJson(String str) =>
    KnowMoreDiscountsModel.fromJson(json.decode(str));

String welcomeToJson(KnowMoreDiscountsModel data) => json.encode(data.toJson());

class KnowMoreDiscountsModel {
  KnowMoreDiscountsModel({
    required this.success,
    required this.data,
  });

  bool success;
  List<KnowMoreDiscountsModelData> data;

  factory KnowMoreDiscountsModel.fromJson(Map<String, dynamic> json) =>
      KnowMoreDiscountsModel(
        success: json["success"],
        data: List<KnowMoreDiscountsModelData>.from(
            json["data"].map((x) => KnowMoreDiscountsModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class KnowMoreDiscountsModelData {
  KnowMoreDiscountsModelData({
    this.cantidad,
    required this.descuento,
    required this.compras,
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.sector,
    required this.precio,
    required this.precioDescuento,
    required this.foto,
    required this.createdAt,
    required this.v,
  });

  int? cantidad;
  bool descuento;
  int compras;
  String id;
  String titulo;
  String descripcion;
  Sector sector;
  int precio;
  int precioDescuento;
  String foto;
  DateTime createdAt;
  int v;

  factory KnowMoreDiscountsModelData.fromJson(Map<String, dynamic> json) =>
      KnowMoreDiscountsModelData(
          descuento: json["descuento"],
          compras: json["compras"],
          id: json["_id"],
          titulo: json["titulo"],
          descripcion: json["descripcion"],
          sector: Sector.fromJson(json["sector"]),
          precio: json["precio"],
          precioDescuento: json["precioDescuento"],
          foto: json["foto"],
          createdAt: DateTime.parse(json["createdAt"]),
          v: json["__v"],
          cantidad: json["cantidad"] != null ? json["cantidad"] : null);

  Map<String, dynamic> toJson() => {
        "descuento": descuento,
        "compras": compras,
        "_id": id,
        "titulo": titulo,
        "descripcion": descripcion,
        "sector": sector.toJson(),
        "precio": precio,
        "precioDescuento": precioDescuento,
        "foto": foto,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}

class Sector {
  Sector({
    required this.descripcion,
    required this.icono,
    required this.id,
    required this.nombre,
    required this.v,
    required this.createdAt,
  });

  List<String> descripcion;
  String icono;
  String id;
  String nombre;
  int v;
  DateTime createdAt;

  factory Sector.fromJson(Map<String, dynamic> json) => Sector(
        descripcion: List<String>.from(json["descripcion"].map((x) => x)),
        icono: json["icono"],
        id: json["_id"],
        nombre: json["nombre"],
        v: json["__v"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "descripcion": List<dynamic>.from(descripcion.map((x) => x)),
        "icono": icono,
        "_id": id,
        "nombre": nombre,
        "__v": v,
        "createdAt": createdAt.toIso8601String(),
      };
}
