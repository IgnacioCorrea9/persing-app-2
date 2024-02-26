import 'dart:convert';

class CheckNequiResponse {
  CheckNequiResponse({
    required this.data,
  });

  factory CheckNequiResponse.fromJson(String str) =>
      CheckNequiResponse.fromMap(json.decode(str) as Map<String, dynamic>);

  factory CheckNequiResponse.fromMap(Map<String, dynamic> json) =>
      CheckNequiResponse(
        data: NequiData.fromMap(json['data'] as Map<String, dynamic>),
      );

  NequiData data;

  CheckNequiResponse copyWith({
    NequiData? data,
  }) =>
      CheckNequiResponse(
        data: data ?? this.data,
      );

  String toJson() => json.encode(toMap());
  Map<String, dynamic> toMap() => {
        'data': data.toMap(),
      };
}

class NequiData {
  NequiData({
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

  factory NequiData.fromJson(String str) =>
      NequiData.fromMap(json.decode(str) as Map<String, dynamic>);

  factory NequiData.fromMap(Map<String, dynamic> json) => NequiData(
        id: json['id'].toString(),
        createdAt: DateTime.parse(json['created_at'].toString()),
        amountInCents: int.parse(json['amount_in_cents'].toString()),
        reference: json['reference'].toString(),
        currency: json['currency'].toString(),
        paymentMethodType: json['payment_method_type'].toString(),
        paymentMethod: CheckNequiPaymentMethod.fromMap(
          json['payment_method'] as Map<String, dynamic>,
        ),
        redirectUrl: json['redirect_url'],
        status: json['status'].toString(),
        statusMessage: json['status_message'],
        merchant:
            MerchantNequi.fromMap(json['merchant'] as Map<String, dynamic>),
        taxes: List<dynamic>.from(json['taxes'].map((x) => x) as Iterable),
      );

  String id;
  DateTime createdAt;
  int amountInCents;
  String reference;
  String currency;
  String paymentMethodType;
  CheckNequiPaymentMethod paymentMethod;
  dynamic redirectUrl;
  String status;
  dynamic statusMessage;
  MerchantNequi merchant;
  List<dynamic> taxes;

  NequiData copyWith({
    String? id,
    DateTime? createdAt,
    int? amountInCents,
    String? reference,
    String? currency,
    String? paymentMethodType,
    CheckNequiPaymentMethod? paymentMethod,
    dynamic redirectUrl,
    String? status,
    dynamic statusMessage,
    MerchantNequi? merchant,
    List<dynamic>? taxes,
  }) =>
      NequiData(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        amountInCents: amountInCents ?? this.amountInCents,
        reference: reference ?? this.reference,
        currency: currency ?? this.currency,
        paymentMethodType: paymentMethodType ?? this.paymentMethodType,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        redirectUrl: redirectUrl ?? this.redirectUrl,
        status: status ?? this.status,
        statusMessage: statusMessage ?? this.statusMessage,
        merchant: merchant ?? this.merchant,
        taxes: taxes ?? this.taxes,
      );

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

class MerchantNequi {
  MerchantNequi({
    required this.name,
    required this.legalName,
    required this.contactName,
    required this.phoneNumber,
    required this.logoUrl,
    required this.legalIdType,
    required this.email,
    required this.legalId,
  });

  factory MerchantNequi.fromJson(String str) =>
      MerchantNequi.fromMap(json.decode(str) as Map<String, dynamic>);

  factory MerchantNequi.fromMap(Map<String, dynamic> json) => MerchantNequi(
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

  MerchantNequi copyWith({
    String? name,
    String? legalName,
    String? contactName,
    String? phoneNumber,
    dynamic logoUrl,
    String? legalIdType,
    String? email,
    String? legalId,
  }) =>
      MerchantNequi(
        name: name ?? this.name,
        legalName: legalName ?? this.legalName,
        contactName: contactName ?? this.contactName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        logoUrl: logoUrl ?? this.logoUrl,
        legalIdType: legalIdType ?? this.legalIdType,
        email: email ?? this.email,
        legalId: legalId ?? this.legalId,
      );

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

class CheckNequiPaymentMethod {
  CheckNequiPaymentMethod({
    required this.type,
    required this.extra,
    required this.token,
    required this.phoneNumber,
  });

  factory CheckNequiPaymentMethod.fromJson(String str) =>
      CheckNequiPaymentMethod.fromMap(json.decode(str) as Map<String, dynamic>);

  factory CheckNequiPaymentMethod.fromMap(Map<String, dynamic> json) =>
      CheckNequiPaymentMethod(
        type: json['type'].toString(),
        extra: ExtraNequi.fromMap(json['extra'] as Map<String, dynamic>),
        token: json['token'].toString(),
        phoneNumber: json['phone_number'].toString(),
      );

  String type;
  ExtraNequi extra;
  String token;
  String phoneNumber;

  CheckNequiPaymentMethod copyWith({
    String? type,
    ExtraNequi? extra,
    String? token,
    String? phoneNumber,
  }) =>
      CheckNequiPaymentMethod(
        type: type ?? this.type,
        extra: extra ?? this.extra,
        token: token ?? this.token,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'type': type,
        'extra': extra.toMap(),
        'token': token,
        'phone_number': phoneNumber,
      };
}

class ExtraNequi {
  ExtraNequi({
    required this.transactionId,
    required this.externalIdentifier,
  });

  factory ExtraNequi.fromJson(String str) =>
      ExtraNequi.fromMap(json.decode(str) as Map<String, dynamic>);

  factory ExtraNequi.fromMap(Map<String, dynamic> json) => ExtraNequi(
        transactionId: json['transaction_id'].toString(),
        externalIdentifier: json['external_identifier'].toString(),
      );

  String transactionId;
  String externalIdentifier;

  ExtraNequi copyWith({
    String? transactionId,
    String? externalIdentifier,
  }) =>
      ExtraNequi(
        transactionId: transactionId ?? this.transactionId,
        externalIdentifier: externalIdentifier ?? this.externalIdentifier,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'transaction_id': transactionId,
        'external_identifier': externalIdentifier,
      };
}
