import 'package:client/data/network/exceptions/api_exception.dart';
import 'package:client/data/repositories/movie_repository.dart';
import 'package:client/data/model/cinema_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/enums/status_enum.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final MovieRepository movieRepository;

  MovieDetailCubit({required this.movieRepository}) : super(const MovieDetailState());

  Future<void> getCinemas(String movieId) async {
    if (state.cinemasStatus.isProcessing) return;

    emit(state.copyWith(cinemasStatus: StatusEnum.processing, errorMessage: ''));
    try {
      final response = await movieRepository.getCinemasByMovieId(movieId);
      emit(state.copyWith(cinemas: response, cinemasStatus: StatusEnum.success, errorMessage: ''));
    } on ApiException catch (e) {
      emit(state.copyWith(cinemasStatus: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }
}
