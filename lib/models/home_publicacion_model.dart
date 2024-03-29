import 'dart:convert';

HomePublicacionesModel welcomeFromJson(String str) =>
    HomePublicacionesModel.fromJson(json.decode(str));

String welcomeToJson(HomePublicacionesModel data) => json.encode(data.toJson());

class HomePublicacionesModel {
  HomePublicacionesModel({
    required this.success,
    required this.data,
  });

  bool success;
  List<HomePublicacionesData> data;

  factory HomePublicacionesModel.fromJson(Map<String, dynamic> json) =>
      HomePublicacionesModel(
        success: json["success"],
        data: List<HomePublicacionesData>.from(
            json["data"].map((x) => HomePublicacionesData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class HomePublicacionesData {
  HomePublicacionesData({
    required this.firstSaved,
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
    required this.video,
    required this.link,
  });

  bool firstSaved;
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
  String video;
  String link;

  factory HomePublicacionesData.fromJson(Map<String, dynamic> json) =>
      HomePublicacionesData(
        firstSaved: json["firstSaved"] ?? false,
        likes: json["likes"] ?? 0,
        guardados: json["guardados"] != null
            ? List<String>.from(
                json["guardados"].map((x) => x != null ? x : ""))
            : [],
        comentarios: json["comentarios"] ?? 0,
        alcanzados: json["alcanzados"] ?? 0,
        destacada: json["destacada"] ?? false,
        id: json["_id"],
        empresa: Empresa.fromJson(json["empresa"]),
        sector: Sector.fromJson(json["sector"]),
        titulo: json["titulo"] ?? "",
        texto: json["texto"] ?? "",
        foto: json["foto"] == null ? "" : json["foto"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : DateTime.now(),
        v: json["__v"] ?? 0,
        liked: json["liked"] ?? false,
        saved: json["saved"] ?? false,
        video: json["video"] == null ? "" : json["video"], //
        link: json["link"] == null ? "" : json["link"],
      );

  Map<String, dynamic> toJson() => {
        "firstSaved": firstSaved,
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
        "video": video == null ? null : video,
        "link": link == null ? null : link,
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
        sectores: json["sectores"] != null
            ? List<String>.from(json["sectores"].map((x) => x != null ? x : ""))
            : [],
        estado: json["estado"] ?? "",
        id: json["_id"] ?? "",
        nombre: json["nombre"] ?? "",
        nit: json["nit"] == null ? "" : json["nit"],
        logo: json["logo"] ?? "",
        descripcion: json["descripcion"] ?? "",
        v: json["__v"] ?? 0,
        aprobado: json["aprobado"] == null ? false : json["aprobado"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "sectores": List<dynamic>.from(sectores.map((x) => x)),
        "estado": estadoValues.reverse[estado],
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

enum Estado { APROBADO }

final estadoValues = EnumValues({"aprobado": Estado.APROBADO});

enum Id {
  THE_602_A80_B7762_EFC2080_F88_CC9,
  THE_602_A7_D62762_EFC2080_F88_CC7,
  THE_602_A80_F8762_EFC2080_F88_CCC,
  THE_602_A80_A6762_EFC2080_F88_CC8
}

final idValues = EnumValues({
  "602a7d62762efc2080f88cc7": Id.THE_602_A7_D62762_EFC2080_F88_CC7,
  "602a80a6762efc2080f88cc8": Id.THE_602_A80_A6762_EFC2080_F88_CC8,
  "602a80b7762efc2080f88cc9": Id.THE_602_A80_B7762_EFC2080_F88_CC9,
  "602a80f8762efc2080f88ccc": Id.THE_602_A80_F8762_EFC2080_F88_CCC
});

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
        icono: json["icono"] ?? "",
        id: json["_id"] ?? "",
        nombre: json["nombre"] ?? "",
        v: json["__v"] ?? 0,
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "descripcion": List<dynamic>.from(descripcion.map((x) => x)),
        "icono": icono,
        "_id": idValues.reverse[id],
        "nombre": nombreValues.reverse[nombre],
        "__v": v,
        "createdAt": createdAt.toIso8601String(),
      };
}

enum Descripcion {
  SECTOR_DE_PRODUCTOS_PARA_EL_USO_PERSONAL,
  SECTOR_ALIMENTICIO,
  SECTOR_DE_ARTCULOS_DE_ENTRETENIMIENTO
}

final descripcionValues = EnumValues({
  "Sector alimenticio": Descripcion.SECTOR_ALIMENTICIO,
  "Sector de artículos de entretenimiento":
      Descripcion.SECTOR_DE_ARTCULOS_DE_ENTRETENIMIENTO,
  "Sector de productos para el uso personal":
      Descripcion.SECTOR_DE_PRODUCTOS_PARA_EL_USO_PERSONAL
});

enum Nombre { CUIDADO_PERSONAL, ALIMENTACIN, ENTRETENIMIENTO }

final nombreValues = EnumValues({
  "Alimentación": Nombre.ALIMENTACIN,
  "Cuidado personal": Nombre.CUIDADO_PERSONAL,
  "Entretenimiento": Nombre.ENTRETENIMIENTO
});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
