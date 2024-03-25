// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ProfileDataModel welcomeFromJson(String str) =>
    ProfileDataModel.fromJson(json.decode(str));

String welcomeToJson(ProfileDataModel data) => json.encode(data.toJson());

class ProfileDataModel {
  ProfileDataModel({
    required this.data,
  });

  Data data;

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) =>
      ProfileDataModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  List<String> intereses;
  String id;
  String nombre;
  String apellido;
  String email;
  String tipo;
  int creditos;
  DateTime createdAt;
  int calificacionApp;
  int cantidadHijos;
  String genero;
  int estrato;
  String nivelEducativo;
  bool mascotas;
  bool hijos;
  int cantidadMascotas;
  String estadoCivil;
  int v;
  Data({
    required this.intereses,
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.tipo,
    required this.creditos,
    required this.createdAt,
    required this.calificacionApp,
    required this.cantidadHijos,
    required this.genero,
    required this.estrato,
    required this.nivelEducativo,
    required this.mascotas,
    required this.hijos,
    required this.cantidadMascotas,
    required this.estadoCivil,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
<<<<<<< HEAD
        intereses: json["intereses"] != null
            ? List<String>.from(json["intereses"].map((x) => x))
            : [],
        id: json["_id"],
        nombre: json["nombre"] ?? "",
        apellido: json["apellido"] ?? "",
        email: json["email"],
        tipo: json["tipo"] ?? "",
        creditos: json["creditos"] ?? 0,
        createdAt: DateTime.parse(json["createdAt"]),
        calificacionApp: json["calificacionApp"] ?? 0,
        cantidadHijos: json["cantidadHijos"] ?? 0,
        genero: json["genero"] ?? "",
        estrato: json["estrato"] ?? 0,
        nivelEducativo: json["nivelEducativo"] ?? "",
        mascotas: json["mascotas"] ?? false,
        hijos: json["hijos"] ?? false,
        cantidadMascotas: json["cantidadMascotas"] ?? 0,
        estadoCivil: json["estadoCivil"] ?? "",
        v: json["__v"] ?? 0,
=======
        intereses: List<String>.from(json["intereses"].map((x) => x)),
        id: json["_id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        email: json["email"],
        tipo: json["tipo"],
        creditos: json["creditos"],
        createdAt: DateTime.parse(json["createdAt"]),
        calificacionApp: json["calificacionApp"],
        cantidadHijos: json["cantidadHijos"],
        genero: json["genero"],
        estrato: json["estrato"],
        nivelEducativo: json["nivelEducativo"],
        mascotas: json["mascotas"],
        hijos: json["hijos"],
        cantidadMascotas: json["cantidadMascotas"],
        estadoCivil: json["estadoCivil"],
        v: json["__v"],
>>>>>>> main
      );

  Map<String, dynamic> toJson() => {
        "intereses": List<dynamic>.from(intereses.map((x) => x)),
        "_id": id,
        "nombre": nombre,
        "apellido": apellido,
        "email": email,
        "tipo": tipo,
        "creditos": creditos,
        "createdAt": createdAt.toIso8601String(),
        "calificacionApp": calificacionApp,
        "genero": genero,
        "estrato": estrato,
        "nivelEducativo": nivelEducativo,
        "mascotas": mascotas,
        "hijos": hijos,
        "cantidadHijos": cantidadHijos,
        "cantidadMascotas": cantidadMascotas,
        "estadoCivil": estadoCivil,
        "__v": v,
      };
}
