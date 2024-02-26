import 'dart:convert';

class CardModel {
  CardModel({
    required this.number,
    required this.cvc,
    required this.expMonth,
    required this.expYear,
    required this.cardHolder,
  });

  factory CardModel.fromJson(String str) =>
      CardModel.fromMap(json.decode(str) as Map<String, dynamic>);

  factory CardModel.fromMap(Map<String, dynamic> json) => CardModel(
        number: json['number'].toString(),
        cvc: json['cvc'].toString(),
        expMonth: json['exp_month'].toString(),
        expYear: json['exp_year'].toString(),
        cardHolder: json['card_holder'].toString(),
      );

  String number;
  String cvc;
  String expMonth;
  String expYear;
  String cardHolder;

  CardModel copyWith({
    String? number,
    String? cvc,
    String? expMonth,
    String? expYear,
    String? cardHolder,
  }) =>
      CardModel(
        number: number ?? this.number,
        cvc: cvc ?? this.cvc,
        expMonth: expMonth ?? this.expMonth,
        expYear: expYear ?? this.expYear,
        cardHolder: cardHolder ?? this.cardHolder,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'number': number,
        'cvc': cvc,
        'exp_month': expMonth,
        'exp_year': expYear,
        'card_holder': cardHolder,
      };
}
