import '../entities/music_get_music_chart_list_entity.dart';
import '../entities/music_get_music_list_entity.dart';

abstract class MusicUseCase {
  Future<MusicGetMusicListResponseBodyEntity> getMusicList();

  Future<MusicGetMusicChartListResponseBodyEntity> getMusicChartList();
}
