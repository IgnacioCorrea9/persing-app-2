// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

RecompensaHomeModel welcomeFromJson(String str) =>
    RecompensaHomeModel.fromJson(json.decode(str));

String welcomeToJson(RecompensaHomeModel data) => json.encode(data.toJson());

class RecompensaHomeModel {
  RecompensaHomeModel({
    required this.data,
  });

  List<RecompensaHomeData> data;

  factory RecompensaHomeModel.fromJson(Map<String, dynamic> json) =>
      RecompensaHomeModel(
        data: List<RecompensaHomeData>.from(
            json["data"].map((x) => RecompensaHomeData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RecompensaHomeData {
  RecompensaHomeData({
    required this.ranking,
    required this.creditos,
    required this.id,
    required this.usuario,
    required this.sector,
    required this.v,
  });

  double ranking;
  int creditos;
  String id;
  Usuario usuario;
  Sector? sector;
  int v;

  factory RecompensaHomeData.fromJson(Map<String, dynamic> json) =>
      RecompensaHomeData(
        ranking: json["ranking"].toDouble(),
        creditos: json["creditos"],
        id: json["_id"],
        usuario: Usuario.fromJson(json["usuario"]),
        sector: json["sector"] == null ? null : Sector.fromJson(json["sector"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "ranking": ranking,
        "creditos": creditos,
        "_id": id,
        "usuario": usuario.toJson(),
        "sector": sector == null ? null : sector!.toJson(),
        "__v": v,
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

class Usuario {
  Usuario({
    required this.intereses,
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.password,
    required this.tipo,
    required this.creditos,
    required this.createdAt,
    required this.genero,
    required this.estrato,
    required this.nivelEducativo,
    required this.profesion,
    required this.v,
  });

  List<String> intereses;
  String id;
  String nombre;
  String apellido;
  String email;
  String password;
  String tipo;
  int creditos;
  DateTime createdAt;
  String genero;
  int estrato;
  String nivelEducativo;
  String profesion;
  int v;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        intereses: List<String>.from(json["intereses"].map((x) => x)),
        id: json["_id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        email: json["email"],
        password: json["password"],
        tipo: json["tipo"],
        creditos: json["creditos"],
        createdAt: DateTime.parse(json["createdAt"]),
        genero: json["genero"],
        estrato: json["estrato"],
        nivelEducativo: json["nivelEducativo"],
        profesion: json["profesion"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "intereses": List<dynamic>.from(intereses.map((x) => x)),
        "_id": id,
        "nombre": nombre,
        "apellido": apellido,
        "email": email,
        "password": password,
        "tipo": tipo,
        "creditos": creditos,
        "createdAt": createdAt.toIso8601String(),
        "genero": genero,
        "estrato": estrato,
        "nivelEducativo": nivelEducativo,
        "profesion": profesion,
        "__v": v,
      };
}
