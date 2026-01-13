import 'package:audio_app/imports/imports.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({
    super.key,
    required this.category,
    required this.title,
    required this.onOpenPlaylist,
    required this.onPressed,
  });
  final PlaylistCategory category;
  final String title;
  final void Function(String playlistid, PlaylistCategory category)
  onOpenPlaylist;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(onPressed: onPressed, icon: Icon(Icons.arrow_back)),
      ),
      body: BlocBuilder<PlaylistBloc, PlaylistState>(
        builder: (context, state) {
          final playlists = state.playlists[category] ?? [];
          if (state.isLoading) {
            return Center(
              child: LoadingAnimationWidget.newtonCradle(
                color: Colors.white,
                size: 100,
              ),
            );
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: playlists.length,
            itemBuilder: (context, index) {
              return PlaylistBox(
                playlist: playlists[index],
                onTap: () {
                  final playlistId = playlists[index].id;
                  context.read<PlaylistTrackBloc>().add(
                    FetchPlaylistTracks(playlistId),
                  );
                  return onOpenPlaylist(playlistId, category);
                },
              );
            },
          );
        },
      ),
    );
  }
}
