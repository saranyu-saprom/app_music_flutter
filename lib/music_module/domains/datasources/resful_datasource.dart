import '../../services/models/music_get_music_list_datasource_model.dart';

abstract class RestfulApiDataSource {
  Future<MusicGetMusicListResponseBodyDataSourceModel> getMusicList();
}
