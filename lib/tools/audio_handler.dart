import 'package:audio_app/imports/imports.dart';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AppAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final AudioPlayer player = AudioPlayer();

  AppAudioHandler() {
    player.playbackEventStream.listen(broadcastState);
    player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        skipToNext();
      }
    });
  }

  void broadcastState(PlaybackEvent event) {
    playbackState.add(
      playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          player.playing ? MediaControl.pause : MediaControl.play,
          MediaControl.skipToNext,
        ],
        playing: player.playing,
        processingState: AudioProcessingState.ready,
        updatePosition: player.position,
      ),
    );
  }

  Future<void> playOffline(String path, Track track) async {
    final duration = await player.setFilePath(path);
    mediaItem.add(
      MediaItem(
        id: track.id,
        title: track.title,
        artist: track.artist,
        artUri: Uri.parse(track.image),
        duration: duration,
      ),
    );
    await player.setFilePath(path);
    await player.play();
  }

  Future<void> playTrack(String url, Track track) async {
    final duration = await player.setUrl(url);
    mediaItem.add(
      MediaItem(
        id: track.id,
        title: track.title,
        artist: track.artist,
        artUri: Uri.parse(track.image),
        duration: duration,
      ),
    );
    await player.setUrl(url);
    await player.play();
  }

  @override
  Future<void> play() => player.play();

  @override
  Future<void> pause() => player.pause();

  @override
  Future<void> skipToNext() async {}

  @override
  Future<void> skipToPrevious() async {}
}
