// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:persing/models/know_more/know_more_discounts_model.dart';

SectorByIdModel welcomeFromJson(String str) =>
    SectorByIdModel.fromJson(json.decode(str));

String welcomeToJson(SectorByIdModel data) => json.encode(data.toJson());

class SectorByIdModel {
  SectorByIdModel({
    required this.success,
    required this.data,
  });

  bool success;
  List<SectorByIdData> data;

  factory SectorByIdModel.fromJson(Map<String, dynamic> json) =>
      SectorByIdModel(
        success: json["success"],
        data: List<SectorByIdData>.from(
            json["data"].map((x) => SectorByIdData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SectorByIdData {
  SectorByIdData({
    required this.compras,
    required this.id,
    required this.titulo,
    required this.sector,
    required this.precio,
    required this.descripcion,
    required this.foto,
    required this.createdAt,
    required this.v,
  });

  int compras;
  String id;
  String titulo;
  Sector sector;
  int precio;
  String descripcion;
  String foto;
  DateTime createdAt;
  int v;

  factory SectorByIdData.fromJson(Map<String, dynamic> json) => SectorByIdData(
        compras: json["compras"],
        id: json["_id"],
        titulo: json["titulo"],
        sector: Sector.fromJson(json["sector"]),
        precio: (json["precio"] is double)
            ? json["precio"].toInt()
            : json["precio"],
        descripcion: json["descripcion"],
        foto: json["foto"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "compras": compras,
        "_id": id,
        "titulo": titulo,
        "sector": sector.toJson(),
        "precio": precio,
        "descripcion": descripcion,
        "foto": foto,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
  KnowMoreDiscountsModelData buildDetailModel() {
    return KnowMoreDiscountsModelData(
      descripcion: descripcion,
      precio: precio,
      foto: foto,
      id: id,
      sector: sector,
      createdAt: createdAt,
      precioDescuento: precio,
      titulo: titulo,
      compras: compras,
      v: v,
      cantidad: 0,
      descuento: false,
    );
  }
}
