// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:audio_app/models/track.dart';
import 'package:audio_app/tools/audio_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'track_event.dart';
part 'track_state.dart';

class TrackBloc extends Bloc<TrackEvent, TrackState> {
  TrackBloc(this.service) : super(TrackState()) {
    on<FetchMoreTracks>(onFetchMore);
    on<FetchTracks>(onFetch);
  }
  final AppAudioService service;

  int limit = 20;
  int offset = 0;

  Future<List<Track>> loadTrackByCatgory(
    TrackCategory category,
    int offset,
  ) async {
    switch (category) {
      case TrackCategory.popular:
        return service.getPopularTracks(limit, offset);
      case TrackCategory.trending:
        return service.getTrendingTracks(limit, offset);
      case TrackCategory.phonk:
        return service.getTrendingTracks(limit, offset);
    }
  }

  // Future<void> onFetch(FetchTracks event, Emitter<TrackState> emit) async {
  //   try {
  //     emit(state.copyWith(isLoading: true));
  //     final tracks = await loadTrackByCatgory(event.category, offset);
  //     offset = tracks.length;
  //     emit(
  //       state.copyWith(
  //         tracks: tracks,
  //         isLoading: false,
  //         hasMore: tracks.length == limit,
  //       ),
  //     );
  //   } on DioException catch (error) {
  //     emit(state.copyWith(errorMessage: 'Error: ${error.toString()}'));
  //   }
  // }

  Future<void> onFetch(FetchTracks event, Emitter<TrackState> emit) async {
    try {
      final isNewCategory = state.category != event.category;
      if (isNewCategory) {
        offset = 0;
        emit(
          state.copyWith(
            isLoading: true,
            tracks: [],
            hasMore: true,
            category: event.category,
          ),
        );
      } else {
        emit(state.copyWith(isLoading: true));
      }
      final tracks = await loadTrackByCatgory(event.category, offset);
      offset += tracks.length;

      emit(
        state.copyWith(
          tracks: tracks,
          isLoading: false,
          hasMore: tracks.length == limit,
        ),
      );
    } catch (error) {
      emit(state.copyWith(errorMessage: 'Error $error'));
    }
  }

  // Future<void> onFetchMore(
  //   FetchMoreTracks event,
  //   Emitter<TrackState> emit,
  // ) async {
  //   if (state.isLoading || !state.hasMore) return;
  //   emit(state.copyWith(isLoading: true));
  //   final more = await loadTrackByCatgory(event.category, offset);
  //   offset += more.length;
  //   emit(
  //     state.copyWith(
  //       tracks: [...state.tracks, ...more],
  //       isLoading: false,
  //       hasMore: more.length == limit,
  //     ),
  //   );
  // }

  Future<void> onFetchMore(
    FetchMoreTracks event,
    Emitter<TrackState> emit,
  ) async {
    if (state.isLoading || state.category != event.category || !state.hasMore)
      return;
    emit(state.copyWith(isLoading: true));

    final moreTracks = await loadTrackByCatgory(event.category, offset);
    offset += moreTracks.length;
    emit(
      state.copyWith(
        tracks: [...state.tracks, ...moreTracks],
        isLoading: false,
        hasMore: limit == moreTracks.length,
      ),
    );
  }
}
