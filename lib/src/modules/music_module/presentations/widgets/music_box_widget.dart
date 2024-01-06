import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;

import '../../applications/controllers/music_list_controller.dart';
import '../../configs/contents/content_config.dart';

class MusicBoxWidget extends StatelessWidget {
  MusicBoxWidget(
      {super.key,
      required String image,
      required String songName,
      required String artist,
      required String url,
      required void Function() onTap})
      : _image = image,
        _songName = songName,
        _artist = artist,
        _url = url,
        _onTap = onTap;

  final String _image;
  final String _songName;
  final String _artist;
  final String _url;
  final void Function() _onTap;

  final MusicListController _musicListController = Get.find<MusicListController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black.withOpacity(0.8),
            ),
            child: ListTile(
                leading: Container(
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.only(left: 0, right: 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(_image))),
                ),
                title: Text(
                  _songName,
                  style: TextStyle(
                      color: _musicListController.urlPlaying == _url ? Colors.blue : Colors.white),
                ),
                subtitle: Text(
                  _artist,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w100),
                ),
                trailing: PopupMenuButton(
                  icon: const Icon(Icons.share, color: Colors.white),
                  color: Colors.white,
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: musicBoxWidgetImageLabel,
                      child: Text(musicBoxWidgetShareImageLabel),
                    ),
                    const PopupMenuItem(
                      value: musicBoxWidgetSongLabel,
                      child: Text(musicBoxWidgetShareSongLabel),
                    )
                  ],
                  onSelected: (String value) async {
                    if (value == musicBoxWidgetImageLabel) {
                      final uri = Uri.parse(_image);
                      final response = await http.get(uri);
                      final bytes = response.bodyBytes;

                      final temp = await getTemporaryDirectory();
                      final path = '${temp.path}/image.jpg';
                      File(path).writeAsBytesSync(bytes);

                      await Share.shareFiles([path]);
                    } else if (value == musicBoxWidgetSongLabel) {
                      await Share.share('$musicBoxWidgetShareSongTextLabel \n\n$_url');
                    }
                  },
                )),
          ),
          const Divider(
            color: Colors.white,
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}
