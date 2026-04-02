import 'package:client/data/model/movie_model.dart';
import 'package:client/data/remote/requests/movie_preview_request.dart';
import 'package:client/data/remote/services/movie_service.dart';
import 'package:injectable/injectable.dart';

import '../model/movie_preview_model.dart';
import '../network/exceptions/api_exception.dart';
import '../remote/responses/pagination_response.dart';

abstract class MovieRepository {
  Future<PaginationResponse<MoviePreviewModel>> getMovies(MoviePreviewRequest request);

  Future<MovieModel> getMovieById(String id);
}

@Injectable(as: MovieRepository)
class MovieRepositoryImpl implements MovieRepository {
  final MovieService _movieService;

  MovieRepositoryImpl({required MovieService movieService}) : _movieService = movieService;

  @override
  Future<PaginationResponse<MoviePreviewModel>> getMovies(MoviePreviewRequest request) async {
    try {
      final response = await _movieService.getMovies(request);
      return response;
    } catch (e) {
      throw ApiException.error(e);
    }
  }

  @override
  Future<MovieModel> getMovieById(String id) async {
    try {
      final response = await _movieService.getMovieById(id);
      return response;
    } catch (e) {
      throw ApiException.error(e);
    }
  }
}
