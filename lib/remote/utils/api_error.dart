class ApiError{
  final String message;
  final int? statusCode;
  final String? status;

  ApiError(this.message, this.statusCode, this.status);

  @override
  String toString() {
    return "Message: $message\nStatus code: $statusCode\nStatus: $status";
  }
}