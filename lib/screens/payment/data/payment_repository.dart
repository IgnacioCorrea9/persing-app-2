import 'dart:convert';

import 'package:persing/core/config.dart';
import 'package:http/http.dart';
import 'package:persing/core/injection/global_injection.dart';
import 'package:persing/core/storage/token_storage.dart';
import 'package:persing/screens/payment/exceptions/payment_exceptions.dart';
import 'package:persing/screens/payment/models/payment_model.dart';

class PaymentRepository {
  static PaymentRepository get() {
    return getIt.get<PaymentRepository>();
  }

  Future<Map<String, String>> _getHeaders() async {
    return {
      "Authorization": await TokenStorage.get().gett(),
      'Content-Type': 'application/json',
    };
  }

  Future createTransaction(PaymentData data) async {
    final uri = Uri.parse(_base);
    try {
      final body = data.toMap();
      final response = await post(
        uri,
        body: jsonEncode(body),
        headers: await _getHeaders(),
      );
      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw PaymentException();
      }
    } catch (e) {
      rethrow;
    }
  }

  //zona de rutas
  static String get _base => '${Config.api}transaction';
}
