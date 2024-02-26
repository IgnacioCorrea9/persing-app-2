// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

FeaturedSectionModel welcomeFromJson(String str) =>
    FeaturedSectionModel.fromJson(json.decode(str));

String welcomeToJson(FeaturedSectionModel data) => json.encode(data.toJson());

class FeaturedSectionModel {
  FeaturedSectionModel({
    required this.success,
    required this.data,
  });

  bool success;
  List<FeaturedSectionModelData> data;

  factory FeaturedSectionModel.fromJson(Map<String, dynamic> json) =>
      FeaturedSectionModel(
        success: json["success"],
        data: List<FeaturedSectionModelData>.from(
            json["data"].map((x) => FeaturedSectionModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FeaturedSectionModelData {
  FeaturedSectionModelData({
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
    required this.liked,
    required this.video,
  });

  int likes;
  int comentarios;
  int alcanzados;
  String id;
  String titulo;
  Seccion seccion;
  String texto;
  String? foto;
  DateTime createdAt;
  int v;
  bool liked;
  String? video;

  factory FeaturedSectionModelData.fromJson(Map<String, dynamic> json) =>
      FeaturedSectionModelData(
        likes: json["likes"],
        comentarios: json["comentarios"],
        alcanzados: json["alcanzados"],
        id: json["_id"],
        titulo: json["titulo"],
        seccion: Seccion.fromJson(json["seccion"]),
        texto: json["texto"],
        foto: json["foto"] == null ? null : json["foto"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        liked: json["liked"],
        video: json["video"] == null ? null : json["video"],
      );

  Map<String, dynamic> toJson() => {
        "likes": likes,
        "comentarios": comentarios,
        "alcanzados": alcanzados,
        "_id": id,
        "titulo": titulo,
        "video": video == null ? null : video,
        "seccion": seccion.toJson(),
        "texto": texto,
        "foto": foto == null ? null : foto,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
        "liked": liked,
      };
}

class Seccion {
  Seccion({
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

  factory Seccion.fromJson(Map<String, dynamic> json) => Seccion(
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
