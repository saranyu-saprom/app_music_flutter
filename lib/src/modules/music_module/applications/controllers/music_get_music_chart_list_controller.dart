import 'package:get/get.dart';

import '../../domains/entities/music_get_music_chart_list_entity.dart';
import '../../music_impl_usecase.dart';
import '../models/music_get_music_chart_list_view_model.dart';
import '../models/music_status_view_model.dart';

class MusicGetMusicChartListController extends GetxController {
  MusicGetMusicChartListController({
    required MusicImplUseCase usecase,
  }) : _usecase = usecase;

  final MusicImplUseCase _usecase;

  MusicStatusViewModel _status = MusicStatusViewModel.initial;

  MusicGetMusicChartListResponseBodyViewModel? _data;

  MusicImplUseCase get usecase => _usecase;

  MusicStatusViewModel get status => _status;

  MusicGetMusicChartListResponseBodyViewModel? get data => _data;

  Future<void> getMusicList() async {
    try {
      _status = MusicStatusViewModel.loading;

      final MusicGetMusicChartListResponseBodyEntity response = await _usecase.getMusicChartList();

      _data = MusicGetMusicChartListResponseBodyViewModel(
        data: response.data
            .map((MusicGetMusicChartListModelEntity musicListModel) =>
                MusicGetMusicChartListModelViewModel(
                    songName: musicListModel.songName,
                    artist: musicListModel.artist,
                    img: musicListModel.img,
                    url: musicListModel.url))
            .toList(),
      );

      _status = MusicStatusViewModel.success;

      update();
    } catch (e) {
      _status = MusicStatusViewModel.failure;
      _data = null;

      update();
    }
  }
}
