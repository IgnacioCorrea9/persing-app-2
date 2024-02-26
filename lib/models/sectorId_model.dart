// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

SectorIdModel welcomeFromJson(String str) => SectorIdModel.fromJson(json.decode(str));

String welcomeToJson(SectorIdModel data) => json.encode(data.toJson());

class SectorIdModel {
    SectorIdModel({
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

    factory SectorIdModel.fromJson(Map<String, dynamic> json) => SectorIdModel(
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
