part of '../payment_provider.dart';

extension PaymentForm on PaymentProvider {
  Future<void> sendPaymentData(
    PaymentData data, {
    FutureListener<bool, Exception>? listener,
  }) async {
    listener?.onLoading!.call(true);
    final repo = PaymentRepository.get();
    try {
      // Environment.
      await repo.createTransaction(data);
      listener?.onSuccess.call(true);
    } on PaymentException catch (e) {
      listener?.onError.call(e);
      PaymentRetryDB.get().addPaymentDataError(data);
    } catch (e) {
      listener?.onError.call(Exception(e.toString()));
    } finally {
      listener!.onLoading!.call(false);
    }
  }

  Future<TransactionStatus> checkReference(String reference) async {
    final url = '${Config.wompiUrl}/transactions?reference=$reference';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${Environment().values.wompiSecret}',
      },
    );
    final decoded = jsonDecode(response.body);
    if (((decoded['data'] as List) ?? []).isNotEmpty) {
      final status = getStatus(decoded['data'][0]['status']);
      return status;
    }

    return TransactionStatus.pending;
  }
}
