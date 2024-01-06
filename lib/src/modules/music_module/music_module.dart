import 'package:get/get.dart';
import 'package:dio/dio.dart';

import 'applications/controllers/music_get_music_list_controller.dart';
import 'applications/controllers/music_list_controller.dart';
import 'music_impl_repository.dart';
import 'music_impl_usecase.dart';
import 'services/datasources/api_datasource.dart';

class MusicBinding implements Bindings {
  final MusicImplUseCase _usecase = MusicImplUseCase(
    repository: MusicImplRepository(
      restfulApiDataSource: ApiDataSource(http: Dio()),
    ),
  );

  MusicImplUseCase get usecase => _usecase;

  @override
  void dependencies() {
    Get.put<MusicListController>(
      MusicListController(),
    );
    Get.put<MusicGetMusicListController>(
      MusicGetMusicListController(usecase: _usecase),
    );
  }
}
