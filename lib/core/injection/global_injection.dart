import 'package:get_it/get_it.dart';
import 'package:persing/core/storage/token_storage.dart';
import 'package:persing/screens/payment/data/payment_repository.dart';
import 'package:persing/screens/payment/data/payment_rt_db.dart';
import 'package:persing/screens/payment/provider/payment_controller.dart';

final getIt = GetIt.instance;

void init() {
  //inyectando hives
  _hiveInject();

  //repositorios
  getIt.registerFactory<PaymentRepository>(() => PaymentRepository());
  getIt.registerFactory<PaymentController>(() => PaymentController());

  //others
  getIt.registerLazySingleton<TokenStorage>(() => TokenStorage());
}

void _hiveInject() {
  getIt.registerLazySingleton<PaymentRetryDB>(() => PaymentRetryDB());
}
