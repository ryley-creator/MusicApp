import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class DownloadService {
  final Dio dio = Dio();

  Future<String> downloadTrack({
    required String url,
    required String filename,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final filepath = '${dir.path}/$filename.mp3';
    await dio.download(url, filepath);
    return filepath;
  }
}
