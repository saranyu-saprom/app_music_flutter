import '../entities/music_get_music_list_entity.dart';

abstract class MusicUseCase {
  Future<MusicGetMusicListResponseBodyEntity> getMusicList();
}
