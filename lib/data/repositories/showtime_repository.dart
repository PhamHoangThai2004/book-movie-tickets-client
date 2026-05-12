import 'package:client/data/remote/services/showtime_service.dart';
import 'package:injectable/injectable.dart';

import '../model/booking_preview_model.dart';
import '../model/showtime_model.dart';
import '../model/showtime_preview_model.dart';
import '../network/exceptions/api_exception.dart';
import '../remote/requests/booking_request.dart';
import '../remote/requests/showtime_request.dart';

abstract class ShowtimeRepository {
  Future<List<ShowtimePreviewModel>> getShowtimes(ShowtimeRequest request);

  Future<ShowtimeModel> getNearestShowtime(String cinemaId, String movieId);

  Future<ShowtimeModel> getShowtimeById(String id);

  Future<BookingPreviewModel> pickSeat(BookingRequest request);

  Future<BookingPreviewModel> unpickSeat(BookingRequest request);

  Future<void> removePendingBooking();
}

@LazySingleton(as: ShowtimeRepository)
class ShowtimeRepositoryImpl implements ShowtimeRepository {
  final ShowtimeService _showtimeService;

  ShowtimeRepositoryImpl({required ShowtimeService showtimeService})
    : _showtimeService = showtimeService;

  @override
  Future<ShowtimeModel> getShowtimeById(String id) async {
    try {
      final response = await _showtimeService.getShowtimeById(id);
      return response;
    } catch (e) {
      throw ApiException.error(e);
    }
  }

  @override
  Future<List<ShowtimePreviewModel>> getShowtimes(ShowtimeRequest request) async {
    try {
      final response = await _showtimeService.getShowtimes(request);
      return response;
    } catch (e) {
      throw ApiException.error(e);
    }
  }

  @override
  Future<BookingPreviewModel> pickSeat(BookingRequest request) async {
    try {
      final response = await _showtimeService.pickSeat(request);
      return response;
    } catch (e) {
      throw ApiException.error(e);
    }
  }

  @override
  Future<BookingPreviewModel> unpickSeat(BookingRequest request) async {
    try {
      final response = await _showtimeService.unpickSeat(request);
      return response;
    } catch (e) {
      throw ApiException.error(e);
    }
  }

  @override
  Future<void> removePendingBooking() async {
    try {
      await _showtimeService.removePendingBooking();
    } catch (e) {
      throw ApiException.error(e);
    }
  }

  @override
  Future<ShowtimeModel> getNearestShowtime(String cinemaId, String movieId) async {
    try {
      final response = await _showtimeService.getNearestShowtime(cinemaId, movieId);
      return response;
    } catch (e) {
      throw ApiException.error(e);
    }
  }
}
