import 'dart:convert';
import 'package:dio/dio.dart';

import '../../domains/datasources/resful_datasource.dart';
import '../models/music_get_music_chart_list_datasource_model.dart';
import '../models/music_get_music_list_datasource_model.dart';

class ApiDataSource implements RestfulApiDataSource {
  ApiDataSource({
    required Dio http,
  }) : _http = http;

  final Dio _http;

  Dio get http => _http;

  @override
  Future<MusicGetMusicListResponseBodyDataSourceModel> getMusicList() async {
    try {
      //Note.Old API
      // final Response<String> response = await _http.get(
      //   '${dotenv.env[musicApiUrlEnv]}$musicGetInformationApi',
      //   options: Options(
      //     headers: {"Content-Type": "application/json"},
      //     responseType: ResponseType.json,
      //   ),
      // );

      //Note. New API
      final Response<String> response = await _http.get(
        'https://api.deezer.com/playlist/12231918251',
        options: Options(
          headers: {"Content-Type": "application/json"},
          responseType: ResponseType.json,
        ),
      );

      Map<String, dynamic> listOfMaps = Map<String, dynamic>.from(json.decode(response.data!));

      return MusicGetMusicListResponseBodyDataSourceModel(
        data: List<MusicGetMusicListModelDataSourceModel>.from(
          (listOfMaps["tracks"]["data"] as List<dynamic>).map((value) {
            return MusicGetMusicListModelDataSourceModel(
              songName: value["title"],
              artist: value["artist"]["name"],
              img: value["album"]["cover_big"],
              url: value["preview"],
            );
          }),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MusicGetMusicChartListResponseBodyDataSourceModel> getMusicChartList() async {
    try {
      final Response<String> response = await _http.get(
        'https://api.deezer.com/chart',
        options: Options(
          headers: {"Content-Type": "application/json"},
          responseType: ResponseType.json,
        ),
      );

      Map<String, dynamic> listOfMaps = Map<String, dynamic>.from(json.decode(response.data!));

      return MusicGetMusicChartListResponseBodyDataSourceModel(
        data: List<MusicGetMusicChartListModelDataSourceModel>.from(
          (listOfMaps["tracks"]["data"] as List<dynamic>).map((value) {
            return MusicGetMusicChartListModelDataSourceModel(
              songName: value["title"],
              artist: value["artist"]["name"],
              img: value["album"]["cover_big"],
              url: value["preview"],
            );
          }),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
