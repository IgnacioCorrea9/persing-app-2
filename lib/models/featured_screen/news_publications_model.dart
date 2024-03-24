// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

NewsPublicationsModel welcomeFromJson(String str) =>
    NewsPublicationsModel.fromJson(json.decode(str));

String welcomeToJson(NewsPublicationsModel data) => json.encode(data.toJson());

class NewsPublicationsModel {
  NewsPublicationsModel({
    required this.success,
    required this.data,
  });

  bool success;
  List<NewsPublicationsModelData> data;

  factory NewsPublicationsModel.fromJson(Map<String, dynamic> json) =>
      NewsPublicationsModel(
        success: json["success"],
        data: List<NewsPublicationsModelData>.from(
            json["data"].map((x) => NewsPublicationsModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class NewsPublicationsModelData {
  NewsPublicationsModelData({
    required this.likes,
    required this.guardados,
    required this.comentarios,
    required this.alcanzados,
    required this.destacada,
    required this.nueva,
    required this.id,
    required this.titulo,
    required this.sector,
    required this.link,
    required this.texto,
    required this.empresa,
    required this.video,
    required this.createdAt,
    required this.v,
    required this.liked,
    required this.saved,
    required this.foto,
  });

  int likes;
  List<String> guardados;
  int comentarios;
  int alcanzados;
  bool destacada;
  bool nueva;
  String id;
  String titulo;
  Sector sector;
  String link;
  String texto;
  Empresa empresa;
  String video;
  DateTime createdAt;
  int v;
  bool liked;
  bool saved;
  String foto;

  factory NewsPublicationsModelData.fromJson(Map<String, dynamic> json) =>
      NewsPublicationsModelData(
        likes: json["likes"],
        guardados: List<String>.from(json["guardados"].map((x) => x)),
        comentarios: json["comentarios"],
        alcanzados: json["alcanzados"],
        destacada: json["destacada"],
        nueva: json["nueva"],
        id: json["_id"],
        titulo: json["titulo"],
        sector: Sector.fromJson(json["sector"]),
        link: json["link"],
        texto: json["texto"],
        empresa: Empresa.fromJson(json["empresa"]),
        video: json["video"] == null ? null : json["video"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        liked: json["liked"],
        saved: json["saved"],
        foto: json["foto"] == null ? null : json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "likes": likes,
        "guardados": List<dynamic>.from(guardados.map((x) => x)),
        "comentarios": comentarios,
        "alcanzados": alcanzados,
        "destacada": destacada,
        "nueva": nueva,
        "_id": id,
        "titulo": titulo,
        "sector": sector.toJson(),
        "link": link,
        "texto": texto,
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
        sectores: List<String>.from(json["sectores"].map((x) => x)),
        estado: json["estado"],
        id: json["_id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        logo: json["logo"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        nit: json["nit"] == null ? null : json["nit"],
        aprobado: json["aprobado"] == null ? null : json["aprobado"],
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
  Sector({
    required this.descripcion,
    required this.icono,
    required this.id,
    required this.nombre,
    required this.createdAt,
    required this.v,
  });

  List<String> descripcion;
  String icono;
  String id;
  String nombre;
  DateTime createdAt;
  int v;

  factory Sector.fromJson(Map<String, dynamic> json) => Sector(
        descripcion: List<String>.from(json["descripcion"].map((x) => x)),
        icono: json["icono"],
        id: json["_id"],
        nombre: json["nombre"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "descripcion": List<dynamic>.from(descripcion.map((x) => x)),
        "icono": icono,
        "_id": id,
        "nombre": nombre,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}
