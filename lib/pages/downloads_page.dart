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
      body: FutureBuilder(
        future: DownloadDb.getAll(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: LoadingAnimationWidget.newtonCradle(
                color: Colors.white,
                size: 100,
              ),
            );
          }
          final tracks = snapshot.data!;
          if (tracks.isEmpty) {
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
                track: tracks[index],
                onTap: () {
                  final t = tracks[index];

                  final track = Track(
                    id: t.id,
                    title: t.title,
                    artist: t.artist,
                    image: t.image,
                    audioUrl: t.filepath,
                    // isOffline: true,
                  );
                  context.read<PlayerBloc>().add(PlayOffline(track));
                },
              );
            },
            itemCount: tracks.length,
          );
        },
      ),
    );
  }
}
