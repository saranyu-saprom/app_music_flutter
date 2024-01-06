import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../applications/controllers/music_get_music_chart_list_controller.dart';
import '../../applications/controllers/music_list_controller.dart';
import '../../applications/models/music_get_music_chart_list_view_model.dart';
import '../../applications/models/music_status_view_model.dart';
import '../../configs/contents/content_config.dart';
import '../widgets/music_box_widget.dart';

class MusicChartListScreen extends StatelessWidget {
  MusicChartListScreen({Key? key}) : super(key: key);

  final MusicGetMusicChartListController _musicGetMusicChartListController =
      Get.find<MusicGetMusicChartListController>();
  final MusicListController _musicListController = Get.find<MusicListController>();

  List<Widget> _musicListWidget() {
    List<Widget> listOfMusic = [];

    _musicGetMusicChartListController.data?.data
        .asMap()
        .forEach((int index, MusicGetMusicChartListModelViewModel value) {
      listOfMusic.add(MusicBoxWidget(
          image: value.img,
          songName: value.songName,
          artist: value.artist,
          url: value.url,
          onTap: () {
            if (_musicGetMusicChartListController.data != null) {
              _musicListController.setMusicList(
                  musicList: _musicGetMusicChartListController.data!.data);
            }

            _musicListController.onTapSong(index: index, value: value);
          }));
    });

    return listOfMusic;
  }

  void _getMusicChartList() async {
    await _musicGetMusicChartListController.getMusicList();
  }

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 30,
          onPressed: () async {
            _musicListController.setScreen(screen: Screen.homepage);
          },
        ),
        Container(
          padding: const EdgeInsets.only(left: 0),
          child: const Text(
            musicTopChartLabel,
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23, color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MusicGetMusicChartListController>(
        init: _musicGetMusicChartListController,
        builder: (_) {
          if (_musicGetMusicChartListController.data == null &&
              _musicGetMusicChartListController.status == MusicStatusViewModel.initial) {
            _getMusicChartList();

            return const Center(child: CircularProgressIndicator());
          }

          return Container(
            height: _musicListController.urlPlaying != ''
                ? MediaQuery.of(context).size.height - 100
                : MediaQuery.of(context).size.height,
            margin: _musicListController.urlPlaying != ''
                ? const EdgeInsets.only(bottom: 200)
                : const EdgeInsets.only(bottom: 0),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.black,
                  pinned: true,
                  flexibleSpace: _appBar(),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Column(
                        children: _musicListWidget(),
                      );
                    },
                    childCount: 1,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
