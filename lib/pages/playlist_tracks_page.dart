import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../imports/imports.dart';

class PlaylistTracksPage extends StatelessWidget {
  const PlaylistTracksPage({
    super.key,
    this.playlistId,
    required this.onPressed,
    required this.title,
  });
  final String? playlistId;
  final void Function() onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending'),
        leading: IconButton(onPressed: onPressed, icon: Icon(Icons.arrow_back)),
      ),
      body: BlocBuilder<PlaylistTrackBloc, PlaylistTrackState>(
        builder: (context, state) {
          if (state.isLoading && state.tracks.isEmpty) {
            return Center(
              child: LoadingAnimationWidget.newtonCradle(
                color: Colors.white,
                size: 100,
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => TrackTile(
                    track: state.tracks[index],
                    onTap: () {
                      context.read<PlayerBloc>().add(
                        PlayTrack(index, state.tracks, state.tracks[index]),
                      );
                    },
                  ),
                  itemCount: state.tracks.length,
                ),
              ),
              SizedBox(height: 80),
            ],
          );
        },
      ),
    );
  }
}
