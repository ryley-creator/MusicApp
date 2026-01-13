import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../imports/imports.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.onOpenCategory,
    required this.onOpenPlaylist,
  });
  final void Function(TrackCategory category) onOpenCategory;
  final void Function(String playlistid) onOpenPlaylist;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          },
          icon: Icon(Icons.account_box),
        ),
        title: Text(
          'Music App',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
        ),
        actions: [Icon(Icons.notification_add), SizedBox(width: 10)],
      ),
      body: BlocBuilder<PlaylistBloc, PlaylistState>(
        builder: (context, state) {
          final trending = state.playlists[PlaylistCategory.trending] ?? [];
          final phonk = state.playlists[PlaylistCategory.phonk] ?? [];
          final popular = state.playlists[PlaylistCategory.popular] ?? [];
          if (state.isLoading && state.playlists.isEmpty) {
            return Center(
              child: LoadingAnimationWidget.newtonCradle(
                color: Colors.white,
                size: 100,
              ),
            );
          }
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            children: [
              Text(
                'Collections for you',
                style: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).textTheme.titleMedium!.color,
                ),
              ),
              SizedBox(height: 10),
              CategoryBox(
                text: 'Trending',
                onTap: () {
                  return onOpenCategory(TrackCategory.trending);
                },
              ),
              SizedBox(height: 10),
              CategoryBox(
                text: 'Phonk Songs',
                onTap: () => onOpenCategory(TrackCategory.phonk),
              ),
              SizedBox(height: 10),
              CategoryBox(
                text: 'Popular Songs',
                onTap: () => onOpenCategory(TrackCategory.popular),
              ),
              SizedBox(height: 15),
              Text(
                'Trending this week',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.titleMedium!.color,
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 185,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 15);
                  },
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return PlaylistBox(
                      playlist: trending[index],
                      onTap: () {
                        final playlistId = trending[index].id;
                        context.read<PlaylistTrackBloc>().add(
                          FetchPlaylistTracks(playlistId),
                        );
                        return onOpenPlaylist(playlistId);
                      },
                    );
                  },
                  itemCount: trending.length,
                ),
              ),
              Text(
                'Phonks for you',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.titleMedium!.color,
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 185,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 15);
                  },
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return PlaylistBox(
                      playlist: phonk[index],
                      onTap: () {
                        final playlistId = phonk[index].id;
                        context.read<PlaylistTrackBloc>().add(
                          FetchPlaylistTracks(playlistId),
                        );
                        return onOpenPlaylist(playlistId);
                      },
                    );
                  },
                  itemCount: phonk.length,
                ),
              ),
              Text(
                'Popular songs',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.titleMedium!.color,
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 185,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 15);
                  },
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return PlaylistBox(
                      playlist: popular[index],
                      onTap: () {
                        final playlistId = popular[index].id;
                        context.read<PlaylistTrackBloc>().add(
                          FetchPlaylistTracks(playlistId),
                        );
                        return onOpenPlaylist(playlistId);
                      },
                    );
                  },
                  itemCount: popular.length,
                ),
              ),
              SizedBox(height: 60),
            ],
          );
        },
      ),
    );
  }
}
