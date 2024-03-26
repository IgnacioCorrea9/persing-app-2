// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

PublicacionesBySectorModel welcomeFromJson(String str) =>
    PublicacionesBySectorModel.fromJson(json.decode(str));

String welcomeToJson(PublicacionesBySectorModel data) =>
    json.encode(data.toJson());

class PublicacionesBySectorModel {
  PublicacionesBySectorModel({
    required this.success,
    required this.data,
  });

  bool success;
  List<PublicacionesBySectorData> data;

  factory PublicacionesBySectorModel.fromJson(Map<String, dynamic> json) =>
      PublicacionesBySectorModel(
        success: json["success"],
        data: List<PublicacionesBySectorData>.from(
            json["data"].map((x) => PublicacionesBySectorData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PublicacionesBySectorData {
  PublicacionesBySectorData(
      {required this.likes,
      required this.guardados,
      required this.comentarios,
      required this.alcanzados,
      required this.destacada,
      required this.id,
      required this.titulo,
      required this.link,
      required this.texto,
      required this.sector,
      required this.empresa,
      required this.video,
      required this.createdAt,
      required this.v,
      required this.foto,
      required this.liked,
      required this.saved});

  int likes;
  List<String> guardados;
  int comentarios;
  int alcanzados;
  bool destacada;
  String id;
  String titulo;
  String link;
  String texto;
  Sector sector;
  Empresa empresa;
  String video;
  DateTime createdAt;
  int v;
  String foto;
  bool liked;
  bool saved;

  factory PublicacionesBySectorData.fromJson(Map<String, dynamic> json) =>
      PublicacionesBySectorData(
        likes: json["likes"],
        guardados: json["guardados"] != null ? List<String>.from(json["guardados"].map((x) => x != null ? x : "")) : [],
        comentarios: json["comentarios"],
        alcanzados: json["alcanzados"],
        destacada: json["destacada"],
        id: json["_id"],
        titulo: json["titulo"],
        link: json["link"] == null ? "" : json["link"],
        texto: json["texto"],
        sector: Sector.fromJson(json["sector"]),
        empresa: Empresa.fromJson(json["empresa"]),
        video: json["video"] == null ? "" : json["video"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        liked: json["liked"],
        saved: json["saved"],
        foto: json["foto"] == null ? "" : json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "likes": likes,
        "guardados": List<dynamic>.from(guardados.map((x) => x)),
        "comentarios": comentarios,
        "alcanzados": alcanzados,
        "destacada": destacada,
        "_id": id,
        "titulo": titulo,
        "link": link == null ? null : link,
        "texto": texto,
        "sector": sector.toJson(),
        "empresa": empresa.toJson(),
        "video": video == null ? null : video,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
        "liked": liked,
        "saved": saved,
        "foto": foto == null ? null : foto,
      };
}

class Empresa {
  Empresa({
    required this.sectores,
    required this.estado,
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.logo,
    required this.createdAt,
    required this.v,
    required this.nit,
    required this.aprobado,
  });

  List<String> sectores;
  String estado;
  String id;
  String nombre;
  String descripcion;
  String logo;
  DateTime createdAt;
  int v;
  String nit;
  bool aprobado;

  factory Empresa.fromJson(Map<String, dynamic> json) => Empresa(
        sectores:json["sectores"] != null ? List<String>.from(json["sectores"].map((x) => x != null ? x : "")): [],
        estado: json["estado"],
        id: json["_id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        logo: json["logo"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        nit: json["nit"] == null ? "" : json["nit"],
        aprobado: json["aprobado"] == null ? false : json["aprobado"],
      );

  Map<String, dynamic> toJson() => {
        "sectores": List<dynamic>.from(sectores.map((x) => x)),
        "estado": estado,
        "_id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "logo": logo,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
        "nit": nit == null ? null : nit,
        "aprobado": aprobado == null ? null : aprobado,
      };
}

class Sector {
  //
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
        icono: json["icono"] ?? "",
        id: json["_id"] ?? "",
        nombre: json["nombre"] ?? "",
        v: json["__v"] ?? 0,
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
