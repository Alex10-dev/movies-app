

import 'package:movies/domain/entities/video.dart';
import 'package:movies/infrastructure/models/themoviedb/movie_video_reponse.dart';

class VideoMapper {
  static Video videoInfoToEntity( VideoInformation videoInfo ) => Video(

    id: videoInfo.id, 
    key: videoInfo.key,
    site: videoInfo.site,
    size: videoInfo.size,
    type: videoInfo.type,
    url: videoInfo.key != '' 
      ? 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
      : 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
  );
}