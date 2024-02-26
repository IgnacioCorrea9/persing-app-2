// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

PublicacionesDestacadasModel welcomeFromJson(String str) =>
    PublicacionesDestacadasModel.fromJson(json.decode(str));

String welcomeToJson(PublicacionesDestacadasModel data) =>
    json.encode(data.toJson());

class PublicacionesDestacadasModel {
  PublicacionesDestacadasModel({
    required this.success,
    required this.data,
  });

  bool success;
  List<PublicacionesDestacadasData> data;

  factory PublicacionesDestacadasModel.fromJson(Map<String, dynamic> json) =>
      PublicacionesDestacadasModel(
        success: json["success"],
        data: List<PublicacionesDestacadasData>.from(
            json["data"].map((x) => PublicacionesDestacadasData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PublicacionesDestacadasData {
  PublicacionesDestacadasData({
    required this.likes,
    required this.comentarios,
    required this.alcanzados,
    required this.id,
    required this.titulo,
    required this.seccion,
    required this.texto,
    required this.foto,
    required this.createdAt,
    required this.v,
    required this.video,
  });

  List<dynamic> likes;
  int comentarios;
  int alcanzados;
  String id;
  String titulo;
  Sector seccion;
  String texto;
  String foto;
  String video;
  DateTime createdAt;
  int v;

  factory PublicacionesDestacadasData.fromJson(Map<String, dynamic> json) =>
      PublicacionesDestacadasData(
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        comentarios: json["comentarios"],
        alcanzados: json["alcanzados"],
        id: json["_id"],
        titulo: json["titulo"],
        seccion: Sector.fromJson(json["seccion"]),
        texto: json["texto"],
        foto: json["foto"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        video: json["video"] == null ? null : json["video"],
      );

  Map<String, dynamic> toJson() => {
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "comentarios": comentarios,
        "alcanzados": alcanzados,
        "_id": id,
        "titulo": titulo,
        "seccion": seccion.toJson(),
        "texto": texto,
        "foto": foto,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
        "video": video == null ? null : video,
      };
}

class Sector {
  Sector({
    required this.icono,
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.createdAt,
    required this.v,
  });

  String icono;
  String id;
  String nombre;
  String descripcion;
  DateTime createdAt;
  int v;

  factory Sector.fromJson(Map<String, dynamic> json) => Sector(
        icono: json["icono"],
        id: json["_id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "icono": icono,
        "_id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}
