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
    image: data['artwork']['150x150'] ?? '',
    title: data['title'] ?? 'Unknown',
  );
}
