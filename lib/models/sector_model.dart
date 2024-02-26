// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

SectorModel welcomeFromJson(String str) =>
    SectorModel.fromJson(json.decode(str));

String welcomeToJson(SectorModel data) => json.encode(data.toJson());

class SectorModel {
  SectorModel({
    required this.data,
    required this.success,
  });

  List<SectorData> data;
  bool success;

  factory SectorModel.fromJson(Map<String, dynamic> json) => SectorModel(
        data: List<SectorData>.from(
            json["data"].map((x) => SectorData.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "success": success,
      };
}

class SectorData {
  SectorData({
    required this.icono,
    required this.descripcion,
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

  factory SectorData.fromJson(Map<String, dynamic> json) => SectorData(
        descripcion: List<String>.from(json["descripcion"].map((x) => x)),
        id: json["_id"],
        icono: json["icono"],
        nombre: json["nombre"],
        v: json["__v"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "descripcion": List<dynamic>.from(descripcion.map((x) => x)),
        "_id": id,
        "icono": icono,
        "nombre": nombre,
        "__v": v,
        "createdAt": createdAt.toIso8601String(),
      };
}
