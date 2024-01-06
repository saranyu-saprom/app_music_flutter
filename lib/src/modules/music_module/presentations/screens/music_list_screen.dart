import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miniplayer/miniplayer.dart';

import '../../applications/controllers/music_get_music_list_controller.dart';
import '../../applications/controllers/music_list_controller.dart';
import '../../applications/models/music_get_music_list_view_model.dart';
import '../../applications/models/music_status_view_model.dart';
import '../../configs/contents/content_config.dart';
import '../../configs/contents/image_config.dart';
import '../widgets/music_box_widget.dart';
import '../widgets/music_full_screen_widget.dart';
import '../widgets/music_mini_widget.dart';
import 'music_chart_list_screen.dart';

class MusicListScreen extends StatelessWidget {
  MusicListScreen({Key? key}) : super(key: key);

  final MusicGetMusicListController _musicGetMusicListController =
      Get.find<MusicGetMusicListController>();
  final MusicListController _musicListController = Get.find<MusicListController>();

  List<Widget> _musicListWidget() {
    List<Widget> listOfMusic = [];

    _musicGetMusicListController.data?.data
        .asMap()
        .forEach((int index, MusicGetMusicListModelViewModel value) {
      listOfMusic.add(MusicBoxWidget(
        onTap: () {
          if (_musicGetMusicListController.data != null) {
            _musicListController.setMusicList(musicList: _musicGetMusicListController.data!.data);
          }
          _musicListController.onTapSong(index: index, value: value);
        },
        image: value.img,
        songName: value.songName,
        artist: value.artist,
        url: value.url,
      ));
    });

    return listOfMusic;
  }

  void _onTapPrevious() {
    _musicListController.onTapPrevious();
  }

  void _onTapPlay() {
    _musicListController.onTapPlay();
  }

  void _onTapSkip() {
    _musicListController.onTapSkip();
  }

  void _onTapCanCel() {
    _musicListController.onTapCanCel();
  }

  void _onTapLoop() {
    _musicListController.setIsLoop(isLoop: !_musicListController.isLoop);
  }

  void _getMusicList() async {
    await _musicGetMusicListController.getMusicList();
  }

  void _onTapShuffle() {
    _musicListController.setIsShuffle(isShuffle: !_musicListController.isShuffle);
  }

  Widget _musicChartWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: const Text(
            musicTopChartLabel,
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23, color: Colors.white),
          ),
        ),
        GestureDetector(
          onTap: () {
            _musicListController.setScreen(screen: Screen.chart);
          },
          child: Center(
            child: Container(
              width: double.infinity,
              height: 250,
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(bannerChartMusicUrl))),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
          child: const Text(
            musicYourPlaylistLabel,
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _homepageScreen({required BuildContext context}) {
    return Container(
      height: _musicListController.urlPlaying != ''
          ? MediaQuery.of(context).size.height - 100
          : MediaQuery.of(context).size.height,
      margin: _musicListController.urlPlaying != ''
          ? const EdgeInsets.only(bottom: 200)
          : const EdgeInsets.only(bottom: 0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_musicChartWidget(), ..._musicListWidget()],
        ),
      ),
    );
  }

  Widget _playerWidget({required BuildContext context}) {
    return _musicListController.urlPlaying != ''
        ? Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Miniplayer(
                minHeight: 200,
                maxHeight: MediaQuery.of(context).size.height,
                builder: (height, percentage) {
                  return height <= 200
                      ? MusicMiniWidget(
                          image: _musicListController.musicList[_musicListController.index].img,
                          songName:
                              _musicListController.musicList[_musicListController.index].songName,
                          onTapPrevious: () {
                            _onTapPrevious();
                          },
                          onTapPlay: () {
                            _onTapPlay();
                          },
                          onTapSkip: () {
                            _onTapSkip();
                          },
                          onTapCancel: () {
                            _onTapCanCel();
                          },
                          onTapLoop: () {
                            _onTapLoop();
                          },
                          onTapShuffle: () {
                            _onTapShuffle();
                          },
                        )
                      : MusicFullScreenWidget(
                          image: _musicListController.musicList[_musicListController.index].img,
                          songName:
                              _musicListController.musicList[_musicListController.index].songName,
                          artist: _musicListController.musicList[_musicListController.index].artist,
                          onTapPrevious: () {
                            _onTapPrevious();
                          },
                          onTapPlay: () {
                            _onTapPlay();
                          },
                          onTapSkip: () {
                            _onTapSkip();
                          },
                          onTapLoop: () {
                            _onTapLoop();
                          },
                          onTapShuffle: () {
                            _onTapShuffle();
                          },
                        );
                }),
          )
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MusicGetMusicListController>(
        init: _musicGetMusicListController,
        builder: (_) {
          return GetBuilder<MusicListController>(
              init: _musicListController,
              initState: (GetBuilderState<MusicListController> state) {
                _musicListController.startContinuousUpdate();
                _musicListController.playNextAudioAuto(endSong: _musicListController.endSong);
              },
              builder: (_) {
                if (_musicGetMusicListController.data == null &&
                    _musicGetMusicListController.status == MusicStatusViewModel.initial) {
                  _getMusicList();

                  return const Center(child: CircularProgressIndicator());
                }

                return Scaffold(
                  backgroundColor: Colors.black,
                  body: Stack(
                    children: [
                      if (_musicListController.screen == Screen.homepage)
                        _homepageScreen(context: context),
                      if (_musicListController.screen == Screen.chart) MusicChartListScreen(),
                      _playerWidget(context: context),
                    ],
                  ),
                );
              });
        });
  }
}
