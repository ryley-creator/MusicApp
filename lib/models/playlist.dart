class Playlist {
  final String? imageUrl;
  final String id;
  final String title;
  final String? description;
  final int trackCount;
  Playlist({
    required this.description,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.trackCount,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'],
      title: json['playlist_name'],
      description: json['description'],
      imageUrl: json['artwork']?['480x480'],
      trackCount: json['track_count'],
    );
  }
}
