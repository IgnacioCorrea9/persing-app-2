// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

FeaturedModel welcomeFromJson(String str) =>
    FeaturedModel.fromJson(json.decode(str));

String welcomeToJson(FeaturedModel data) => json.encode(data.toJson());

class FeaturedModel {
  FeaturedModel({
    required this.data,
    required this.success,
  });

  List<FeaturedModelData> data;
  bool success;

  factory FeaturedModel.fromJson(Map<String, dynamic> json) => FeaturedModel(
        data: List<FeaturedModelData>.from(
            json["data"].map((x) => FeaturedModelData.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "success": success,
      };
}

class FeaturedModelData {
  FeaturedModelData({
    required this.icono,
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.createdAt,
    required this.v,
  });

  String? icono;
  String? id;
  String nombre;
  String descripcion;
  DateTime? createdAt;
  int? v;

  factory FeaturedModelData.fromJson(Map<String, dynamic> json) =>
      FeaturedModelData(
        icono: json["icono"] == null ? null : json["icono"],
        id: json["_id"] == null ? null : json["_id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "icono": icono == null ? null : icono,
        "_id": id == null ? null : id,
        "nombre": nombre,
        "descripcion": descripcion,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "__v": v == null ? null : v,
      };
}
