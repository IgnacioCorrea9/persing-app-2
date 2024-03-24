import 'dart:convert';

EnterprisesByIdModel welcomeFromJson(String str) =>
    EnterprisesByIdModel.fromJson(json.decode(str));

String welcomeToJson(EnterprisesByIdModel data) => json.encode(data.toJson());

class EnterprisesByIdModel {
  EnterprisesByIdModel({
    this.success,
    this.data,
  });

  bool? success;
  List<EnterprisesByIdModelData>? data;

  factory EnterprisesByIdModel.fromJson(Map<String, dynamic> json) =>
      EnterprisesByIdModel(
        success: json["success"],
        data: List<EnterprisesByIdModelData>.from(
            json["data"].map((x) => EnterprisesByIdModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class EnterprisesByIdModelData {
  EnterprisesByIdModelData({
    required this.likes,
    required this.guardados,
    required this.comentarios,
    required this.alcanzados,
    required this.destacada,
    required this.nueva,
    required this.id,
    this.link,
    required this.titulo,
    required this.sector,
    required this.texto,
    required this.empresa,
    this.foto,
    required this.createdAt,
    required this.v,
    required this.liked,
    required this.saved,
    this.video,
  });

  int likes;
  List<String> guardados;
  int comentarios;
  int alcanzados;
  bool destacada;
  bool nueva;
  String id;
  String? link;
  String titulo;
  Sector sector;
  String texto;
  Empresa empresa;
  String? foto;
  DateTime createdAt;
  int v;
  bool liked;
  bool saved;
  String? video;

  factory EnterprisesByIdModelData.fromJson(Map<String, dynamic> json) =>
      EnterprisesByIdModelData(
        likes: json["likes"],
        guardados: List<String>.from(json["guardados"].map((x) => x)),
        comentarios: json["comentarios"],
        alcanzados: json["alcanzados"],
        destacada: json["destacada"],
        nueva: json["nueva"],
        id: json["_id"],
        link: json["link"] == null ? null : json["link"],
        titulo: json["titulo"],
        sector: Sector.fromJson(json["sector"]),
        texto: json["texto"],
        empresa: Empresa.fromJson(json["empresa"]),
        foto: json["foto"] == null ? null : json["foto"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        liked: json["liked"],
        saved: json["saved"],
        video: json["video"] == null ? null : json["video"],
      );

  Map<String, dynamic> toJson() => {
        "likes": likes,
        "guardados": List<dynamic>.from(guardados.map((x) => x)),
        "comentarios": comentarios,
        "alcanzados": alcanzados,
        "destacada": destacada,
        "nueva": nueva,
        "_id": id,
        "link": link == null ? null : link,
        "titulo": titulo,
        "sector": sector.toJson(),
        "texto": texto,
        "empresa": empresa.toJson(),
        "foto": foto == null ? null : foto,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
        "liked": liked,
        "saved": saved,
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
        nit: json["nit"],
        logo: json["logo"],
        descripcion: json["descripcion"],
        v: json["__v"],
        aprobado: json["aprobado"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "sectores": List<dynamic>.from(sectores.map((x) => x)),
        "estado": estado,
        "_id": id,
        "nombre": nombre,
        "nit": nit,
        "logo": logo,
        "descripcion": descripcion,
        "__v": v,
        "aprobado": aprobado,
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
