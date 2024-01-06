import 'package:equatable/equatable.dart';

class MusicGetMusicListResponseBodyEntity extends Equatable {
  const MusicGetMusicListResponseBodyEntity({
    required List<MusicGetMusicListModelEntity> data,
  }) : _data = data;

  final List<MusicGetMusicListModelEntity> _data;

  List<MusicGetMusicListModelEntity> get data => _data;

  @override
  List<Object?> get props => <Object>[_data];
}

class MusicGetMusicListModelEntity extends Equatable {
  const MusicGetMusicListModelEntity({
    required String songName,
    required String artist,
    required String img,
    required String url,
  })  : _songName = songName,
        _artist = artist,
        _img = img,
        _url = url;

  final String _songName;
  final String _artist;
  final String _img;
  final String _url;

  String get songName => _songName;

  String get artist => _artist;

  String get img => _img;

  String get url => _url;

  @override
  List<Object?> get props => <Object>[
        _songName,
        _artist,
        _img,
        _url,
      ];
}
