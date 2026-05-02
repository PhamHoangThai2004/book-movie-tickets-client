import 'package:client/data/model/cinema_model.dart';
import 'package:client/data/model/movie_poster_preview_model.dart';
import 'package:client/data/model/movie_preview_model.dart';
import 'package:client/data/network/exceptions/api_exception.dart';
import 'package:client/data/remote/requests/movie_preview_request.dart';
import 'package:client/data/remote/responses/model_response.dart';
import 'package:client/data/remote/responses/pagination_response.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/common/app_config.dart';
import '../../model/genre_model.dart';
import '../../model/movie_model.dart';
import '../../network/interceptors/general_interceptor.dart';

@singleton
class MovieService {
  final String _moviePath = 'users/movies';
  final String _movieCinemaPath = 'users/movies/{id}/cinemas';
  final String _moviePreviewsPath = 'users/movies/previews';
  final String _genrePath = 'users/genres';
  final String _reviewPath = 'users/movies/{id}/reviews';

  final Dio _dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl))
    ..interceptors.addAll([CurlLoggerDioInterceptor(printOnSuccess: true), GeneralInterceptor()]);

  Future<PaginationResponse<MoviePreviewModel>> getMovies(MoviePreviewRequest request) async {
    try {
      final response = await _dio.get(_moviePath, queryParameters: request.toJson());
      final result = PaginationResponse<MoviePreviewModel>.fromJson(
        response.data,
        (json) => MoviePreviewModel.fromJson(json as Map<String, dynamic>),
      );
      return result;
    } on ApiException {
      rethrow;
    }
  }

  Future<MovieModel> getMovieById(String id) async {
    try {
      final response = await _dio.get('$_moviePath/$id');
      final result = ModelResponse.fromJson(
        response.data,
        (json) => MovieModel.fromJson(json as Map<String, dynamic>),
      );
      return result.data;
    } on ApiException {
      rethrow;
    }
  }

  Future<List<CinemaModel>> getCinemasByMovieId(String movieId) async {
    try {
      final path = _movieCinemaPath.replaceAll('{id}', movieId);
      final response = await _dio.get(path);
      final result = ModelResponse.fromJson(
        response.data,
        (json) =>
            (json as List).map((e) => CinemaModel.fromJson(e as Map<String, dynamic>)).toList(),
      );
      return result.data;
    } on ApiException {
      rethrow;
    }
  }

  Future<List<MoviePosterPreviewModel>> getMoviePreviews(int limit) async {
    try {
      final response = await _dio.get(_moviePreviewsPath, queryParameters: {'limit': limit});
      final result = ModelResponse.fromJson(
        response.data,
        (json) => (json as List)
            .map((e) => MoviePosterPreviewModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
      return result.data;
    } on ApiException {
      rethrow;
    }
  }

  Future<List<GenreModel>> getGenres() async {
    try {
      final response = await _dio.get(_genrePath);
      final result = ModelResponse.fromJson(
        response.data,
        (json) => (json as List).map((e) => GenreModel.fromJson(e as Map<String, dynamic>)).toList(),
      );
      return result.data;
    } on ApiException {
      rethrow;
    }
  }

  Future<void> getReviews(String movieId) async {
    try {
      final path = _reviewPath.replaceAll('{id}', movieId);
      await _dio.get(path);
    } on ApiException {
      rethrow;
    }
  }
}
