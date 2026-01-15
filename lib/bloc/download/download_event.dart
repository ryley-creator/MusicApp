part of 'download_bloc.dart';

class DownloadEvent extends Equatable {
  const DownloadEvent();

  @override
  List<Object> get props => [];
}

class LoadDownloads extends DownloadEvent {}

class ReloadDownload extends DownloadEvent {}

class DeleteTrack extends DownloadEvent {
  final Track track;
  const DeleteTrack(this.track);

  @override
  List<Object> get props => [track];
}
