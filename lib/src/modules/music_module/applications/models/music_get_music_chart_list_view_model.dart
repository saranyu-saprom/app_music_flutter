import '../../domains/entities/music_get_music_chart_list_entity.dart';

class MusicGetMusicChartListResponseBodyViewModel extends MusicGetMusicChartListResponseBodyEntity {
  const MusicGetMusicChartListResponseBodyViewModel({
    required List<MusicGetMusicChartListModelViewModel> data,
  })  : _data = data,
        super(data: data);

  final List<MusicGetMusicChartListModelViewModel> _data;

  @override
  List<MusicGetMusicChartListModelViewModel> get data => _data;
}

class MusicGetMusicChartListModelViewModel extends MusicGetMusicChartListModelEntity {
  const MusicGetMusicChartListModelViewModel({
    required super.songName,
    required super.artist,
    required super.img,
    required super.url,
  });
}
