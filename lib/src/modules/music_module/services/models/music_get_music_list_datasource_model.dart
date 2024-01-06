import '../../domains/entities/music_get_music_list_entity.dart';

class MusicGetMusicListResponseBodyDataSourceModel extends MusicGetMusicListResponseBodyEntity {
  const MusicGetMusicListResponseBodyDataSourceModel({
    required List<MusicGetMusicListModelDataSourceModel> data,
  })  : _data = data,
        super(data: data);

  final List<MusicGetMusicListModelDataSourceModel> _data;

  @override
  List<MusicGetMusicListModelDataSourceModel> get data => _data;
}

class MusicGetMusicListModelDataSourceModel extends MusicGetMusicListModelEntity {
  const MusicGetMusicListModelDataSourceModel({
    required super.songName,
    required super.artist,
    required super.img,
    required super.url,
  });
}
