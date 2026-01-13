part of 'playlist_bloc.dart';

class PlaylistEvent extends Equatable {
  const PlaylistEvent();

  @override
  List<Object> get props => [];
}

class FetchPlaylists extends PlaylistEvent {
  final PlaylistCategory category;
  const FetchPlaylists(this.category);
}

class FetchMorePlaylists extends PlaylistEvent {
  final PlaylistCategory category;
  const FetchMorePlaylists(this.category);
}
