import '../../domains/entities/music_get_music_chart_list_entity.dart';

class MusicGetMusicChartListResponseBodyDataSourceModel
    extends MusicGetMusicChartListResponseBodyEntity {
  const MusicGetMusicChartListResponseBodyDataSourceModel({
    required List<MusicGetMusicChartListModelDataSourceModel> data,
  })  : _data = data,
        super(data: data);

  final List<MusicGetMusicChartListModelDataSourceModel> _data;

  @override
  List<MusicGetMusicChartListModelDataSourceModel> get data => _data;
}

class MusicGetMusicChartListModelDataSourceModel extends MusicGetMusicChartListModelEntity {
  const MusicGetMusicChartListModelDataSourceModel({
    required super.songName,
    required super.artist,
    required super.img,
    required super.url,
  });
}
