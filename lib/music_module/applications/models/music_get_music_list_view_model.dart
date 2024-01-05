import '../../domains/entities/music_get_music_list_entity.dart';

class MusicGetMusicListResponseBodyViewModel extends MusicGetMusicListResponseBodyEntity {
  const MusicGetMusicListResponseBodyViewModel({
    required List<MusicGetMusicListModelViewModel> data,
  })  : _data = data,
        super(data: data);

  final List<MusicGetMusicListModelViewModel> _data;

  @override
  List<MusicGetMusicListModelViewModel> get data => _data;
}

class MusicGetMusicListModelViewModel extends MusicGetMusicListModelEntity {
  const MusicGetMusicListModelViewModel({
    required super.songName,
    required super.artist,
    required super.img,
    required super.url,
  });
}
