import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../applications/controllers/music_list_controller.dart';
import '../../helpers/formate_time/format_time.dart';

class MusicFullScreenWidget extends StatelessWidget {
  MusicFullScreenWidget({
    super.key,
    required String image,
    required String songName,
    required String artist,
    required void Function() onTapPrevious,
    required void Function() onTapPlay,
    required void Function() onTapSkip,
    required void Function() onTapLoop,
    required void Function() onTapShuffle,
  })  : _image = image,
        _songName = songName,
        _artist = artist,
        _onTapPrevious = onTapPrevious,
        _onTapPlay = onTapPlay,
        _onTapSkip = onTapSkip,
        _onTapLoop = onTapLoop,
        _onTapShuffle = onTapShuffle;

  final String _image;
  final String _songName;
  final String _artist;
  final void Function() _onTapPrevious;
  final void Function() _onTapPlay;
  final void Function() _onTapSkip;
  final void Function() _onTapLoop;
  final void Function() _onTapShuffle;

  final MusicListController _musicListController =
      Get.put<MusicListController>(MusicListController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.black,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              width: 300,
              height: 250,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 150),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red,
                  image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(_image))),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              _songName,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              _artist,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(
              height: 30,
            ),
            Slider(
                min: 0,
                activeColor: Colors.white,
                max: _musicListController.duration.inSeconds.toDouble(),
                value: _musicListController.position.inSeconds.toDouble(),
                onChanged: (value) async {
                  final position = Duration(seconds: value.toInt());

                  _musicListController.audioPlayer.seek(position);

                  _musicListController.audioPlayer.resume();
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatTime(_musicListController.position),
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    formatTime(_musicListController.duration - _musicListController.position),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  color: Colors.white,
                  icon: const Icon(Icons.skip_previous),
                  iconSize: 40,
                  onPressed: () async {
                    _onTapPrevious();
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(_musicListController.isPlay ? Icons.pause : Icons.play_arrow),
                  iconSize: 40,
                  onPressed: () async {
                    _onTapPlay();
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  color: Colors.white,
                  icon: const Icon(Icons.skip_next),
                  iconSize: 40,
                  onPressed: () async {
                    _onTapSkip();
                  },
                ),
              ],
            ),
            // Container(
            //   padding: const EdgeInsets.all(16.0), // Adjust the padding for thickness
            //   child: IconButton(
            //     color: Colors.white,
            //     icon: const Icon(Icons.shuffle),
            //     iconSize: 40,
            //     onPressed: () async {
            //       _onTapShuffle();
            //     },
            //   ),
            // ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: IconButton(
                color: Colors.white,
                icon: Icon(_musicListController.isLoop ? Icons.repeat_one : Icons.repeat),
                iconSize: 40,
                onPressed: () async {
                  _onTapLoop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
