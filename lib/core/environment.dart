// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static final Environment _singleton = Environment._internal(
    EnvironmentValues(
      wompiProdKey: dotenv.env['WOMPI_PROD_KEY'] ?? '',
      wompiSecret: dotenv.env['WOMPI_SECRET'] ?? '',
      wompiTestPhone: dotenv.env['WOMPI_TEST_PHONE'] ?? '',
    ),
  );

  factory Environment() {
    return _singleton;
  }

  Environment._internal(this.values);

  final EnvironmentValues values;
}

class EnvironmentValues {
  final String wompiProdKey;
  final String wompiSecret;
  final String wompiTestPhone;
  EnvironmentValues({
    required this.wompiProdKey,
    required this.wompiSecret,
    required this.wompiTestPhone,
  });
}
