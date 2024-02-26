// ignore_for_file: public_member_api_docs, sort_constructors_first
class FutureListener<T, E extends Exception> {
  final void Function(T value) onSuccess;
  final void Function(E error) onError;
  final void Function(bool loading)? onLoading;

  const FutureListener({
    required this.onSuccess,
    required this.onError,
    this.onLoading,
  });
}
