part of 'player_bloc.dart';

enum PlayerStatus { intial, loading, paused, playing, completed }

enum DownloadStatus { initial, loading, success, error }

class PlayerState extends Equatable {
  const PlayerState({
    this.currentIndex = 0,
    this.currentTrack,
    this.duration = Duration.zero,
    this.position = Duration.zero,
    this.queue = const [],
    this.status = PlayerStatus.intial,
    this.downloadStatus = DownloadStatus.initial,
  });

  final Track? currentTrack;
  final PlayerStatus status;
  final Duration duration;
  final Duration position;
  final int currentIndex;
  final List<Track> queue;
  final DownloadStatus downloadStatus;

  PlayerState copyWith({
    Track? currentTrack,
    PlayerStatus? status,
    Duration? duration,
    Duration? position,
    int? currentIndex,
    List<Track>? queue,
    DownloadStatus? downloadStatus,
  }) {
    return PlayerState(
      position: position ?? this.position,
      duration: duration ?? this.duration,
      currentIndex: currentIndex ?? this.currentIndex,
      currentTrack: currentTrack ?? this.currentTrack,
      status: status ?? this.status,
      queue: queue ?? this.queue,
      downloadStatus: downloadStatus ?? this.downloadStatus,
    );
  }

  @override
  List<Object?> get props => [
    downloadStatus,
    currentIndex,
    currentTrack,
    duration,
    position,
    queue,
    status,
  ];
}
