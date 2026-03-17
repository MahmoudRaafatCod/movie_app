import 'package:movie/features/actor_details/data/models/profile_image_model.dart';

class ActorImagesModel {
  final int id;
  final List<ProfileImageModel> profiles;

  ActorImagesModel({
    required this.id,
    required this.profiles,
  });

  factory ActorImagesModel.fromJson(Map<String, dynamic> json) {
    return ActorImagesModel(
      id: json['id'],
      profiles: json['profiles'] != null
          ? List<ProfileImageModel>.from(
              json['profiles'].map((x) => ProfileImageModel.fromJson(x)))
          : [],
    );
  }
}


