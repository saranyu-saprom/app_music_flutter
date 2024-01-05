import 'package:app_music_saranyu_saprom/music_module/applications/models/music_status_view_model.dart';
import 'package:app_music_saranyu_saprom/music_module/presentations/widgets/music_box_widget.dart';
import 'package:app_music_saranyu_saprom/music_module/presentations/widgets/music_full_screen_widget.dart';
import 'package:app_music_saranyu_saprom/music_module/presentations/widgets/music_mini_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miniplayer/miniplayer.dart';

import '../../applications/controllers/music_get_music_list_controller.dart';
import '../../applications/controllers/music_list_controller.dart';
import '../../applications/models/music_get_music_list_view_model.dart';

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
          image: value.img,
          songName: value.songName,
          artist: value.artist,
          onTap: () {
            _musicListController.pauseAudio();

            _musicListController.setIndex(index: index);

            _musicListController.setIsPlay(isPlay: true);

            _musicListController.playAudio(url: value.url);

            _musicListController.getTotalTime();

            _musicListController.getPosition();

            _musicListController.playNextAudioAuto(endSong: _endSong);
          }));
    });

    return listOfMusic;
  }

  void _endSong() {
    if (_musicListController.index != _musicGetMusicListController.data!.data.length - 1) {
      _playNextSong();
    } else if (_musicListController.index == _musicGetMusicListController.data!.data.length - 1) {
      _playFirstSong();
    }
  }

  void _playPreviousSong() {
    _musicListController.setIsPlay(isPlay: false);

    _musicListController.pauseAudio();

    _musicListController.setIndex(index: _musicListController.index - 1);

    _musicListController.setIsPlay(isPlay: true);

    _musicListController.playAudio(
        url: _musicGetMusicListController.data!.data[_musicListController.index].url);
  }

  void _playLastSong() {
    _musicListController.setIsPlay(isPlay: false);

    _musicListController.pauseAudio();

    _musicListController.setIndex(index: _musicGetMusicListController.data!.data.length - 1);

    _musicListController.setIsPlay(isPlay: true);

    _musicListController.playAudio(
        url: _musicGetMusicListController.data!.data[_musicListController.index].url);
  }

  void _onTapPrevious() {
    if (_musicListController.index != 0) {
      _playPreviousSong();
    } else if (_musicListController.index == 0) {
      _playLastSong();
    }
  }

  void _onTapPlay() {
    if (_musicListController.isPlay) {
      _musicListController.setIsPlay(isPlay: false);

      _musicListController.pauseAudio();
    } else {
      _musicListController.setIsPlay(isPlay: true);

      _musicListController.resumeAudio();
    }
  }

  void _onTapSkip() {
    if (_musicListController.index != _musicGetMusicListController.data!.data.length - 1) {
      _playNextSong();
    } else if (_musicListController.index == _musicGetMusicListController.data!.data.length - 1) {
      _playFirstSong();
    }
  }

  void _onTapCanCel() {
    _musicListController.setIsPlay(isPlay: false);

    _musicListController.stopAudio();

    _musicListController.setIndex(index: 0);

    _musicListController.close(url: '');
  }

  void _onTapLoop() {
    _musicListController.setIsLoop(isLoop: !_musicListController.isLoop);
  }

  void _getMusicList() async {
    await _musicGetMusicListController.getMusicList();
  }

  void _playNextSong() {
    _musicListController.setIsPlay(isPlay: false);

    _musicListController.pauseAudio();

    _musicListController.setIndex(index: _musicListController.index + 1);

    _musicListController.setIsPlay(isPlay: true);

    _musicListController.playAudio(
        url: _musicGetMusicListController.data!.data[_musicListController.index].url);
  }

  void _playFirstSong() {
    _musicListController.setIsPlay(isPlay: false);

    _musicListController.pauseAudio();

    _musicListController.setIndex(index: 0);

    _musicListController.setIsPlay(isPlay: true);

    _musicListController.playAudio(
        url: _musicGetMusicListController.data!.data[_musicListController.index].url);
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
              },
              builder: (_) {
                if (_musicGetMusicListController.data == null &&
                    _musicGetMusicListController.status == MusicStatusViewModel.initial) {
                  _getMusicList();

                  return const CircularProgressIndicator();
                }

                return Scaffold(
                  backgroundColor: Colors.black,
                  body: Stack(
                    children: [
                      Container(
                        height: _musicListController.urlPlaying != ''
                            ? MediaQuery.of(context).size.height - 100
                            : MediaQuery.of(context).size.height,
                        margin: _musicListController.urlPlaying != ''
                            ? const EdgeInsets.only(bottom: 200)
                            : const EdgeInsets.only(bottom: 0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: _musicListWidget(),
                          ),
                        ),
                      ),
                      _musicListController.urlPlaying != ''
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
                                            image: _musicGetMusicListController
                                                .data!.data[_musicListController.index].img,
                                            songName: _musicGetMusicListController
                                                .data!.data[_musicListController.index].songName,
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
                                          )
                                        : MusicFullScreenWidget(
                                            image: _musicGetMusicListController
                                                .data!.data[_musicListController.index].img,
                                            songName: _musicGetMusicListController
                                                .data!.data[_musicListController.index].songName,
                                            artist: _musicGetMusicListController
                                                .data!.data[_musicListController.index].artist,
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
                                            onTapShuffle: () {},
                                          );
                                  }),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                );
              });
        });
  }
}
