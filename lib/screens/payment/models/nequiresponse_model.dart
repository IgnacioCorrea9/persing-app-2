import 'dart:convert';

class NequiResponse {
  NequiResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory NequiResponse.fromJson(String str) =>
      NequiResponse.fromMap(json.decode(str) as Map<String, dynamic>);

  factory NequiResponse.fromMap(Map<String, dynamic> json) => NequiResponse(
        success: json['success'] as bool,
        data: NequiResponseData.fromMap(json['data'] as Map<String, dynamic>),
        message: json['message'].toString(),
      );

  bool success;
  NequiResponseData data;
  String message;

  NequiResponse copyWith({
    bool? success,
    NequiResponseData? data,
    String? message,
  }) =>
      NequiResponse(
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

class NequiResponseData {
  NequiResponseData({
    required this.data,
  });

  factory NequiResponseData.fromJson(String str) =>
      NequiResponseData.fromMap(json.decode(str) as Map<String, dynamic>);

  factory NequiResponseData.fromMap(Map<String, dynamic> json) =>
      NequiResponseData(
        data: DataData.fromMap(json['data'] as Map<String, dynamic>),
      );

  DataData data;

  NequiResponseData copyWith({
    DataData? data,
  }) =>
      NequiResponseData(
        data: data ?? this.data,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'data': data.toMap(),
      };
}

class DataData {
  DataData({
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

  factory DataData.fromJson(String str) =>
      DataData.fromMap(json.decode(str) as Map<String, dynamic>);

  factory DataData.fromMap(Map<String, dynamic> json) => DataData(
        id: json['id'].toString(),
        createdAt: DateTime.parse(json['created_at'].toString()),
        amountInCents: int.parse(json['amount_in_cents'].toString()),
        reference: json['reference'].toString(),
        customerEmail: json['customer_email'].toString(),
        currency: json['currency'].toString(),
        paymentMethodType: json['payment_method_type'].toString(),
        paymentMethod: NequiPaymentMethod.fromMap(
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
  NequiPaymentMethod paymentMethod;
  String status;
  dynamic statusMessage;
  dynamic shippingAddress;
  dynamic redirectUrl;
  dynamic paymentSourceId;
  dynamic paymentLinkId;
  dynamic customerData;
  dynamic billId;
  List<dynamic> taxes;

  DataData copyWith({
    String? id,
    DateTime? createdAt,
    int? amountInCents,
    String? reference,
    String? customerEmail,
    String? currency,
    String? paymentMethodType,
    NequiPaymentMethod? paymentMethod,
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
      DataData(
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

class NequiPaymentMethod {
  NequiPaymentMethod({
    required this.type,
    required this.token,
    required this.phoneNumber,
  });

  factory NequiPaymentMethod.fromJson(String str) =>
      NequiPaymentMethod.fromMap(json.decode(str) as Map<String, dynamic>);

  factory NequiPaymentMethod.fromMap(Map<String, dynamic> json) =>
      NequiPaymentMethod(
        type: json['type'].toString(),
        token: json['token'].toString(),
        phoneNumber: json['phone_number'].toString(),
      );

  String type;
  String token;
  String phoneNumber;

  NequiPaymentMethod copyWith({
    String? type,
    String? token,
    String? phoneNumber,
  }) =>
      NequiPaymentMethod(
        type: type ?? this.type,
        token: token ?? this.token,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'type': type,
        'token': token,
        'phone_number': phoneNumber,
      };
}
