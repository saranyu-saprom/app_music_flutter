import 'package:app_music_saranyu_saprom/music_module/services/datasources/api_datasource.dart';
import 'package:app_music_saranyu_saprom/music_module/services/models/music_get_music_list_datasource_model.dart';

import 'domains/entities/music_get_music_list_entity.dart';
import 'domains/repositories/music_repository.dart';

class MusicImplRepository implements MusicRepository {
  MusicImplRepository({
    required ApiDataSource restfulApiDataSource,
  }) : _restfulApiDataSource = restfulApiDataSource;

  final ApiDataSource _restfulApiDataSource;

  ApiDataSource get restfulApiDataSource => _restfulApiDataSource;

  @override
  Future<MusicGetMusicListResponseBodyEntity> getMusicList() async {
    try {
      print('repo');

      final MusicGetMusicListResponseBodyDataSourceModel response =
          await _restfulApiDataSource.getMusicList();

      return MusicGetMusicListResponseBodyEntity(
        data: response.data,
      );
    } catch (e) {
      rethrow;
    }
  }
}
