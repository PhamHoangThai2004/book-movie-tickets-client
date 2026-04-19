import 'package:client/data/enums/movie_status_enum.dart';
import 'package:client/data/model/movie_preview_model.dart';
import 'package:client/data/network/exceptions/api_exception.dart';
import 'package:client/data/remote/requests/movie_preview_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/movie_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final MovieRepository movieRepository;

  HomeCubit({required this.movieRepository}) : super(HomeState());

  Future<void> getMovies(MovieStatusEnum status) async {
    try {
      if (status.isComingSoon) {
        emit(state.copyWith(isComingSoonLoading: true));
      } else if (status.isNowShowing) {
        emit(state.copyWith(isNowPlayingLoading: true));
      }

      final request = MoviePreviewRequest(status: status.toKey, page: 1, size: 10);
      final response = await movieRepository.getMovies(request);
      if (status.isComingSoon) {
        emit(state.copyWith(comingSoonMovies: response.items, isComingSoonLoading: false));
      } else if (status.isNowShowing) {
        emit(state.copyWith(nowPlayingMovies: response.items, isNowPlayingLoading: false));
      }
    } on ApiException catch (e) {
      emit(state.copyWith(errorMessage: e.errorMessage));
    }
  }
}
