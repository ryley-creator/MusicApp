part of 'playlist_track_bloc.dart';

class PlaylistTrackState extends Equatable {
  final List<Track> tracks;
  final bool isLoading;
  final bool hasMore;

  const PlaylistTrackState({
    this.tracks = const [],
    this.isLoading = false,
    this.hasMore = true,
  });

  PlaylistTrackState copyWith({
    List<Track>? tracks,
    bool? isLoading,
    bool? hasMore,
  }) {
    return PlaylistTrackState(
      tracks: tracks ?? this.tracks,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object> get props => [hasMore, tracks, isLoading];
}
