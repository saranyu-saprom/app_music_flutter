import 'package:app_music_saranyu_saprom/src/modules/music_module/services/models/music_get_music_chart_list_datasource_model.dart';

import 'domains/entities/music_get_music_chart_list_entity.dart';
import 'services/datasources/api_datasource.dart';
import 'services/models/music_get_music_list_datasource_model.dart';

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
      final MusicGetMusicListResponseBodyDataSourceModel response =
          await _restfulApiDataSource.getMusicList();

      return MusicGetMusicListResponseBodyEntity(
        data: response.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MusicGetMusicChartListResponseBodyEntity> getMusicChartList() async {
    try {
      final MusicGetMusicChartListResponseBodyDataSourceModel response =
          await _restfulApiDataSource.getMusicChartList();

      return MusicGetMusicChartListResponseBodyEntity(
        data: response.data,
      );
    } catch (e) {
      rethrow;
    }
  }
}
