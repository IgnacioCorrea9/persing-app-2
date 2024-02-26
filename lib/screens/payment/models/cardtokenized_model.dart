import 'dart:convert';

class CardTokenizedResponse {
  CardTokenizedResponse({
    required this.status,
    required this.data,
  });

  factory CardTokenizedResponse.fromJson(String str) =>
      CardTokenizedResponse.fromMap(json.decode(str) as Map<String, dynamic>);

  factory CardTokenizedResponse.fromMap(Map<String, dynamic> json) =>
      CardTokenizedResponse(
        status: json['status'].toString(),
        data: CardTokenizedInfo.fromMap(json['data'] as Map<String, dynamic>),
      );

  String status;
  CardTokenizedInfo data;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': data.toMap(),
      };
}

class CardTokenizedInfo {
  CardTokenizedInfo({
    required this.id,
    required this.createdAt,
    required this.brand,
    required this.name,
    required this.lastFour,
    required this.bin,
    required this.expYear,
    required this.expMonth,
    required this.cardHolder,
    required this.expiresAt,
  });

  factory CardTokenizedInfo.fromJson(String str) =>
      CardTokenizedInfo.fromMap(json.decode(str) as Map<String, dynamic>);

  factory CardTokenizedInfo.fromMap(Map<String, dynamic> json) =>
      CardTokenizedInfo(
        id: json['id'].toString(),
        createdAt: DateTime.parse(json['created_at'].toString()),
        brand: json['brand'].toString(),
        name: json['name'].toString(),
        lastFour: json['last_four'].toString(),
        bin: json['bin'].toString(),
        expYear: json['exp_year'].toString(),
        expMonth: json['exp_month'].toString(),
        cardHolder: json['card_holder'].toString(),
        expiresAt: DateTime.parse(json['expires_at'].toString()),
      );

  String id;
  DateTime createdAt;
  String brand;
  String name;
  String lastFour;
  String bin;
  String expYear;
  String expMonth;
  String cardHolder;
  DateTime expiresAt;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'id': id,
        'created_at': createdAt.toIso8601String(),
        'brand': brand,
        'name': name,
        'last_four': lastFour,
        'bin': bin,
        'exp_year': expYear,
        'exp_month': expMonth,
        'card_holder': cardHolder,
        'expires_at': expiresAt.toIso8601String(),
      };
}
