import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' as ja;
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/colors.dart';
import '../model/Mood.dart';
import '../utils/Extensions/Commons.dart';

class AudioPlayComponent extends StatefulWidget {
  final Mood? data;
  final String? time;
  final String? audioUrl;
  final bool? isHome;

  AudioPlayComponent({this.data, this.time, this.audioUrl, this.isHome = false});

  @override
  _AudioPlayComponentState createState() => _AudioPlayComponentState();
}

class _AudioPlayComponentState extends State<AudioPlayComponent> {
  ja.AudioPlayer _player = ja.AudioPlayer();

  Duration duration = Duration();
  Duration position = Duration();
  double minValue = 0.0;
  bool isPlaying = false;
  String? audioUrl;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    if (widget.audioUrl != null && widget.audioUrl!.isNotEmpty) {
      audioUrl = widget.audioUrl;
      await _player.setUrl(audioUrl!, preload: true).then((value) {
        // log(value);
      }).catchError((e) {
        log(e.toString());
      });
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration?>(
      stream: _player.durationStream,
      builder: (context, snapshot) {
        final duration = snapshot.data ?? Duration.zero;
        return StreamBuilder<Duration>(
          stream: _player.positionStream,
          builder: (context, snap) {
            position = snap.data ?? Duration.zero;
            if (position > duration) {
              _player.seek(Duration(seconds: 0.0.toInt()));
              _player.pause().whenComplete(() => isPlaying = false);
            }
            return audioUrl == null
                ? CircularProgressIndicator().withHeight(25).withWidth(25).paddingAll(2)
                : Container(
                    height: 50,
                    decoration: boxDecorationWithShadowWidget(backgroundColor: widget.isHome == false ? cardColor : Colors.white, borderRadius: BorderRadius.all(Radius.circular(16))),
                    margin: EdgeInsets.all(2),
                    width: 50,
                    child: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  ).onTap(() async {
                    if (isPlaying) {
                      isPlaying = false;
                      setState(() {});
                      await _player.pause().catchError((e) {
                        toast(e.toString());
                      });
                    } else {
                      isPlaying = true;
                      setState(() {});
                      await _player.play().catchError(
                        (e) {
                          toast(e.toString());
                        },
                      );
                    }
                  });
          },
        );
      },
    );
  }
}
