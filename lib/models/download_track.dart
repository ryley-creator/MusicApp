class DownloadTrack {
  final String id;
  final String title;
  final String artist;
  final String filepath;
  final String image;

  DownloadTrack({
    required this.artist,
    required this.filepath,
    required this.id,
    required this.image,
    required this.title,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'artist': artist,
    'filePath': filepath,
    'artwork': image,
  };

  factory DownloadTrack.fromMap(Map<String, dynamic> map) {
    return DownloadTrack(
      id: map['id'],
      title: map['title'],
      artist: map['artist'],
      filepath: map['filePath'],
      image: map['artwork'],
    );
  }
}
