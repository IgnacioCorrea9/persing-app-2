import 'dart:convert';

class PseResponse {
  PseResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory PseResponse.fromJson(String str) =>
      PseResponse.fromMap(json.decode(str) as Map<String, dynamic>);

  factory PseResponse.fromMap(Map<String, dynamic> json) => PseResponse(
        success: json['success'] as bool,
        data: PseResponseData.fromMap(json['data'] as Map<String, dynamic>),
        message: json['message'].toString(),
      );

  bool success;
  PseResponseData data;
  String message;

  PseResponse copyWith({
    bool? success,
    PseResponseData? data,
    String? message,
  }) =>
      PseResponse(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'success': success,
        'data': data.toMap(),
        'message': message,
      };
}

class PseResponseData {
  PseResponseData({
    required this.data,
  });

  factory PseResponseData.fromJson(String str) =>
      PseResponseData.fromMap(json.decode(str) as Map<String, dynamic>);

  factory PseResponseData.fromMap(Map<String, dynamic> json) => PseResponseData(
        data: PseData.fromMap(json['data'] as Map<String, dynamic>),
      );

  PseData data;

  PseResponseData copyWith({
    PseData? data,
  }) =>
      PseResponseData(
        data: data ?? this.data,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'data': data.toMap(),
      };
}

class PseData {
  PseData({
    required this.id,
    required this.createdAt,
    required this.amountInCents,
    required this.reference,
    required this.customerEmail,
    required this.currency,
    required this.paymentMethodType,
    required this.paymentMethod,
    required this.status,
    this.statusMessage,
    this.shippingAddress,
    this.redirectUrl,
    this.paymentSourceId,
    this.paymentLinkId,
    this.customerData,
    this.billId,
    required this.taxes,
  });

  factory PseData.fromJson(String str) =>
      PseData.fromMap(json.decode(str) as Map<String, dynamic>);

  factory PseData.fromMap(Map<String, dynamic> json) => PseData(
        id: json['id'].toString(),
        createdAt: DateTime.parse(json['created_at'].toString()),
        amountInCents: int.parse(json['amount_in_cents'].toString()),
        reference: json['reference'].toString(),
        customerEmail: json['customer_email'].toString(),
        currency: json['currency'].toString(),
        paymentMethodType: json['payment_method_type'].toString(),
        paymentMethod: PsePaymentMethod.fromMap(
          json['payment_method'] as Map<String, dynamic>,
        ),
        status: json['status'].toString(),
        statusMessage: json['status_message'],
        shippingAddress: json['shipping_address'],
        redirectUrl: json['redirect_url'],
        paymentSourceId: json['payment_source_id'],
        paymentLinkId: json['payment_link_id'],
        customerData: json['customer_data'],
        billId: json['bill_id'],
        taxes: List<dynamic>.from(json['taxes'].map((x) => x) as Iterable),
      );
  String id;
  DateTime createdAt;
  int amountInCents;
  String reference;
  String customerEmail;
  String currency;
  String paymentMethodType;
  PsePaymentMethod paymentMethod;
  String status;
  dynamic statusMessage;
  dynamic shippingAddress;
  dynamic redirectUrl;
  dynamic paymentSourceId;
  dynamic paymentLinkId;
  dynamic customerData;
  dynamic billId;
  List<dynamic> taxes;

  PseData copyWith({
    String? id,
    DateTime? createdAt,
    int? amountInCents,
    String? reference,
    String? customerEmail,
    String? currency,
    String? paymentMethodType,
    PsePaymentMethod? paymentMethod,
    String? status,
    dynamic statusMessage,
    dynamic shippingAddress,
    dynamic redirectUrl,
    dynamic paymentSourceId,
    dynamic paymentLinkId,
    dynamic customerData,
    dynamic billId,
    List<dynamic>? taxes,
  }) =>
      PseData(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        amountInCents: amountInCents ?? this.amountInCents,
        reference: reference ?? this.reference,
        customerEmail: customerEmail ?? this.customerEmail,
        currency: currency ?? this.currency,
        paymentMethodType: paymentMethodType ?? this.paymentMethodType,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        status: status ?? this.status,
        statusMessage: statusMessage ?? this.statusMessage,
        shippingAddress: shippingAddress ?? this.shippingAddress,
        redirectUrl: redirectUrl ?? this.redirectUrl,
        paymentSourceId: paymentSourceId ?? this.paymentSourceId,
        paymentLinkId: paymentLinkId ?? this.paymentLinkId,
        customerData: customerData ?? this.customerData,
        billId: billId ?? this.billId,
        taxes: taxes ?? this.taxes,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'id': id,
        'created_at': createdAt.toIso8601String(),
        'amount_in_cents': amountInCents,
        'reference': reference,
        'customer_email': customerEmail,
        'currency': currency,
        'payment_method_type': paymentMethodType,
        'payment_method': paymentMethod.toMap(),
        'status': status,
        'status_message': statusMessage,
        'shipping_address': shippingAddress,
        'redirect_url': redirectUrl,
        'payment_source_id': paymentSourceId,
        'payment_link_id': paymentLinkId,
        'customer_data': customerData,
        'bill_id': billId,
        'taxes': List<dynamic>.from(taxes.map((x) => x)),
      };
}

class PsePaymentMethod {
  PsePaymentMethod({
    required this.type,
    required this.userType,
    required this.userLegalId,
    required this.userLegalIdType,
    required this.paymentDescription,
    required this.financialInstitutionCode,
  });
  factory PsePaymentMethod.fromJson(String str) =>
      PsePaymentMethod.fromMap(json.decode(str) as Map<String, dynamic>);

  factory PsePaymentMethod.fromMap(Map<String, dynamic> json) =>
      PsePaymentMethod(
        type: json['type'].toString(),
        userType: int.parse(json['user_type'].toString()),
        userLegalId: json['user_legal_id'].toString(),
        userLegalIdType: json['user_legal_id_type'].toString(),
        paymentDescription: json['payment_description'].toString(),
        financialInstitutionCode: json['financial_institution_code'].toString(),
      );

  String type;
  int userType;
  String userLegalId;
  String userLegalIdType;
  String paymentDescription;
  String financialInstitutionCode;

  PsePaymentMethod copyWith({
    String? type,
    int? userType,
    String? userLegalId,
    String? userLegalIdType,
    String? paymentDescription,
    String? financialInstitutionCode,
  }) =>
      PsePaymentMethod(
        type: type ?? this.type,
        userType: userType ?? this.userType,
        userLegalId: userLegalId ?? this.userLegalId,
        userLegalIdType: userLegalIdType ?? this.userLegalIdType,
        paymentDescription: paymentDescription ?? this.paymentDescription,
        financialInstitutionCode:
            financialInstitutionCode ?? this.financialInstitutionCode,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'type': type,
        'user_type': userType,
        'user_legal_id': userLegalId,
        'user_legal_id_type': userLegalIdType,
        'payment_description': paymentDescription,
        'financial_institution_code': financialInstitutionCode,
      };
}
