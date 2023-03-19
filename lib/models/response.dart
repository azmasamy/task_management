class Response {
  String message;
  bool isOperationSuccessful;
  dynamic data;

  Response({
    required this.message,
    required this.isOperationSuccessful,
    this.data,
  });
}
