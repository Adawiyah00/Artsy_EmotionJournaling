import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/int_extensions.dart';
import 'package:record/record.dart';

import '../utils/Extensions/text_styles.dart';
import '../utils/colors.dart';

class AudioRecorder extends StatefulWidget {
  final void Function(String path) onStop;

  const AudioRecorder({required this.onStop});

  @override
  _AudioRecorderState createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  bool _isRecording = false;
  bool _isPaused = false;
  int _recordDuration = 0;
  Timer? _timer;
  Timer? _ampTimer;
  final _audioRecorder = Record();
  double _width = 50;
  double _height = 50;
  double recorderTimerWidth = 0.0;

  @override
  void initState() {
    _isRecording = false;
    super.initState();
  }

  Future<void> _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        // We don't do anything with this but printing
        final isSupported = await _audioRecorder.isEncoderSupported(
          AudioEncoder.aacLc,
        );
        if (kDebugMode) {
          print('${AudioEncoder.aacLc.name} supported: $isSupported');
        }
        await _audioRecorder.start();

        bool isRecording = await _audioRecorder.isRecording();
        setState(() {
          _isRecording = isRecording;
          _recordDuration = 0;
        });

        _startTimer();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _pause() async {
    _timer?.cancel();
    _ampTimer?.cancel();
    await _audioRecorder.pause();

    setState(() => _isPaused = true);
  }

  Future<void> _resume() async {
    _startTimer();
    await _audioRecorder.resume();

    setState(() => _isPaused = false);
  }

  void _startTimer() {
    _timer?.cancel();
    _ampTimer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });

    _ampTimer = Timer.periodic(
      const Duration(milliseconds: 200),
      (Timer t) async {
        setState(() {});
      },
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }

  Future<void> _stop() async {
    _timer?.cancel();
    _ampTimer?.cancel();
    final path = await _audioRecorder.stop();

    widget.onStop(path!);
    setState(() {
      _isRecording = false;
      _audioRecorder.stop();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ampTimer?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  Widget _buildRecordStopControl() {
    late Icon icon;

    if (_isRecording || _isPaused) {
      icon = const Icon(Icons.play_arrow, size: 22);
    } else {
      icon = Icon(Icons.mic, size: 25);
    }

    return Container(
      width: _width,
      height: _height,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: cardColor, shape: BoxShape.circle),
      child: GestureDetector(
        child: icon,
        onTap: () {
          if (_isRecording || _isPaused) {
            if (_isPaused) {
              _resume();
            }
            recorderTimerWidth = 0;
            _stop();
          } else {
            recorderTimerWidth = context.width() - 90;
            _start();
          }
        },
      ),
    );
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);

    return Text('$minutes : $seconds', style: secondaryTextStyle(size: 16, color: Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildRecordStopControl(),
        Row(
          children: [
            8.width,
            AnimatedContainer(
              decoration: boxDecorationWithShadowWidget(borderRadius: radius(24), backgroundColor: cardColor),
              padding: EdgeInsets.only(bottom: 2, top: 4),
              duration: Duration(milliseconds: 1500),
              width: recorderTimerWidth,
              height: 54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  16.width,
                  GestureDetector(
                    onTap: () async {
                      await _audioRecorder.dispose();
                      setState(() {
                        recorderTimerWidth = 0;
                        _isRecording = false;
                      });
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      alignment: Alignment.center,
                      // decoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle),
                      child: Icon(Icons.close),
                    ),
                  ),
                  16.width,
                  Icon(Icons.mic_none, size: 20),
                  8.width,
                  _buildTimer(),
                  16.width.expand(),
                  GestureDetector(
                    onTap: () {
                      _isPaused ? _resume() : _pause();
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      alignment: Alignment.center,
                      // decoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle),
                      child: Icon(!_isPaused ? Icons.pause : Icons.play_arrow),
                    ),
                  ),
                  16.width,
                ],
              ),
            ).visible(_isRecording),
          ],
        ).expand(),
      ],
    );
  }
}
