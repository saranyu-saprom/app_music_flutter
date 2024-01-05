import 'domains/entities/music_get_music_list_entity.dart';
import 'domains/repositories/music_repository.dart';
import 'domains/usecases/music_usecase.dart';

class MusicImplUseCase implements MusicUseCase {
  MusicImplUseCase({required MusicRepository repository}) : _repository = repository;

  final MusicRepository _repository;

  MusicRepository get repository => _repository;

  @override
  Future<MusicGetMusicListResponseBodyEntity> getMusicList() async {
    try {
      print('usecase');

      return await _repository.getMusicList();
    } catch (e) {
      rethrow;
    }
  }
}