class ProfileImageModel {
  final String filePath;

  ProfileImageModel({
    required this.filePath,
  });

  factory ProfileImageModel.fromJson(Map<String, dynamic> json) {
    return ProfileImageModel(
      filePath: json['file_path'] ?? "",
    );
  }
}