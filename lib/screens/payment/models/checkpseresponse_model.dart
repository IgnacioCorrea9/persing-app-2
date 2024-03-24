import 'dart:convert';

class CheckPseResponse {
  CheckPseResponse({
    required this.data,
  });

  factory CheckPseResponse.fromJson(String str) =>
      CheckPseResponse.fromMap(json.decode(str) as Map<String, dynamic>);

  factory CheckPseResponse.fromMap(Map<String, dynamic> json) =>
      CheckPseResponse(
        data: CheckPseData.fromMap(json['data'] as Map<String, dynamic>),
      );

  CheckPseData data;

  CheckPseResponse copyWith({
    CheckPseData? data,
  }) =>
      CheckPseResponse(
        data: data ?? this.data,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'data': data.toMap(),
      };
}

class CheckPseData {
  CheckPseData({
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
  });

  factory CheckPseData.fromJson(String str) =>
      CheckPseData.fromMap(json.decode(str) as Map<String, dynamic>);

  factory CheckPseData.fromMap(Map<String, dynamic> json) => CheckPseData(
        id: json['id'].toString(),
        createdAt: DateTime.parse(json['created_at'].toString()),
        amountInCents: int.parse(json['amount_in_cents'].toString()),
        reference: json['reference'].toString(),
        currency: json['currency'].toString(),
        paymentMethodType: json['payment_method_type'].toString(),
        paymentMethod: CheckPsePaymentMethod.fromMap(
          json['payment_method'] as Map<String, dynamic>,
        ),
        redirectUrl: json['redirect_url'],
        status: json['status'].toString(),
        statusMessage: json['status_message'],
      );

  String id;
  DateTime createdAt;
  int amountInCents;
  String reference;
  String currency;
  String paymentMethodType;
  CheckPsePaymentMethod paymentMethod;
  dynamic redirectUrl;
  String status;
  dynamic statusMessage;

  CheckPseData copyWith({
    String? id,
    DateTime? createdAt,
    int? amountInCents,
    String? reference,
    String? currency,
    String? paymentMethodType,
    CheckPsePaymentMethod? paymentMethod,
    dynamic redirectUrl,
    String? status,
    dynamic statusMessage,
  }) =>
      CheckPseData(
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
      };
}

class CheckPseMerchant {
  CheckPseMerchant({
    required this.name,
    required this.legalName,
    required this.contactName,
    required this.phoneNumber,
    required this.logoUrl,
    required this.legalIdType,
    required this.email,
    required this.legalId,
  });
  factory CheckPseMerchant.fromJson(String str) =>
      CheckPseMerchant.fromMap(json.decode(str) as Map<String, dynamic>);

  factory CheckPseMerchant.fromMap(Map<String, dynamic> json) =>
      CheckPseMerchant(
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

  CheckPseMerchant copyWith({
    String? name,
    String? legalName,
    String? contactName,
    String? phoneNumber,
    dynamic logoUrl,
    String? legalIdType,
    String? email,
    String? legalId,
  }) =>
      CheckPseMerchant(
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

class CheckPsePaymentMethod {
  CheckPsePaymentMethod({
    required this.type,
    required this.extra,
    required this.userType,
    required this.userLegalId,
    required this.userLegalIdType,
    required this.paymentDescription,
    required this.financialInstitutionCode,
  });
  factory CheckPsePaymentMethod.fromJson(String str) =>
      CheckPsePaymentMethod.fromMap(json.decode(str) as Map<String, dynamic>);

  factory CheckPsePaymentMethod.fromMap(Map<String, dynamic> json) =>
      CheckPsePaymentMethod(
        type: json['type'].toString(),
        extra: CheckPseExtra.fromMap(json['extra'] as Map<String, dynamic>),
        userType: int.parse(json['user_type'].toString()),
        userLegalId: json['user_legal_id'].toString(),
        userLegalIdType: json['user_legal_id_type'].toString(),
        paymentDescription: json['payment_description'].toString(),
        financialInstitutionCode: json['financial_institution_code'].toString(),
      );

  String type;
  CheckPseExtra extra;
  int userType;
  String userLegalId;
  String userLegalIdType;
  String paymentDescription;
  String financialInstitutionCode;

  CheckPsePaymentMethod copyWith({
    String? type,
    CheckPseExtra? extra,
    int? userType,
    String? userLegalId,
    String? userLegalIdType,
    String? paymentDescription,
    String? financialInstitutionCode,
  }) =>
      CheckPsePaymentMethod(
        type: type ?? this.type,
        extra: extra ?? this.extra,
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
        'extra': extra.toMap(),
        'user_type': userType,
        'user_legal_id': userLegalId,
        'user_legal_id_type': userLegalIdType,
        'payment_description': paymentDescription,
        'financial_institution_code': financialInstitutionCode,
      };
}

class CheckPseExtra {
  CheckPseExtra({
    required this.ticketId,
    required this.returnCode,
    required this.requestDate,
    required this.asyncPaymentUrl,
    required this.traceabilityCode,
    required this.transactionCycle,
    required this.transactionState,
    required this.externalIdentifier,
    required this.bankProcessingDate,
  });
  factory CheckPseExtra.fromJson(String str) =>
      CheckPseExtra.fromMap(json.decode(str) as Map<String, dynamic>);

  factory CheckPseExtra.fromMap(Map<String, dynamic> json) => CheckPseExtra(
        ticketId: json['ticket_id'].toString(),
        returnCode: json['return_code'].toString(),
        requestDate: DateTime.parse(json['request_date'].toString()),
        asyncPaymentUrl: json['async_payment_url'].toString(),
        traceabilityCode: json['traceability_code'].toString(),
        transactionCycle: json['transaction_cycle'].toString(),
        transactionState: json['transaction_state'],
        externalIdentifier: json['external_identifier'].toString(),
        bankProcessingDate:
            DateTime.parse(json['bank_processing_date'].toString()),
      );

  String ticketId;
  String returnCode;
  DateTime requestDate;
  String asyncPaymentUrl;
  String traceabilityCode;
  String transactionCycle;
  dynamic transactionState;
  String externalIdentifier;
  DateTime bankProcessingDate;

  CheckPseExtra copyWith({
    String? ticketId,
    String? returnCode,
    DateTime? requestDate,
    String? asyncPaymentUrl,
    String? traceabilityCode,
    String? transactionCycle,
    dynamic transactionState,
    String? externalIdentifier,
    DateTime? bankProcessingDate,
  }) =>
      CheckPseExtra(
        ticketId: ticketId ?? this.ticketId,
        returnCode: returnCode ?? this.returnCode,
        requestDate: requestDate ?? this.requestDate,
        asyncPaymentUrl: asyncPaymentUrl ?? this.asyncPaymentUrl,
        traceabilityCode: traceabilityCode ?? this.traceabilityCode,
        transactionCycle: transactionCycle ?? this.transactionCycle,
        transactionState: transactionState ?? this.transactionState,
        externalIdentifier: externalIdentifier ?? this.externalIdentifier,
        bankProcessingDate: bankProcessingDate ?? this.bankProcessingDate,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'ticket_id': ticketId,
        'return_code': returnCode,
        'request_date':
            '${requestDate.year.toString().padLeft(4, '0')}-${requestDate.month.toString().padLeft(2, '0')}-${requestDate.day.toString().padLeft(2, '0')}',
        'async_payment_url': asyncPaymentUrl,
        'traceability_code': traceabilityCode,
        'transaction_cycle': transactionCycle,
        'transaction_state': transactionState,
        'external_identifier': externalIdentifier,
        'bank_processing_date':
            '${bankProcessingDate.year.toString().padLeft(4, '0')}-${bankProcessingDate.month.toString().padLeft(2, '0')}-${bankProcessingDate.day.toString().padLeft(2, '0')}',
      };
}
