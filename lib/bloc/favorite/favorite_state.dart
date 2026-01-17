part of 'favorite_bloc.dart';

class FavoriteState extends Equatable {
  const FavoriteState({this.isLoading = false, this.tracks = const []});
  final bool isLoading;
  final List<Track> tracks;

  FavoriteState copyWith({bool? isLoading, List<Track>? tracks}) {
    return FavoriteState(
      isLoading: isLoading ?? this.isLoading,
      tracks: tracks ?? this.tracks,
    );
  }

  @override
  List<Object> get props => [tracks, isLoading];
}
