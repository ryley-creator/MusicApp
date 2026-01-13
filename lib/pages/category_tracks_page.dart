import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../imports/imports.dart';

class CategoryTracksPage extends StatefulWidget {
  const CategoryTracksPage({
    super.key,
    required this.onPressed,
    required this.title,
  });
  final void Function()? onPressed;
  final String title;

  @override
  State<CategoryTracksPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryTracksPage> {
  final controller = ScrollController();
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels >
          controller.position.maxScrollExtent - 200) {
        context.read<TrackBloc>().add(FetchMoreTracks(TrackCategory.popular));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: widget.onPressed,
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(widget.title),
      ),
      body: BlocBuilder<TrackBloc, TrackState>(
        builder: (context, state) {
          if (state.isLoading && state.tracks.isEmpty) {
            return Center(
              child: LoadingAnimationWidget.newtonCradle(
                color: Colors.white,
                size: 100,
              ),
            );
          }
          return ListView.separated(
            controller: controller,
            itemBuilder: (context, index) {
              if (index == state.tracks.length) {
                return Center(child: CircularProgressIndicator());
              }
              return TrackTile(
                track: state.tracks[index],
                onTap: () {
                  context.read<PlayerBloc>().add(
                    PlayTrack(index, state.tracks, state.tracks[index]),
                  );
                },
              );
            },
            separatorBuilder: (_, __) => Divider(height: 1),
            itemCount: state.tracks.length + (state.hasMore ? 1 : 0),
          );
        },
      ),
    );
  }
}
