import 'package:audio_app/models/download_track.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DownloadTrackTile extends StatelessWidget {
  const DownloadTrackTile({
    super.key,
    required this.onLongPress,
    required this.track,
    required this.onTap,
  });
  final DownloadTrack track;
  final void Function()? onTap;
  final Function()? onLongPress;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: onLongPress,
      onTap: onTap,
      leading: SizedBox(
        width: 56,
        height: 56,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CachedNetworkImage(
            imageUrl: track.image,
            fit: BoxFit.cover,
            errorWidget: (_, __, ___) => Container(
              color: Colors.grey[300],
              child: const Icon(Icons.music_note),
            ),
          ),
        ),
      ),
      title: Text(track.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        track.artist,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
