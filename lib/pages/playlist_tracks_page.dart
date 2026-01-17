import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../imports/imports.dart';

class PlaylistTracksPage extends StatelessWidget {
  const PlaylistTracksPage({
    super.key,
    this.playlistId,
    required this.onPressed,
    required this.title,
    required this.image,
  });
  final String? playlistId;
  final void Function() onPressed;
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistTrackBloc, PlaylistTrackState>(
      builder: (context, state) {
        if (state.isLoading && state.tracks.isEmpty) {
          return Scaffold(
            body: Center(
              child: LoadingAnimationWidget.newtonCradle(
                color: Colors.white,
                size: 100,
              ),
            ),
          );
        }
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                expandedHeight: 300,
                toolbarHeight: 60,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/image.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(title),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => TrackTile(
                    track: state.tracks[index],
                    onTap: () {
                      context.read<PlayerBloc>().add(
                        PlayTrack(index, state.tracks, state.tracks[index]),
                      );
                    },
                  ),
                  childCount: state.tracks.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
