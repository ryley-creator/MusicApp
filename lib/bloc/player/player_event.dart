part of 'player_bloc.dart';

class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object> get props => [];
}

class PlayTrack extends PlayerEvent {
  final Track track;
  final int index;
  final List<Track> queue;
  const PlayTrack(this.index, this.queue, this.track);

  @override
  List<Object> get props => [queue, index, track];
}

class SeekTo extends PlayerEvent {}

class TogglePlayPause extends PlayerEvent {}

class NextTrack extends PlayerEvent {}

class PrevTrack extends PlayerEvent {}

class PlaybackStatusChanged extends PlayerEvent {
  final PlayerStatus status;
  const PlaybackStatusChanged(this.status);
}

class PlaybackStateChanged extends PlayerEvent {
  final PlaybackState playbackState;
  const PlaybackStateChanged(this.playbackState);
}
