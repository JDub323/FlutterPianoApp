import 'dart:math';
import 'piano_artist.dart';

import 'package:flutter/material.dart';

class PianoWidget extends StatefulWidget {
  const PianoWidget({super.key});

  @override
  State<PianoWidget> createState() => _PianoWidgetState();
}

class _PianoWidgetState extends State<PianoWidget> {
  static const double pianoSlope = 4.6 /
      52.0; //derived from white keys being 4.6x wider than tall, piano 52 white keys wide

  PianoState pianoState = PianoState();
  List<bool> _previousPressedKeys = List.filled(88, false);

  void update(List<double> pianoKeyNoiseLevelsDB) {
    pianoState.update(pianoKeyNoiseLevelsDB);
    if (_previousPressedKeys != pianoState.getPressedKeys()) {
      //update the piano artist, a key has been played or released
    }
    _previousPressedKeys =
        pianoState.getPressedKeys(); //Pass by value/pointer logic errors here??
  }

  @override
  Widget build(BuildContext context) {
    double pianoWidth = MediaQuery.of(context).size.width;
    Size pianoSize = Size(pianoWidth, pianoWidth * pianoSlope);
    return CustomPaint(
      size: pianoSize,
      painter: PianoPainter(_previousPressedKeys),
    );
  }
}

class PianoState {
  static const List<int> blackKeyNumbers = [1, 4, 6, 9, 11];
  List<Key> piano = [];

  PianoState() {
    for (double n = 1; n <= 88; n++) {
      double frequency = pow(2, (n - 49) / 12).toDouble();
      int keyNumber = ((n - 1) % 12).floor();
      bool isBlack = blackKeyNumbers.contains(keyNumber);
      piano.add(Key(frequency, isBlack));
    }
  }

  List<bool> getPressedKeys() {
    List<bool> ret = [];
    for (Key key in piano) {
      ret.add(key.isDown());
    }
    return ret;
  }

  void update(List<double> pianoKeyNoiseLevelsDB) {
    //updates the dart internal piano to the list inputted
    //note that the previous piano states are saved in c++ at run time as an array of sound levels for each key,
    //and whole songs can be saved as custom files that give a (noise) level, press time, and release time to each keystroke
    //(all yet to be implemented)
    for (int i = 0; i < 88; i++) {
      piano[i].setVolume(pianoKeyNoiseLevelsDB[i]);
    }
  }
}

class Key {
  static const double quietestKeypress = 5; //filler number, adjust later
  double noiseLevelDB = 0;
  late double pitchHz;
  late bool isBlackKey;

  Key(this.pitchHz, this.isBlackKey);

  bool isDown() {
    return noiseLevelDB >= quietestKeypress;
  }

  void setVolume(double volumeDB) {
    noiseLevelDB = volumeDB;
  }
}
