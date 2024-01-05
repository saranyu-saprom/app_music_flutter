import 'package:flutter/material.dart';

class MusicBoxWidget extends StatelessWidget {
  const MusicBoxWidget(
      {super.key,
      required String image,
      required String songName,
      required String artist,
      required void Function() onTap})
      : _image = image,
        _songName = songName,
        _artist = artist,
        _onTap = onTap;

  final String _image;
  final String _songName;
  final String _artist;
  final void Function() _onTap;

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
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                _artist,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w100),
              ),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
