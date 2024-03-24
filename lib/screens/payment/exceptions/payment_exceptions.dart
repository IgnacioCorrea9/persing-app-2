class PaymentException implements Exception {
  const PaymentException({
    this.mssg = 'Error en tu transacción',
  });

  final String mssg;
}
