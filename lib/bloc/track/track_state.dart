part of 'track_bloc.dart';

class TrackState extends Equatable {
  const TrackState({
    this.tracks = const [],
    this.isLoading = false,
    this.errorMessage,
    this.hasMore = false,
    this.category,
  });

  final List<Track> tracks;
  final bool isLoading;
  final bool hasMore;
  final String? errorMessage;
  final TrackCategory? category;

  TrackState copyWith({
    String? errorMessage,
    bool? isLoading,
    List<Track>? tracks,
    bool? hasMore,
    TrackCategory? category,
  }) {
    return TrackState(
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      tracks: tracks ?? this.tracks,
      hasMore: hasMore ?? this.hasMore,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [
    errorMessage,
    isLoading,
    tracks,
    hasMore,
    category,
  ];
}
