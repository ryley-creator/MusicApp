// ignore_for_file: use_build_context_synchronously
import 'package:audio_app/bloc/download/download_bloc.dart';
import 'package:audio_app/bloc/favorite/favorite_bloc.dart';
import 'package:audio_app/imports/imports.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PlayerBottomSheet extends StatelessWidget {
  const PlayerBottomSheet({super.key});
  String format(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      builder: (context, controller) {
        return BlocConsumer<PlayerBloc, PlayerState>(
          listenWhen: (prev, curr) =>
              prev.downloadStatus != curr.downloadStatus &&
              curr.downloadStatus == DownloadStatus.success,
          listener: (context, state) {
            context.read<DownloadBloc>().add(ReloadDownload());
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Downloaded')));
          },
          builder: (context, state) {
            final track = state.currentTrack!;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 12),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(height: 24),
                  state.currentTrack!.image.isEmpty
                      ? Container(
                          height: 250,
                          width: 250,
                          color: Colors.grey.shade300,
                          child: Icon(Icons.note),
                        )
                      : CachedNetworkImage(
                          width: 250,
                          height: 250,
                          fit: BoxFit.cover,
                          imageUrl: state.currentTrack!.image,
                          errorWidget: (_, __, ___) => Container(
                            color: Colors.white,
                            width: 250,
                            height: 250,
                            child: Icon(Icons.music_note, size: 100),
                          ),
                        ),
                  SizedBox(height: 24),
                  Text(
                    state.currentTrack!.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    state.currentTrack!.artist,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(format(state.position)),
                        Text(format(state.duration - state.position)),
                      ],
                    ),
                  ),
                  Slider(
                    min: 0,
                    max: state.duration.inMilliseconds.toDouble().clamp(
                      1,
                      double.infinity,
                    ),
                    value: state.position.inMilliseconds
                        .clamp(0, state.duration.inMilliseconds)
                        .toDouble(),
                    onChanged: (value) {
                      // context.read<PlayerBloc>().add(
                      //   SeekTo(Duration(milliseconds: value.toInt())),
                      // );
                    },
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<DownloadBloc, DownloadState>(
                        builder: (context, state) {
                          final isDownloaded = state.isDownloaded(track.id);
                          if (isDownloaded) {
                            return const Icon(
                              Icons.download_done_rounded,
                              size: 35,
                            );
                          }
                          return IconButton(
                            icon: const Icon(Icons.download, size: 35),
                            onPressed: () {
                              context.read<PlayerBloc>().add(
                                DownloadCurrentTrack(),
                              );
                            },
                          );
                        },
                      ),
                      Row(
                        children: [
                          IconButton(
                            iconSize: 36,
                            icon: const Icon(Icons.skip_previous),
                            onPressed: () {
                              context.read<PlayerBloc>().add(PrevTrack());
                            },
                          ),
                          IconButton(
                            iconSize: 56,
                            icon: Icon(
                              state.status == PlayerStatus.playing
                                  ? Icons.pause
                                  : Icons.play_arrow,
                            ),
                            onPressed: () => context.read<PlayerBloc>().add(
                              TogglePlayPause(),
                            ),
                          ),
                          IconButton(
                            iconSize: 36,
                            icon: const Icon(Icons.skip_next),
                            onPressed: () {
                              context.read<PlayerBloc>().add(NextTrack());
                            },
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<FavoriteBloc>().add(AddFavorite(track));
                        },
                        icon: Icon(Icons.favorite),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
