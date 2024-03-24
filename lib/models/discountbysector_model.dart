import 'dart:convert';

class DiscountBySector {
  DiscountBySector({
    required this.sector,
    required this.totalDiscount,
  });

  final String sector;
  final int totalDiscount;

  factory DiscountBySector.fromJson(String str) =>
      DiscountBySector.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DiscountBySector.fromMap(Map<String, dynamic> json) =>
      DiscountBySector(
        sector: json["sector"],
        totalDiscount: json["totalDiscount"],
      );

  Map<String, dynamic> toMap() => {
        "sector": sector,
        "totalDiscount": totalDiscount,
      };
}
