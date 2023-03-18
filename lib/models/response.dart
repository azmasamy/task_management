class Response {
  final String message;
  final bool isOperationSuccessful;
  final dynamic data;

  Response({
    required this.message,
    required this.isOperationSuccessful,
    this.data,
  });
}
