// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

PublicacionesSavedModel welcomeFromJson(String str) =>
    PublicacionesSavedModel.fromJson(json.decode(str));

String welcomeToJson(PublicacionesSavedModel data) =>
    json.encode(data.toJson());

class PublicacionesSavedModel {
  PublicacionesSavedModel({
    required this.success,
    required this.data,
  });

  bool success;
  List<PublicacionesSavedData> data;

  factory PublicacionesSavedModel.fromJson(Map<String, dynamic> json) =>
      PublicacionesSavedModel(
        success: json["success"],
        data: List<PublicacionesSavedData>.from(
            json["data"].map((x) => PublicacionesSavedData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PublicacionesSavedData {
  PublicacionesSavedData({
    required this.likes,
    required this.guardados,
    required this.comentarios,
    required this.alcanzados,
    required this.destacada,
    required this.id,
    required this.empresa,
    required this.sector,
    required this.titulo,
    required this.texto,
    required this.foto,
    required this.createdAt,
    required this.v,
    required this.liked,
    required this.saved,
    required this.link,
    required this.video,
  });

  int likes;
  List<String> guardados;
  int comentarios;
  int alcanzados;
  bool destacada;
  String id;
  Empresa empresa;
  Sector sector;
  String titulo;
  String texto;
  String foto;
  DateTime createdAt;
  int v;
  bool liked;
  bool saved;
  String link;
  String video;

  factory PublicacionesSavedData.fromJson(Map<String, dynamic> json) =>
      PublicacionesSavedData(
        likes: json["likes"],
        guardados: List<String>.from(json["guardados"].map((x) => x)),
        comentarios: json["comentarios"],
        alcanzados: json["alcanzados"],
        destacada: json["destacada"],
        id: json["_id"],
        empresa: Empresa.fromJson(json["empresa"]),
        sector: Sector.fromJson(json["sector"]),
        titulo: json["titulo"],
        texto: json["texto"],
        foto: json["foto"] == null ? null : json["foto"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        liked: json["liked"],
        saved: json["saved"],
        link: json["link"] == null ? null : json["link"],
        video: json["video"] == null ? null : json["video"],
      );

  Map<String, dynamic> toJson() => {
        "likes": likes,
        "guardados": List<dynamic>.from(guardados.map((x) => x)),
        "comentarios": comentarios,
        "alcanzados": alcanzados,
        "destacada": destacada,
        "_id": id,
        "empresa": empresa.toJson(),
        "sector": sector.toJson(),
        "titulo": titulo,
        "texto": texto,
        "foto": foto == null ? null : foto,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
        "liked": liked,
        "saved": saved,
        "link": link == null ? null : link,
        "video": video == null ? null : video,
      };
}

class Empresa {
  Empresa({
    required this.sectores,
    required this.estado,
    required this.id,
    required this.nombre,
    required this.nit,
    required this.logo,
    required this.descripcion,
    required this.v,
    required this.aprobado,
    required this.createdAt,
  });

  List<String> sectores;
  String estado;
  String id;
  String nombre;
  String nit;
  String logo;
  String descripcion;
  int v;
  bool aprobado;
  DateTime createdAt;

  factory Empresa.fromJson(Map<String, dynamic> json) => Empresa(
        sectores: List<String>.from(json["sectores"].map((x) => x)),
        estado: json["estado"],
        id: json["_id"],
        nombre: json["nombre"],
        nit: json["nit"] == null ? null : json["nit"],
        logo: json["logo"],
        descripcion: json["descripcion"],
        v: json["__v"],
        aprobado: json["aprobado"] == null ? null : json["aprobado"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "sectores": List<dynamic>.from(sectores.map((x) => x)),
        "estado": estado,
        "_id": id,
        "nombre": nombre,
        "nit": nit == null ? null : nit,
        "logo": logo,
        "descripcion": descripcion,
        "__v": v,
        "aprobado": aprobado == null ? null : aprobado,
        "createdAt": createdAt.toIso8601String(),
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
