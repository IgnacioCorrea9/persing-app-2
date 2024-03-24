//archivo para manejo de informacion para reintentos en hive
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persing/core/injection/global_injection.dart';
import 'package:persing/screens/payment/models/payment_model.dart';

class PaymentRetryDB {
  static const _boxKey = 'payments_retry_db';

  static PaymentRetryDB get() {
    return getIt.get<PaymentRetryDB>();
  }

  // static const _paymentKey = 'payment_retry_key';

  late Box<Map<String, dynamic>> _box;

  Future<Box<Map<String, dynamic>>> _get() async {
    if (_box == null) {
      _box = await Hive.openBox(_boxKey);
    }
    return _box;
  }

  Future<void> addPaymentDataError(PaymentData data) async {
    //se obtiene la box
    final box = await _get();

    //añadiendo el nuevo dato
    box.put(data.reference, data.toMap());
  }

  Future<List<PaymentData>> getListPayments() async {
    final list = (await _get()).values.toList();
    final lista = <PaymentData>[];
    for (var i in list) {
      try {
        lista.add(PaymentData.fromMap(i));
      } catch (e) {}
    }
    return lista;
  }

  Future<bool> removePayment(String reference) async {
    try {
      (await _get()).delete(reference);
      return true;
    } catch (e) {
      return false;
    }
  }
}
