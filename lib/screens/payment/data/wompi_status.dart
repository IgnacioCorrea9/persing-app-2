enum TransactionStatus {
  pending,
  approved,
  declined,
  error,
  voided,
  voidedAfterApproval,
}


TransactionStatus getStatus(String status) {
  switch (status.toLowerCase()) {
    case 'pending':
      return TransactionStatus.pending;
    case 'approved':
      return TransactionStatus.approved;
    case 'declined':
      return TransactionStatus.declined;
    case 'error':
      return TransactionStatus.error;
    case 'voided':
      return TransactionStatus.voided;
    case 'voided_after_approval':
      return TransactionStatus.voidedAfterApproval;
    default:
      throw Exception('Estado de transacción desconocido: $status');
  }
}





