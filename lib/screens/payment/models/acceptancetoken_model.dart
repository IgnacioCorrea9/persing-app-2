import 'dart:convert';

class AcceptanceTokenResponse {
  AcceptanceTokenResponse({
    required this.data,
    required this.meta,
  });

  factory AcceptanceTokenResponse.fromJson(String str) =>
      AcceptanceTokenResponse.fromMap(json.decode(str) as Map<String, dynamic>);

  factory AcceptanceTokenResponse.fromMap(Map<String, dynamic> json) =>
      AcceptanceTokenResponse(
        data: Data.fromMap(json['data'] as Map<String, dynamic>),
        meta: Meta.fromMap(json['meta'] as Map<String, dynamic>),
      );

  Data data;
  Meta meta;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'data': data.toMap(),
        'meta': meta.toMap(),
      };
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.contactName,
    required this.phoneNumber,
    required this.active,
    required this.logoUrl,
    required this.legalName,
    required this.legalIdType,
    required this.legalId,
    required this.publicKey,
    required this.acceptedCurrencies,
    required this.fraudJavascriptKey,
    required this.acceptedPaymentMethods,
    required this.presignedAcceptance,
  });

  factory Data.fromJson(String str) =>
      Data.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: int.parse(json['id'].toString()),
        name: json['name'].toString(),
        email: json['email'].toString(),
        contactName: json['contact_name'].toString(),
        phoneNumber: json['phone_number'].toString(),
        active: json['active'] as bool,
        logoUrl: json['logo_url'].toString(),
        legalName: json['legal_name'].toString(),
        legalIdType: json['legal_id_type'].toString(),
        legalId: json['legal_id'].toString(),
        publicKey: json['public_key'].toString(),
        acceptedCurrencies: List<String>.from(
          json['accepted_currencies'].map((x) => x) as Iterable,
        ),
        fraudJavascriptKey: json['fraud_javascript_key'].toString(),
        acceptedPaymentMethods: List<String>.from(
          json['accepted_payment_methods'].map((x) => x) as Iterable,
        ),
        presignedAcceptance: PresignedAcceptance.fromMap(
          json['presigned_acceptance'] as Map<String, dynamic>,
        ),
      );

  int id;
  String name;
  String email;
  String contactName;
  String phoneNumber;
  bool active;
  dynamic logoUrl;
  String legalName;
  String legalIdType;
  String legalId;
  String publicKey;
  List<String> acceptedCurrencies;
  String fraudJavascriptKey;
  List<String> acceptedPaymentMethods;
  PresignedAcceptance presignedAcceptance;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'contact_name': contactName,
        'phone_number': phoneNumber,
        'active': active,
        'logo_url': logoUrl,
        'legal_name': legalName,
        'legal_id_type': legalIdType,
        'legal_id': legalId,
        'public_key': publicKey,
        'accepted_currencies':
            List<dynamic>.from(acceptedCurrencies.map((x) => x)),
        'fraud_javascript_key': fraudJavascriptKey,
        'accepted_payment_methods':
            List<dynamic>.from(acceptedPaymentMethods.map((x) => x)),
        'presigned_acceptance': presignedAcceptance.toMap(),
      };
}

class PresignedAcceptance {
  PresignedAcceptance({
    required this.acceptanceToken,
    required this.permalink,
    required this.type,
  });

  factory PresignedAcceptance.fromJson(String str) =>
      PresignedAcceptance.fromMap(json.decode(str) as Map<String, dynamic>);

  factory PresignedAcceptance.fromMap(Map<String, dynamic> json) =>
      PresignedAcceptance(
        acceptanceToken: json['acceptance_token'].toString(),
        permalink: json['permalink'].toString(),
        type: json['type'].toString(),
      );

  String acceptanceToken;
  String permalink;
  String type;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'acceptance_token': acceptanceToken,
        'permalink': permalink,
        'type': type,
      };
}

class Meta {
  Meta();

  factory Meta.fromJson(String str) =>
      Meta.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Meta.fromMap(Map<String, dynamic> json) => Meta();

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {};
}
