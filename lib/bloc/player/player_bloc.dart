import 'package:audio_app/models/track.dart';
import 'package:audio_app/tools/audio_handler.dart';
import 'package:audio_service/audio_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc(this.audioHandler) : super(PlayerState()) {
    on<PlayTrack>(onPlayTrack);
    on<TogglePlayPause>(onTogglePlayPause);
    on<PrevTrack>(onPrev);
    on<NextTrack>(onNext);
    on<PlaybackStateChanged>(onPlaybackChanged);
    audioHandler.playbackState.listen((state) {
      add(PlaybackStateChanged(state));
    });
  }
  final AppAudioHandler audioHandler;

  Future<void> playAtIndex(int index, Emitter<PlayerState> emit) async {
    final track = state.queue[index];
    emit(
      state.copyWith(
        status: PlayerStatus.loading,
        currentTrack: track,
        currentIndex: index,
      ),
    );
    await audioHandler.playTrack(track.audioUrl);
    emit(state.copyWith(status: PlayerStatus.playing));
  }

  void onPlaybackChanged(
    PlaybackStateChanged event,
    Emitter<PlayerState> emit,
  ) {
    final playing = event.playbackState.playing;

    emit(
      state.copyWith(
        status: playing ? PlayerStatus.playing : PlayerStatus.paused,
        position: event.playbackState.position,
      ),
    );
  }

  Future<void> onPlayTrack(PlayTrack event, Emitter<PlayerState> emit) async {
    emit(state.copyWith(queue: event.queue, currentIndex: event.index));
    await playAtIndex(event.index, emit);
  }

  Future<void> onTogglePlayPause(
    TogglePlayPause event,
    Emitter<PlayerState> emit,
  ) async {
    final playing = audioHandler.playbackState.value.playing;
    if (playing) {
      await audioHandler.pause();
    } else {
      await audioHandler.play();
    }
  }

  Future<void> onNext(NextTrack event, Emitter<PlayerState> emit) async {
    if (state.currentIndex + 1 >= state.queue.length) return;

    await playAtIndex(state.currentIndex + 1, emit);
  }

  Future<void> onPrev(PrevTrack event, Emitter<PlayerState> emit) async {
    if (state.currentIndex == 0) return;

    await playAtIndex(state.currentIndex - 1, emit);
  }
}
