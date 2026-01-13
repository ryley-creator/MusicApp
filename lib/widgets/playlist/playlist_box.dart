import 'package:audio_app/models/playlist.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PlaylistBox extends StatelessWidget {
  const PlaylistBox({super.key, required this.playlist, required this.onTap});
  final Playlist playlist;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: playlist.imageUrl ?? '',
                    width: 130,
                    height: 130,
                    errorWidget: (_, __, ___) => Container(
                      decoration: BoxDecoration(color: Colors.grey[800]),
                      child: Icon(Icons.music_note, size: 40),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: 130,
                  decoration: BoxDecoration(),
                  child: Text(
                    style: TextStyle(
                      color: Theme.of(context).textTheme.titleMedium!.color,
                    ),
                    playlist.title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
