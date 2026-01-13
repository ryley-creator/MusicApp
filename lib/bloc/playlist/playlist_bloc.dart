import 'package:audio_app/models/playlist.dart';
import 'package:audio_app/tools/audio_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  PlaylistBloc(this.service) : super(PlaylistState()) {
    on<FetchPlaylists>(onFetch);
    // on<FetchMorePlaylists>(onFetchMore);
  }
  final AppAudioService service;
  final int limit = 10;
  int offset = 0;

  Future<List<Playlist>> loadByCategory(
    PlaylistCategory category,
    int offset,
    int limit,
  ) {
    switch (category) {
      case PlaylistCategory.phonk:
        return service.getPhonkPlaylists(limit, offset);
      case PlaylistCategory.trending:
        return service.getTrendingPlaylists(limit, offset);
      case PlaylistCategory.popular:
        return service.getPopularPlaylists(limit, offset);
      case PlaylistCategory.pop:
        return service.getPopPlaylists(limit, offset);
      case PlaylistCategory.rock:
        return service.getRockPlaylists(limit, offset);
      case PlaylistCategory.kpop:
        return service.getKpopPlaylists(limit, offset);
    }
  }

  Future<void> onFetch(
    FetchPlaylists event,
    Emitter<PlaylistState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final playlists = await loadByCategory(event.category, 0, limit);

    final updated = Map<PlaylistCategory, List<Playlist>>.from(state.playlists);
    updated[event.category] = playlists;

    emit(state.copyWith(playlists: updated, isLoading: false));
  }

  // Future<void> onFetch(
  //   FetchPlaylists event,
  //   Emitter<PlaylistState> emit,
  // ) async {
  //   offset = 0;
  //   emit(
  //     state.copyWith(isLoading: true, playlists: [], category: event.category),
  //   );
  //   final playlists = await loadByCategory(event.category, offset, limit);
  //   offset += playlists.length;
  //   emit(
  //     state.copyWith(
  //       playlists: playlists,
  //       isLoading: false,
  //       hasMore: limit == playlists.length,
  //     ),
  //   );
  // }

  // Future<void> onFetchMore(
  //   FetchMorePlaylists event,
  //   Emitter<PlaylistState> emit,
  // ) async {
  //   if (state.isLoading || !state.hasMore) return;
  //   emit(state.copyWith(isLoading: true));
  //   final morePlaylists = await loadByCategory(event.category, offset, limit);
  //   offset += morePlaylists.length;

  //   emit(
  //     state.copyWith(
  //       playlists: [...state.playlists, ...morePlaylists],
  //       isLoading: false,
  //       hasMore: morePlaylists.length == limit,
  //     ),
  //   );
  // }
}
