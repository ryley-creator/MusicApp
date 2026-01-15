import 'package:audio_app/imports/imports.dart';
import 'package:equatable/equatable.dart';

part 'download_event.dart';
part 'download_state.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  DownloadBloc() : super(DownloadState()) {
    on<LoadDownloads>(onLoad);
    on<ReloadDownload>(onReload);
    on<DeleteTrack>(onDelete);
  }

  Future<void> onLoad(LoadDownloads event, Emitter<DownloadState> emit) async {
    emit(state.copyWith(isLoading: true));
    final tracks = await DownloadDb.getAll();
    emit(state.copyWith(tracks: tracks, isLoading: false));
  }

  Future<void> onReload(
    ReloadDownload event,
    Emitter<DownloadState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final tracks = await DownloadDb.getAll();
    emit(state.copyWith(tracks: List.from(tracks)));
  }

  Future<void> onDelete(DeleteTrack event, Emitter<DownloadState> emit) async {
    await DownloadDb.delete(event.track.id);
    final updatedTracks = state.tracks
        .where((e) => e.id != event.track.id)
        .toList();
    emit(state.copyWith(tracks: updatedTracks));
  }
}
