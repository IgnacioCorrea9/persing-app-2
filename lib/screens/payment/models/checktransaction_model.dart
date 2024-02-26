import 'dart:convert';

class CheckTransactionResponse {
  CheckTransactionResponse({
    required this.data,
    required this.meta,
  });

  factory CheckTransactionResponse.fromJson(String str) =>
      CheckTransactionResponse.fromMap(
        json.decode(str) as Map<String, dynamic>,
      );

  factory CheckTransactionResponse.fromMap(Map<String, dynamic> json) =>
      CheckTransactionResponse(
        data:
            CheckTransactionData.fromMap(json['data'] as Map<String, dynamic>),
        meta: CheckMeta.fromMap(json['meta'] as Map<String, dynamic>),
      );

  CheckTransactionData data;
  CheckMeta meta;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'data': data.toMap(),
        'meta': meta.toMap(),
      };
}

class CheckTransactionData {
  CheckTransactionData({
    required this.id,
    required this.createdAt,
    required this.amountInCents,
    required this.reference,
    required this.currency,
    required this.paymentMethodType,
    required this.paymentMethod,
    required this.redirectUrl,
    required this.status,
    required this.statusMessage,
    required this.merchant,
    required this.taxes,
  });
  factory CheckTransactionData.fromJson(String str) =>
      CheckTransactionData.fromMap(json.decode(str) as Map<String, dynamic>);

  factory CheckTransactionData.fromMap(Map<String, dynamic> json) =>
      CheckTransactionData(
        id: json['id'].toString(),
        createdAt: DateTime.parse(json['created_at'].toString()),
        amountInCents: int.parse(json['amount_in_cents'].toString()),
        reference: json['reference'].toString(),
        currency: json['currency'].toString(),
        paymentMethodType: json['payment_method_type'].toString(),
        paymentMethod: CheckPaymentMethod.fromMap(
          json['payment_method'] as Map<String, dynamic>,
        ),
        redirectUrl: json['redirect_url'],
        status: json['status'].toString(),
        statusMessage: json['status_message'],
        merchant:
            CheckMerchant.fromMap(json['merchant'] as Map<String, dynamic>),
        taxes: List<dynamic>.from(json['taxes'].map((x) => x) as Iterable),
      );

  String id;
  DateTime createdAt;
  int amountInCents;
  String reference;
  String currency;
  String paymentMethodType;
  CheckPaymentMethod paymentMethod;
  dynamic redirectUrl;
  String status;
  dynamic statusMessage;
  CheckMerchant merchant;
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

class CheckMerchant {
  CheckMerchant({
    required this.name,
    required this.legalName,
    required this.contactName,
    required this.phoneNumber,
    required this.logoUrl,
    required this.legalIdType,
    required this.email,
    required this.legalId,
  });

  factory CheckMerchant.fromJson(String str) =>
      CheckMerchant.fromMap(json.decode(str) as Map<String, dynamic>);

  factory CheckMerchant.fromMap(Map<String, dynamic> json) => CheckMerchant(
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

class CheckPaymentMethod {
  CheckPaymentMethod({
    required this.type,
    required this.extra,
  });

  factory CheckPaymentMethod.fromJson(String str) =>
      CheckPaymentMethod.fromMap(json.decode(str) as Map<String, dynamic>);

  factory CheckPaymentMethod.fromMap(Map<String, dynamic> json) =>
      CheckPaymentMethod(
        type: json['type'].toString(),
        extra: CheckExtra.fromMap(json['extra'] as Map<String, dynamic>),
      );

  String type;
  CheckExtra extra;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'type': type,
        'extra': extra.toMap(),
      };
}

class CheckExtra {
  CheckExtra({
    required this.name,
    required this.brand,
    required this.lastFour,
    required this.externalIdentifier,
  });

  factory CheckExtra.fromJson(String str) =>
      CheckExtra.fromMap(json.decode(str) as Map<String, dynamic>);

  factory CheckExtra.fromMap(Map<String, dynamic> json) => CheckExtra(
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

class CheckMeta {
  CheckMeta();

  factory CheckMeta.fromJson(String str) =>
      CheckMeta.fromMap(json.decode(str) as Map<String, dynamic>);

  factory CheckMeta.fromMap(Map<String, dynamic> json) => CheckMeta();

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {};
}
