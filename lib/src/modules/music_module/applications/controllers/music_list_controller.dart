import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

enum Screen { homepage, chart, none }

class MusicListController extends GetxController {
  int _index = 0;
  bool _isPlay = false;
  String _urlPlaying = '';
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isLoop = false;
  bool _isShuffle = false;
  List _musicList = [];
  final Random _random = Random();
  int _randomSong = 0;
  Screen _screen = Screen.homepage;

  int get index => _index;

  bool get isPlay => _isPlay;

  String get urlPlaying => _urlPlaying;

  AudioPlayer get audioPlayer => _audioPlayer;

  Duration get duration => _duration;

  Duration get position => _position;

  bool get isLoop => _isLoop;

  bool get isShuffle => _isShuffle;

  List get musicList => _musicList;

  Screen get screen => _screen;

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

  void setMusicList({required List musicList}) {
    _musicList = musicList;

    update();
  }

  void playNextSong() {
    setIsPlay(isPlay: false);

    pauseAudio();

    setIndex(index: _index + 1);

    setIsPlay(isPlay: true);

    playAudio(url: _musicList[_index].url);

    update();
  }

  void playPreviousSong() {
    setIsPlay(isPlay: false);

    pauseAudio();

    setIndex(index: _index - 1);

    setIsPlay(isPlay: true);

    playAudio(url: _musicList[_index].url);

    update();
  }

  void playLastSong() {
    setIsPlay(isPlay: false);

    pauseAudio();

    setIndex(index: _musicList.length - 1);

    setIsPlay(isPlay: true);

    playAudio(url: _musicList[_index].url);

    update();
  }

  void playFirstSong() {
    setIsPlay(isPlay: false);

    pauseAudio();

    setIndex(index: 0);

    setIsPlay(isPlay: true);

    playAudio(url: _musicList[_index].url);

    update();
  }

  void onTapCanCel() {
    setIsPlay(isPlay: false);

    stopAudio();

    setIndex(index: 0);

    _urlPlaying = '';
    _position = Duration.zero;
    _duration = Duration.zero;

    update();
  }

  void onTapPlay() {
    if (_isPlay) {
      setIsPlay(isPlay: false);

      pauseAudio();
    } else {
      setIsPlay(isPlay: true);

      resumeAudio();
    }

    update();
  }

  void onTapSkip() {
    if (_index != _musicList.length - 1) {
      playNextSong();
    } else if (_index == _musicList.length - 1) {
      playFirstSong();
    }

    update();
  }

  void onTapPrevious() {
    if (_index != 0) {
      playPreviousSong();
    } else if (_index == 0) {
      playLastSong();
    }

    update();
  }

  void endSong() {
    if (_isShuffle == true) {
      playNextSongByShuffle();
    } else {
      if (_index != _musicList.length - 1) {
        playNextSong();
      } else if (_index == _musicList.length - 1) {
        playFirstSong();
      }
    }

    update();
  }

  void playNextSongByShuffle() {
    _randomSong = _random.nextInt(_musicList.length - 1);

    while (_randomSong == _index) {
      _randomSong = _random.nextInt(_musicList.length - 1);
    }

    setIsPlay(isPlay: false);

    pauseAudio();

    setIndex(index: _randomSong);

    setIsPlay(isPlay: true);

    playAudio(url: _musicList[_randomSong].url);

    update();
  }

  void onTapSong({required int index, required value}) {
    pauseAudio();

    setIndex(index: index);

    setIsPlay(isPlay: true);

    playAudio(url: value.url);

    getTotalTime();

    getPosition();

    update();
  }

  void setIsShuffle({required bool isShuffle}) {
    _isShuffle = isShuffle;

    update();
  }

  void setScreen({required Screen screen}) {
    _screen = screen;

    update();
  }
}
