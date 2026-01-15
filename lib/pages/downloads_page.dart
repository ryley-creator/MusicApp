import 'package:audio_app/bloc/download/download_bloc.dart';

import '../imports/imports.dart';

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key, required this.onPressed});
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Downloads'),
        leading: IconButton(onPressed: onPressed, icon: Icon(Icons.arrow_back)),
      ),
      body: BlocBuilder<DownloadBloc, DownloadState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child: LoadingAnimationWidget.newtonCradle(
                color: Colors.white,
                size: 100,
              ),
            );
          }
          if (state.tracks.isEmpty) {
            return Center(
              child: Text(
                'No downloads yet...',
                style: TextStyle(fontSize: 23),
              ),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return DownloadTrackTile(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      actions: [
                        TextButton(
                          onPressed: () {
                            final t = state.tracks[index];
                            final track = Track(
                              id: t.id,
                              title: t.title,
                              artist: t.artist,
                              image: t.image,
                              audioUrl: t.filepath,
                            );
                            context.read<DownloadBloc>().add(
                              DeleteTrack(track),
                            );
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                      ],
                      content: Text('Do u really want to delete the music?'),
                    ),
                  );
                },
                track: state.tracks[index],
                onTap: () {
                  final t = state.tracks[index];
                  final track = Track(
                    id: t.id,
                    title: t.title,
                    artist: t.artist,
                    image: t.image,
                    audioUrl: t.filepath,
                  );
                  context.read<PlayerBloc>().add(PlayOffline(track));
                },
              );
            },
            itemCount: state.tracks.length,
          );
        },
      ),
    );
  }
}
