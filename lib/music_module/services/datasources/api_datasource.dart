import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

import '../../../commons/constants/api_constant.dart';
import '../../../commons/constants/env_constant.dart';
import '../../domains/datasources/resful_datasource.dart';
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
      final Response<String> response = await _http.get(
        '${dotenv.env[musicApiUrlEnv]}$musicGetInformationApi',
        options: Options(
          headers: {"Content-Type": "application/json"},
          responseType: ResponseType.json,
        ),
      );

      List<Map<String, dynamic>> listOfMaps =
          List<Map<String, dynamic>>.from(json.decode(response.data!));

      return MusicGetMusicListResponseBodyDataSourceModel(
        data: listOfMaps
            .map((value) => MusicGetMusicListModelDataSourceModel(
                songName: value["songName"],
                artist: value["artist"],
                img: value["img"],
                url: value["url"]))
            .toList(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
