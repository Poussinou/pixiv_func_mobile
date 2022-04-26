import 'package:pixiv_dart_api/model/illust.dart';

enum DownloadState {
  idle,
  downloading,
  failed,
  complete,
}

class DownloadTask {
  int id;
  Illust illust;
  String originalUrl;
  String url;
  String filename;
  double progress;
  DownloadState state;

  DownloadTask(this.id, this.illust, this.originalUrl, this.url, this.filename, this.progress, this.state);

  factory DownloadTask.create({
    required int id,
    required Illust illust,
    required String originalUrl,
    required String url,
    required String filename,
  }) =>
      DownloadTask(id, illust, originalUrl, url, filename, 0, DownloadState.idle);

  @override
  String toString() {
    return 'DownloadTask{uri: $url, filename: $filename, progress: $progress, state: $state}';
  }
}
