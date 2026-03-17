class ExceptionModel {
  final bool success;
  final String message;

  ExceptionModel({required this.success, required this.message});

  factory ExceptionModel.fromJson(Map<String, dynamic> json){
    return ExceptionModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "Unknown Error",
    );
  }
}
