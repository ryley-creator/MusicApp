part of 'playlist_bloc.dart';

enum PlaylistCategory { phonk, popular, trending, pop, rock, kpop }

class PlaylistState extends Equatable {
  final Map<PlaylistCategory, List<Playlist>> playlists;
  final bool isLoading;

  const PlaylistState({this.playlists = const {}, this.isLoading = false});

  PlaylistState copyWith({
    Map<PlaylistCategory, List<Playlist>>? playlists,
    bool? isLoading,
  }) {
    return PlaylistState(
      playlists: playlists ?? this.playlists,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [playlists, isLoading];
}

// class PlaylistState extends Equatable {
//   const PlaylistState({
//     this.hasMore = false,
//     this.isLoading = false,
//     this.playlists = const [],
//     this.category,
//   });
//   final List<Playlist> playlists;
//   final bool isLoading;
//   final bool hasMore;
//   final PlaylistCategory? category;

//   PlaylistState copyWith({
//     List<Playlist>? playlists,
//     bool? isLoading,
//     bool? hasMore,
//     PlaylistCategory? category,
//   }) {
//     return PlaylistState(
//       hasMore: hasMore ?? this.hasMore,
//       isLoading: isLoading ?? this.isLoading,
//       playlists: playlists ?? this.playlists,
//       category: category ?? this.category,
//     );
//   }

//   @override
//   List<Object?> get props => [playlists, hasMore, isLoading, category];
// }
