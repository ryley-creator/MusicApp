part of 'playlist_track_bloc.dart';

class PlaylistTrackEvent extends Equatable {
  const PlaylistTrackEvent();

  @override
  List<Object> get props => [];
}

class FetchPlaylistTracks extends PlaylistTrackEvent {
  final String playlistId;
  const FetchPlaylistTracks(this.playlistId);
}

class FetchMorePlaylistTracks extends PlaylistTrackEvent {
  final String playlistId;
  const FetchMorePlaylistTracks(this.playlistId);
}
