import 'package:audio_app/bloc/favorite/favorite_bloc.dart';
import 'package:audio_app/imports/imports.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key, required this.onPressed});
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        leading: IconButton(onPressed: onPressed, icon: Icon(Icons.arrow_back)),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
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
            return Center(child: Text('No Favorites yet...'));
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return TrackTile(track: state.tracks[index], onTap: () {});
            },
            itemCount: state.tracks.length,
          );
        },
      ),
    );
  }
}
