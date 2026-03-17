import 'package:movie/core/network/api_consumer.dart';
import 'package:movie/features/actor_details/data/models/actor_details_model.dart';
import 'package:movie/features/actor_details/data/models/actor_images_model.dart';
import 'package:movie/features/actor_details/data/models/actor_movie_model.dart';

class ActorRepo {
  final ApiConsumer _repo;
  ActorRepo(this._repo);

  Future<dynamic> getActorDetails(int id) async {
    try {
      final response = await _repo.get("/person/$id");
      return ActorDetailsModel.fromJson(response);
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> getActorMovies(int id) async {
    try {
      final response = await _repo.get("/person/$id/combined_credits");
      return ActorMovieModel.fromJson(response);
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> getActorImages(int id) async {
    try {
      final response = await _repo.get("/person/$id/images");
      return ActorImagesModel.fromJson(response);
    } catch (e) {
      return e.toString();
    }
  }
}
