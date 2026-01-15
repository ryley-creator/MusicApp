part of 'download_bloc.dart';

class DownloadState extends Equatable {
  const DownloadState({this.isLoading = false, this.tracks = const []});
  final List<DownloadTrack> tracks;
  final bool isLoading;

  DownloadState copyWith({bool? isLoading, List<DownloadTrack>? tracks}) {
    return DownloadState(
      isLoading: isLoading ?? this.isLoading,
      tracks: tracks ?? this.tracks,
    );
  }

  bool isDownloaded(String trackId) {
    return tracks.any((t) => t.id == trackId);
  }

  @override
  List<Object> get props => [isLoading, tracks];
}
