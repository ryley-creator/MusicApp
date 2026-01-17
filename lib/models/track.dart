class Track {
  final String audioUrl;
  final String image;
  final String id;
  final String title;
  final String artist;

  Track({
    required this.artist,
    required this.audioUrl,
    required this.id,
    required this.image,
    required this.title,
  });

  factory Track.fromJson(Map<String, dynamic> data) => Track(
    artist: data['user']?['name'] ?? 'Unknown artist',
    audioUrl:
        'https://discoveryprovider.audius.co/v1/tracks/${data['id']}/stream',
    id: data['id'],
    image: data['artwork']?['150x150'] ?? '',
    title: data['title'] ?? 'Unknown',
  );

  factory Track.fromMap(Map<String, dynamic> map) => Track(
    id: map['id'],
    title: map['title'],
    artist: map['artist'],
    image: map['image'] ?? '',
    audioUrl:
        'https://discoveryprovider.audius.co/v1/tracks/${map['id']}/stream',
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'image': image,
    'title': title,
    'artist': artist,
  };
}
