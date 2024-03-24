import 'dart:convert';

class TransactionResponse {
  TransactionResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory TransactionResponse.fromJson(String str) =>
      TransactionResponse.fromMap(json.decode(str) as Map<String, dynamic>);

  factory TransactionResponse.fromMap(Map<String, dynamic> json) =>
      TransactionResponse(
        success: json['success'] as bool,
        data: TransactionResponseData.fromMap(
          json['data'] as Map<String, dynamic>,
        ),
        message: json['message'].toString(),
      );

  bool success;
  TransactionResponseData data;
  String message;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'success': success,
        'data': data.toMap(),
        'message': message,
      };
}

class TransactionResponseData {
  TransactionResponseData({
    required this.data,
    required this.meta,
  });

  factory TransactionResponseData.fromJson(String str) =>
      TransactionResponseData.fromMap(json.decode(str) as Map<String, dynamic>);

  factory TransactionResponseData.fromMap(Map<String, dynamic> json) =>
      TransactionResponseData(
        data: TransactionBody.fromMap(json['data'] as Map<String, dynamic>),
        meta: MetaDos.fromMap(json['meta'] as Map<String, dynamic>),
      );

  TransactionBody data;
  MetaDos meta;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'data': data.toMap(),
        'meta': meta.toMap(),
      };
}

class TransactionBody {
  TransactionBody({
    required this.id,
    required this.createdAt,
    required this.amountInCents,
    required this.reference,
    required this.currency,
    required this.paymentMethodType,
    required this.paymentMethod,
    this.redirectUrl,
    required this.status,
    this.statusMessage,
    required this.merchant,
    required this.taxes,
  });

  factory TransactionBody.fromJson(String str) =>
      TransactionBody.fromMap(json.decode(str) as Map<String, dynamic>);

  factory TransactionBody.fromMap(Map<String, dynamic> json) => TransactionBody(
        id: json['id'].toString(),
        createdAt: DateTime.parse(json['created_at'].toString()),
        amountInCents: int.parse(json['amount_in_cents'].toString()),
        reference: json['reference'].toString(),
        currency: json['currency'].toString(),
        paymentMethodType: json['payment_method_type'].toString(),
        paymentMethod: PaymentMethodResponse.fromMap(
          json['payment_method'] as Map<String, dynamic>,
        ),
        redirectUrl: json['redirect_url'],
        status: json['status'].toString(),
        statusMessage: json['status_message'],
        merchant: Merchant.fromMap(json['merchant'] as Map<String, dynamic>),
        taxes: List<dynamic>.from(json['taxes'].map((x) => x) as Iterable),
      );
  String id;
  DateTime createdAt;
  int amountInCents;
  String reference;
  String currency;
  String paymentMethodType;
  PaymentMethodResponse paymentMethod;
  dynamic redirectUrl;
  String status;
  dynamic statusMessage;
  Merchant merchant;
  List<dynamic> taxes;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'id': id,
        'created_at': createdAt.toIso8601String(),
        'amount_in_cents': amountInCents,
        'reference': reference,
        'currency': currency,
        'payment_method_type': paymentMethodType,
        'payment_method': paymentMethod.toMap(),
        'redirect_url': redirectUrl,
        'status': status,
        'status_message': statusMessage,
        'merchant': merchant.toMap(),
        'taxes': List<dynamic>.from(taxes.map((x) => x)),
      };
}

class Merchant {
  Merchant({
    required this.name,
    required this.legalName,
    required this.contactName,
    required this.phoneNumber,
    this.logoUrl,
    required this.legalIdType,
    required this.email,
    required this.legalId,
  });

  factory Merchant.fromJson(String str) =>
      Merchant.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Merchant.fromMap(Map<String, dynamic> json) => Merchant(
        name: json['name'].toString(),
        legalName: json['legal_name'].toString(),
        contactName: json['contact_name'].toString(),
        phoneNumber: json['phone_number'].toString(),
        logoUrl: json['logo_url'],
        legalIdType: json['legal_id_type'].toString(),
        email: json['email'].toString(),
        legalId: json['legal_id'].toString(),
      );

  String name;
  String legalName;
  String contactName;
  String phoneNumber;
  dynamic logoUrl;
  String legalIdType;
  String email;
  String legalId;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'name': name,
        'legal_name': legalName,
        'contact_name': contactName,
        'phone_number': phoneNumber,
        'logo_url': logoUrl,
        'legal_id_type': legalIdType,
        'email': email,
        'legal_id': legalId,
      };
}

class PaymentMethodResponse {
  PaymentMethodResponse({
    required this.type,
    required this.extra,
    required this.installments,
  });

  factory PaymentMethodResponse.fromJson(String str) =>
      PaymentMethodResponse.fromMap(json.decode(str) as Map<String, dynamic>);

  factory PaymentMethodResponse.fromMap(Map<String, dynamic> json) =>
      PaymentMethodResponse(
        type: json['type'].toString(),
        extra: Extra.fromMap(json['extra'] as Map<String, dynamic>),
        installments: int.parse(json['installments'].toString()),
      );

  String type;
  Extra extra;
  int installments;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'type': type,
        'extra': extra.toMap(),
        'installments': installments,
      };
}

class Extra {
  Extra({
    required this.name,
    required this.brand,
    required this.lastFour,
    required this.externalIdentifier,
  });

  factory Extra.fromJson(String str) =>
      Extra.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Extra.fromMap(Map<String, dynamic> json) => Extra(
        name: json['name'].toString(),
        brand: json['brand'].toString(),
        lastFour: json['last_four'].toString(),
        externalIdentifier: json['external_identifier'].toString(),
      );

  String name;
  String brand;
  String lastFour;
  String externalIdentifier;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'name': name,
        'brand': brand,
        'last_four': lastFour,
        'external_identifier': externalIdentifier,
      };
}

class MetaDos {
  MetaDos();

  factory MetaDos.fromJson(String str) =>
      MetaDos.fromMap(json.decode(str) as Map<String, dynamic>);

  factory MetaDos.fromMap(Map<String, dynamic> json) => MetaDos();

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {};
}
