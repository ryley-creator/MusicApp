part of 'track_bloc.dart';

enum TrackCategory { popular, trending, phonk }

class TrackEvent extends Equatable {
  const TrackEvent();

  @override
  List<Object> get props => [];
}

class FetchTracks extends TrackEvent {
  final TrackCategory category;
  const FetchTracks(this.category);
}

class FetchMoreTracks extends TrackEvent {
  final TrackCategory category;
  const FetchMoreTracks(this.category);
}
