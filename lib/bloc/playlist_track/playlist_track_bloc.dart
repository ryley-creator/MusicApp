// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:audio_app/models/track.dart';
import 'package:audio_app/tools/audio_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'playlist_track_event.dart';
part 'playlist_track_state.dart';

class PlaylistTrackBloc extends Bloc<PlaylistTrackEvent, PlaylistTrackState> {
  PlaylistTrackBloc(this.service) : super(PlaylistTrackState()) {
    on<FetchMorePlaylistTracks>(onFetchMore);
    on<FetchPlaylistTracks>(onFetch);
  }
  final AppAudioService service;
  final int limit = 20;
  int offset = 0;
  String? currentPlaylistId;
  Future<void> onFetch(
    FetchPlaylistTracks event,
    Emitter<PlaylistTrackState> emit,
  ) async {
    currentPlaylistId = event.playlistId;
    offset = 0;

    emit(state.copyWith(isLoading: true, tracks: []));
    final tracks = await service.getPlaylistTracks(
      event.playlistId,
      limit,
      offset,
    );
    offset += tracks.length;
    emit(
      state.copyWith(
        tracks: tracks,
        isLoading: false,
        hasMore: limit == tracks.length,
      ),
    );
  }

  Future<void> onFetchMore(
    FetchMorePlaylistTracks event,
    Emitter<PlaylistTrackState> emit,
  ) async {
    if (state.isLoading ||
        !state.hasMore ||
        event.playlistId != currentPlaylistId)
      return;
    final moreTracks = await service.getPlaylistTracks(
      event.playlistId,
      limit,
      offset,
    );
    emit(
      state.copyWith(
        tracks: [...state.tracks, ...moreTracks],
        isLoading: false,
        hasMore: limit == moreTracks.length,
      ),
    );
  }
}
