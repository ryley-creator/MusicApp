// ignore_for_file: unreachable_switch_case

import 'package:audio_app/pages/category_page.dart';

import '../../imports/imports.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pageIndex = 0;
  int navIndex = 0;
  String categoryTitle = '';
  String playlistTitle = '';
  PlaylistCategory selectedPlaylistCategory = PlaylistCategory.phonk;
  bool isOpenedFromHome = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          IndexedStack(
            index: pageIndex,
            children: [
              HomePage(
                onOpenPlaylist: (playlistId) {
                  setState(() {
                    playlistTitle = 'PLaylist Name';
                    pageIndex = 4;
                    final bloc = context.read<PlaylistTrackBloc>();
                    if (bloc.state.tracks.isEmpty) {
                      bloc.add(FetchPlaylistTracks(playlistId));
                    }
                  });
                },
                onOpenCategory: (category) {
                  setState(() {
                    isOpenedFromHome = true;
                    pageIndex = 3;
                    navIndex = 0;
                    categoryTitle = switch (category) {
                      TrackCategory.trending => 'Trending',
                      TrackCategory.phonk => 'Phonk Songs',
                      TrackCategory.popular => 'Popular Songs',
                      _ => category.name,
                    };
                  });
                  final bloc = context.read<TrackBloc>();
                  if (bloc.state.tracks.isEmpty ||
                      bloc.state.category != category) {
                    bloc.add(FetchTracks(category));
                  }
                },
              ),
              SearchPage(
                onOpenCategory: (category, title) {
                  setState(() {
                    isOpenedFromHome = false;
                    pageIndex = 5;
                    navIndex = 1;
                    categoryTitle = title;
                    selectedPlaylistCategory = category;
                  });
                  final bloc = context.read<PlaylistBloc>();
                  bloc.add(FetchPlaylists(category));
                },
              ),
              Library(),
              CategoryTracksPage(
                title: categoryTitle,
                onPressed: () {
                  setState(() {
                    if (isOpenedFromHome) {
                      pageIndex = 0;
                      navIndex = 0;
                    } else {
                      pageIndex = 1;
                      navIndex = 1;
                    }
                  });
                },
              ),
              PlaylistTracksPage(
                title: playlistTitle,
                onPressed: () {
                  setState(() {
                    if (isOpenedFromHome) {
                      pageIndex = 0;
                      navIndex = 0;
                    } else {
                      pageIndex = 5;
                      navIndex = 1;
                    }
                  });
                },
              ),
              CategoryPage(
                onPressed: () {
                  setState(() {
                    pageIndex = 1;
                  });
                },
                category: selectedPlaylistCategory,
                title: categoryTitle,
                onOpenPlaylist: (playlistId, category) {
                  setState(() {
                    playlistTitle = categoryTitle;
                    pageIndex = 4;
                    final bloc = context.read<PlaylistTrackBloc>();
                    if (bloc.state.tracks.isEmpty) {
                      bloc.add(FetchPlaylistTracks(playlistId));
                    }
                  });
                },
              ),
            ],
          ),
          MiniPlayer(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        currentIndex: navIndex,
        onTap: (index) {
          setState(() {
            navIndex = index;
            pageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Library',
          ),
        ],
      ),
    );
  }
}
