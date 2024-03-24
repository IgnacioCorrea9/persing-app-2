import 'dart:convert';

class Transaction {
  Transaction({
    required this.amountInCents,
    required this.reference,
    required this.customerEmail,
    required this.currency,
    required this.acceptanceToken,
    required this.paymentMethod,
    required this.publicKey,
  });

  factory Transaction.fromJson(String str) =>
      Transaction.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Transaction.fromMap(Map<String, dynamic> json) => Transaction(
        amountInCents: int.parse(json['amount_in_cents'].toString()),
        reference: json['reference'].toString(),
        customerEmail: json['customer_email'].toString(),
        currency: json['currency'].toString(),
        acceptanceToken: json['acceptance_token'].toString(),
        paymentMethod: PaymentMethod.fromMap(
          json['payment_method'] as Map<String, dynamic>,
        ),
        publicKey: json['public_key'].toString(),
      );

  String toJson() => json.encode(toMap());

  int amountInCents;
  String reference;
  String customerEmail;
  String currency;
  String acceptanceToken;
  PaymentMethod paymentMethod;
  String publicKey;

  Transaction copyWith({
    int? amountInCents,
    String? reference,
    String? customerEmail,
    String? currency,
    String? acceptanceToken,
    PaymentMethod? paymentMethod,
    String? publicKey,
  }) =>
      Transaction(
        amountInCents: amountInCents ?? this.amountInCents,
        reference: reference ?? this.reference,
        customerEmail: customerEmail ?? this.customerEmail,
        currency: currency ?? this.currency,
        acceptanceToken: acceptanceToken ?? this.acceptanceToken,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        publicKey: publicKey ?? this.publicKey,
      );

  Map<String, dynamic> toMap() => {
        'amount_in_cents': amountInCents,
        'reference': reference,
        'customer_email': customerEmail,
        'currency': currency,
        'acceptance_token': acceptanceToken,
        'payment_method': paymentMethod.toMap(),
        'public_key': publicKey,
      };
}

class PaymentMethod {
  PaymentMethod({
    required this.type,
    required this.installments,
    required this.token,
  });

  factory PaymentMethod.fromJson(String str) =>
      PaymentMethod.fromMap(json.decode(str) as Map<String, dynamic>);

  factory PaymentMethod.fromMap(Map<String, dynamic> json) => PaymentMethod(
        type: json['type'].toString(),
        installments: int.parse(json['installments'].toString()),
        token: json['token'].toString(),
      );

  String type;
  int installments;
  String token;

  PaymentMethod copyWith({
    String? type,
    int? installments,
    String? token,
  }) =>
      PaymentMethod(
        type: type ?? this.type,
        installments: installments ?? this.installments,
        token: token ?? this.token,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'type': type,
        'installments': installments,
        'token': token,
      };
}
