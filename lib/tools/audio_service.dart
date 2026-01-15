import 'package:audio_app/models/playlist.dart';
import 'package:audio_app/models/track.dart';
import 'package:dio/dio.dart';

class AppAudioService {
  static const String baseUrl = 'https://api.audius.co';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  Future<List<Track>> getTrendingTracks(int limit, int offset) async {
    try {
      final response = await _dio.get(
        '/v1/tracks/trending',
        queryParameters: {'limit': limit, 'offset': offset},
      );

      final List data = response.data['data'];
      return data.map((e) => Track.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<Track>> getPopularTracks(int limit, int offset) async {
    try {
      final response = await _dio.get(
        '/v1/tracks/recent-premium',
        queryParameters: {'limit': limit, 'offset': offset},
      );
      final List data = response.data['data'];
      return data.map((e) => Track.fromJson(e)).toList();
    } on DioException catch (error) {
      throw Exception('Error $error');
    }
  }

  String getStreamUrl(String trackId) {
    return '$baseUrl/v1/tracks/$trackId/stream';
  }

  Future<List<Playlist>> getTrendingPlaylists(int limit, int offset) async {
    final res = await _dio.get(
      '/v1/playlists/trending',
      queryParameters: {'limit': limit, 'offset': offset},
    );

    return (res.data['data'] as List).map((e) => Playlist.fromJson(e)).toList();
  }

  Future<List<Playlist>> getPopPlaylists(int limit, int offset) async {
    final response = await _dio.get(
      '/v1/playlists/search',
      queryParameters: {'limit': limit, 'offset': offset, 'query': 'pop'},
    );
    return (response.data['data'] as List)
        .map((e) => Playlist.fromJson(e))
        .toList();
  }

  Future<List<Playlist>> getRockPlaylists(int limit, int offset) async {
    final response = await _dio.get(
      '/v1/playlists/search',
      queryParameters: {'limit': limit, 'offset': offset, 'query': 'rock'},
    );
    return (response.data['data'] as List)
        .map((e) => Playlist.fromJson(e))
        .toList();
  }

  Future<List<Playlist>> getPhonkPlaylists(int limit, int offset) async {
    final response = await _dio.get(
      '/v1/playlists/search',
      queryParameters: {'limit': limit, 'offset': offset, 'query': 'funk'},
    );
    return (response.data['data'] as List)
        .map((e) => Playlist.fromJson(e))
        .toList();
  }

  Future<List<Playlist>> getKpopPlaylists(int limit, int offset) async {
    final response = await _dio.get(
      '/v1/playlists/search',
      queryParameters: {'limit': limit, 'offset': offset, 'query': 'kpop'},
    );
    return (response.data['data'] as List)
        .map((e) => Playlist.fromJson(e))
        .toList();
  }

  Future<List<Playlist>> getPopularPlaylists(int limit, int offset) async {
    final response = await _dio.get(
      '/v1/playlists/search',
      queryParameters: {'limit': limit, 'offset': offset, 'query': 'popular'},
    );
    return (response.data['data'] as List)
        .map((e) => Playlist.fromJson(e))
        .toList();
  }

  Future<List<Track>> getPlaylistTracks(
    String playlistId,
    int limit,
    int offset,
  ) async {
    final res = await _dio.get(
      '/v1/playlists/$playlistId/tracks',
      queryParameters: {'limit': limit, 'offset': offset},
    );

    return (res.data['data'] as List).map((e) => Track.fromJson(e)).toList();
  }
}
