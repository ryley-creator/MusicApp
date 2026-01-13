import 'package:audio_app/models/track.dart';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AppAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final AudioPlayer _player = AudioPlayer();

  AppAudioHandler() {
    _player.playbackEventStream.listen(_broadcastState);
  }

  Future<void> playTrack(String url) async {
    await _player.setUrl(url);
    await _player.play();
  }

  void _broadcastState(PlaybackEvent event) {
    playbackState.add(
      PlaybackState(
        controls: [
          MediaControl.skipToPrevious,
          _player.playing ? MediaControl.pause : MediaControl.play,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        playing: _player.playing,
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[_player.processingState]!,
        updatePosition: _player.position,
      ),
    );
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> skipToNext() => _player.seekToNext();

  @override
  Future<void> skipToPrevious() => _player.seekToPrevious();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  Future<void> playQueue(List<Track> tracks, int index) async {
    final playlist = ConcatenatingAudioSource(
      children: tracks
          .map(
            (t) => AudioSource.uri(
              Uri.parse(t.audioUrl),
              tag: MediaItem(
                id: t.id,
                title: t.title,
                artist: t.artist,
                artUri: Uri.parse(t.image),
              ),
            ),
          )
          .toList(),
    );

    queue.add(
      tracks
          .map(
            (t) => MediaItem(
              id: t.id,
              title: t.title,
              artist: t.artist,
              artUri: Uri.parse(t.image),
            ),
          )
          .toList(),
    );

    await _player.setAudioSource(playlist, initialIndex: index);
    await _player.play();
  }
}
