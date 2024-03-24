import 'dart:convert';

EnterprisesModel welcomeFromJson(String str) =>
    EnterprisesModel.fromJson(json.decode(str));

// String welcomeToJson(EnterprisesModel data) => json.encode(data.toJson());

class EnterprisesModel {
  EnterprisesModel({
    required this.success,
    required this.data,
  });

  bool success;
  List<DataEnterprises> data;

  factory EnterprisesModel.fromJson(Map<String, dynamic> json) =>
      EnterprisesModel(
        success: json["success"],
        data: List<DataEnterprises>.from(
            json["data"].map((x) => DataEnterprises.fromJson(x))),
      );

  // Map<String, dynamic> toJson() => {
  //       "success": success,
  //       "data": List<dynamic>.from(data.map((x) => x.toJson())),
  //     };
}

class DataEnterprises {
  DataEnterprises({
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

  List<Sectore> sectores;
  Estado estado;
  String id;
  String nombre;
  String nit;
  String logo;
  String descripcion;
  int v;
  bool aprobado;
  DateTime createdAt;

  factory DataEnterprises.fromJson(Map<String, dynamic> json) =>
      DataEnterprises(
        sectores: List<Sectore>.from(
            json["sectores"].map((x) => Sectore.fromJson(x))),
        estado: estadoValues.map![json["estado"]] ?? Estado.PENDIENTE,
        id: json["_id"],
        nombre: json["nombre"] == null ? "" : json["nombre"],
        nit: json["nit"] == null ? "" : json["nit"],
        logo: json["logo"] == null ? "" : json["logo"],
        descripcion: json["descripcion"] == null ? "" : json["descripcion"],
        v: json["__v"],
        aprobado: json["aprobado"] == null ? false : json["aprobado"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "sectores": List<dynamic>.from(sectores.map((x) => x.toJson())),
  //       "estado": estadoValues.reverse[estado],
  //       "_id": id,
  //       "nombre": nombre == null ? null : nombre,
  //       "nit": nit == null ? null : nit,
  //       "logo": logo == null ? null : logo,
  //       "descripcion": descripcion == null ? null : descripcion,
  //       "__v": v,
  //       "aprobado": aprobado == null ? null : aprobado,
  //       "createdAt": createdAt.toIso8601String(),
  //     };
}

enum Estado { APROBADO, RECHAZADO, PENDIENTE }

final estadoValues = EnumValues({
  "aprobado": Estado.APROBADO,
  "pendiente": Estado.PENDIENTE,
  "rechazado": Estado.RECHAZADO
});

class Sectore {
  Sectore({
    required this.descripcion,
    required this.id,
    required this.icono,
    required this.nombre,
    required this.v,
    required this.createdAt,
  });

  List<Descripcion> descripcion;
  Id id;
  String icono;
  Nombre nombre;
  int v;
  DateTime createdAt;

  factory Sectore.fromJson(Map<String, dynamic> json) => Sectore(
        descripcion: List<Descripcion>.from(
            json["descripcion"].map((x) => descripcionValues.map![x])),
        id: idValues.map![json["_id"] ?? ""] ??
            Id.THE_602_A7_D62762_EFC2080_F88_CC7,
        icono: json["icono"],
        nombre: nombreValues.map![json["nombre"]] ?? Nombre.ALIMENTACIN,
        v: json["__v"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "descripcion": List<dynamic>.from(
            descripcion.map((x) => descripcionValues.reverse[x])),
        "_id": idValues.reverse[id],
        "icono": icono,
        "nombre": nombreValues.reverse[nombre],
        "__v": v,
        "createdAt": createdAt.toIso8601String(),
      };
}

enum Descripcion {
  SECTOR_DE_ARTCULOS_DE_ENTRETENIMIENTO,
  SECTOR_DE_PRODUCTOS_PARA_EL_USO_PERSONAL,
  SECTOR_ALIMENTICIO,
  SECTOR_DE_PRODUCTOS_PARA_EL_HOGAR,
  SECTOR_DE_PRODUCTOS_RELACIONADOS_A_LA_EDUCACIN
}

final descripcionValues = EnumValues({
  "Sector alimenticio": Descripcion.SECTOR_ALIMENTICIO,
  "Sector de artículos de entretenimiento":
      Descripcion.SECTOR_DE_ARTCULOS_DE_ENTRETENIMIENTO,
  "Sector de productos para el hogar":
      Descripcion.SECTOR_DE_PRODUCTOS_PARA_EL_HOGAR,
  "Sector de productos para el uso personal":
      Descripcion.SECTOR_DE_PRODUCTOS_PARA_EL_USO_PERSONAL,
  "Sector de productos relacionados a la educación":
      Descripcion.SECTOR_DE_PRODUCTOS_RELACIONADOS_A_LA_EDUCACIN
});

enum Id {
  THE_602_A80_F8762_EFC2080_F88_CCC,
  THE_602_A80_B7762_EFC2080_F88_CC9,
  THE_602_A7_D62762_EFC2080_F88_CC7,
  THE_602_A80_A6762_EFC2080_F88_CC8,
  THE_602_A80_E7762_EFC2080_F88_CCB
}

final idValues = EnumValues({
  "602a7d62762efc2080f88cc7": Id.THE_602_A7_D62762_EFC2080_F88_CC7,
  "602a80a6762efc2080f88cc8": Id.THE_602_A80_A6762_EFC2080_F88_CC8,
  "602a80b7762efc2080f88cc9": Id.THE_602_A80_B7762_EFC2080_F88_CC9,
  "602a80e7762efc2080f88ccb": Id.THE_602_A80_E7762_EFC2080_F88_CCB,
  "602a80f8762efc2080f88ccc": Id.THE_602_A80_F8762_EFC2080_F88_CCC
});

enum Nombre {
  ENTRETENIMIENTO,
  CUIDADO_PERSONAL,
  ALIMENTACIN,
  CUIDADO_DEL_HOGAR,
  EDUCACIN
}

final nombreValues = EnumValues({
  "Alimentación": Nombre.ALIMENTACIN,
  "Cuidado del hogar": Nombre.CUIDADO_DEL_HOGAR,
  "Cuidado personal": Nombre.CUIDADO_PERSONAL,
  "Educación": Nombre.EDUCACIN,
  "Entretenimiento": Nombre.ENTRETENIMIENTO
});

class EnumValues<T> {
  late Map<String, T>? map;
  late Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
