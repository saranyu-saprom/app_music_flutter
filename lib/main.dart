import 'package:app_music_saranyu_saprom/music_module/music_impl_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'music_module/applications/controllers/music_get_music_list_controller.dart';
import 'music_module/applications/controllers/music_list_controller.dart';
import 'music_module/configs/contents/content_config.dart';
import 'music_module/music_impl_usecase.dart';
import 'music_module/services/datasources/api_datasource.dart';
import 'music_module/presentations/screens/music_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final MusicImplUseCase musicUsecase = MusicImplUseCase(
    repository: MusicImplRepository(
      restfulApiDataSource: ApiDataSource(
        http: Dio(),
      ),
    ),
  );

  Get.put(MusicListController());
  Get.put<MusicGetMusicListController>(
    MusicGetMusicListController(
      usecase: musicUsecase,
    ),
  );

  loadEnvironment().then((_) {
    runApp(const MyApp());
  });
}

Future<void> loadEnvironment() async {
  await dotenv.load(fileName: '.env');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          backgroundColor: Colors.grey.shade900,
          appBar: AppBar(
            backgroundColor: const Color(0xFF222222),
            title: const Text(
              appBarMusicLabel,
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: MusicListScreen(),
        ));
  }
}
