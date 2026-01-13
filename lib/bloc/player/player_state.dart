part of 'player_bloc.dart';

enum PlayerStatus { intial, loading, paused, playing, completed }

class PlayerState extends Equatable {
  const PlayerState({
    this.currentIndex = 0,
    this.currentTrack,
    this.duration = Duration.zero,
    this.position = Duration.zero,
    this.queue = const [],
    this.status = PlayerStatus.intial,
  });

  final Track? currentTrack;
  final PlayerStatus status;
  final Duration duration;
  final Duration position;
  final int currentIndex;
  final List<Track> queue;

  PlayerState copyWith({
    Track? currentTrack,
    PlayerStatus? status,
    Duration? duration,
    Duration? position,
    int? currentIndex,
    List<Track>? queue,
  }) {
    return PlayerState(
      position: position ?? this.position,
      duration: duration ?? this.duration,
      currentIndex: currentIndex ?? this.currentIndex,
      currentTrack: currentTrack ?? this.currentTrack,
      status: status ?? this.status,
      queue: queue ?? this.queue,
    );
  }

  @override
  List<Object?> get props => [
    currentIndex,
    currentTrack,
    duration,
    position,
    queue,
    status,
  ];
}
