import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class MusicListController extends GetxController {
  int _index = 0;
  bool _isPlay = false;
  String _urlPlaying = '';
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isLoop = false;

  int get index => _index;

  bool get isPlay => _isPlay;

  String get urlPlaying => _urlPlaying;

  AudioPlayer get audioPlayer => _audioPlayer;

  Duration get duration => _duration;

  Duration get position => _position;

  bool get isLoop => _isLoop;

  void setIndex({required int index}) {
    _index = index;

    update();
  }

  void setIsPlay({required bool isPlay}) {
    _isPlay = isPlay;

    update();
  }

  void playAudio({required String url}) async {
    _audioPlayer.play(UrlSource(url));
    _urlPlaying = url;
    _position = Duration.zero;
    _duration = Duration.zero;

    update();
  }

  void close({required String url}) {
    _urlPlaying = url;
    _position = Duration.zero;
    _duration = Duration.zero;
  }

  void pauseAudio() {
    _audioPlayer.pause();

    update();
  }

  void resumeAudio() {
    _audioPlayer.resume();

    update();
  }

  void getTotalTime() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _duration = newDuration;
    });

    update();
  }

  void getPosition() {
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _position = newPosition;
    });

    update();
  }

  void startContinuousUpdate() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      update();
    });
  }

  void stopAudio() {
    _audioPlayer.stop();

    update();
  }

  void playNextAudioAuto({required void Function() endSong}) {
    _audioPlayer.onPlayerComplete.listen((event) {
      if (_isLoop == false) {
        endSong();
      }
    });

    update();
  }

  void setIsLoop({required bool isLoop}) {
    _isLoop = isLoop;

    if (_isLoop == true) {
      _audioPlayer.setReleaseMode(ReleaseMode.loop);
    } else {
      _audioPlayer.setReleaseMode(ReleaseMode.release);
    }

    update();
  }
}
