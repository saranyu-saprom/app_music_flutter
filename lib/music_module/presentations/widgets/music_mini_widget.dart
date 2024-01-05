import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../applications/controllers/music_list_controller.dart';
import '../../helpers/formate_time/format_time.dart';

class MusicMiniWidget extends StatelessWidget {
  MusicMiniWidget({
    super.key,
    required String image,
    required String songName,
    required void Function() onTapPrevious,
    required void Function() onTapPlay,
    required void Function() onTapSkip,
    required void Function() onTapCancel,
  })  : _image = image,
        _songName = songName,
        _onTapPrevious = onTapPrevious,
        _onTapPlay = onTapPlay,
        _onTapSkip = onTapSkip,
        _onTapCancel = onTapCancel;

  final String _image;
  final String _songName;
  final void Function() _onTapPrevious;
  final void Function() _onTapPlay;
  final void Function() _onTapSkip;
  final void Function() _onTapCancel;

  final MusicListController _musicListController = Get.find<MusicListController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MusicListController>(
        init: _musicListController,
        builder: (_) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: (15),
                horizontal: (15),
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF222222),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              margin: const EdgeInsets.only(left: 0, right: 0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.red,
                                  image: DecorationImage(
                                      fit: BoxFit.cover, image: NetworkImage(_image))),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    _songName,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Slider(
                                      activeColor: Colors.white,
                                      min: 0,
                                      max: _musicListController.duration.inSeconds.toDouble(),
                                      value: _musicListController.position.inSeconds.toDouble(),
                                      onChanged: (value) async {
                                        final position = Duration(seconds: value.toInt());
                                        await _musicListController.audioPlayer.seek(position);

                                        await _musicListController.audioPlayer.resume();
                                      }),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          formatTime(_musicListController.position),
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          formatTime(_musicListController.duration -
                                              _musicListController.position),
                                          style: const TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              color: Colors.white,
                              icon: const Icon(Icons.cancel),
                              iconSize: 25,
                              onPressed: () async {
                                _onTapCancel();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          color: Colors.white,
                          icon: const Icon(Icons.skip_previous),
                          iconSize: 25,
                          onPressed: () async {
                            _onTapPrevious();
                          },
                        ),
                        IconButton(
                          color: Colors.white,
                          icon: Icon(_musicListController.isPlay ? Icons.pause : Icons.play_arrow),
                          iconSize: 25,
                          onPressed: () async {
                            _onTapPlay();
                          },
                        ),
                        IconButton(
                          color: Colors.white,
                          icon: const Icon(Icons.skip_next),
                          iconSize: 25,
                          onPressed: () async {
                            _onTapSkip();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
