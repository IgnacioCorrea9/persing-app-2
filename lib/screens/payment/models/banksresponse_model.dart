import 'dart:convert';

class BanksResponse {
  BanksResponse({
    required this.data,
  });

  factory BanksResponse.fromJson(String str) =>
      BanksResponse.fromMap(json.decode(str) as Map<String, dynamic>);

  factory BanksResponse.fromMap(Map<String, dynamic> json) => BanksResponse(
        data: List<Bank>.from(
          json['data'].map(
            (x) => Bank.fromMap(x as Map<String, dynamic>),
          ) as Iterable,
        ),
      );

  List<Bank> data;

  BanksResponse copyWith({
    List<Bank>? data,
  }) =>
      BanksResponse(
        data: data ?? this.data,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'data': List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Bank {
  Bank({
    required this.financialInstitutionCode,
    required this.financialInstitutionName,
  });

  factory Bank.fromJson(String str) =>
      Bank.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Bank.fromMap(Map<String, dynamic> json) => Bank(
        financialInstitutionCode: json['financial_institution_code'].toString(),
        financialInstitutionName: json['financial_institution_name'].toString(),
      );

  String financialInstitutionCode;
  String financialInstitutionName;

  Bank copyWith({
    String? financialInstitutionCode,
    String? financialInstitutionName,
  }) =>
      Bank(
        financialInstitutionCode:
            financialInstitutionCode ?? this.financialInstitutionCode,
        financialInstitutionName:
            financialInstitutionName ?? this.financialInstitutionName,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'financial_institution_code': financialInstitutionCode,
        'financial_institution_name': financialInstitutionName,
      };
}
