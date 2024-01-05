import '../entities/music_get_music_list_entity.dart';

abstract class MusicRepository {
  Future<MusicGetMusicListResponseBodyEntity> getMusicList();
}
