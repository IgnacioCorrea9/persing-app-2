import 'package:persing/core/injection/global_injection.dart';
import 'package:persing/screens/payment/data/payment_repository.dart';
import 'package:persing/screens/payment/data/payment_rt_db.dart';

class PaymentController {
  static PaymentController get() {
    return getIt.get<PaymentController>();
  }
  ///buscara la lista de errores de la base interna
  ///e intentara actualizar el servidor con las mismas
  void searchForPaymentErrors() async {
    final db = PaymentRetryDB.get();
    final repo = PaymentRepository.get();

    final errors = await db.getListPayments();

    for (var data in errors) {
      try {
        //si el repo no lanza error, significara que se pudo subir 
        //de manera correcta la transacción
        await repo.createTransaction(data);
        db.removePayment(data.reference);
      } catch (e) {}
    }
  }
}
