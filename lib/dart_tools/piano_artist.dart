import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class PianoPainter extends CustomPainter {
  final List<bool> pressedKeys;
  static Color highlightedKeyColor = const Color.fromARGB(140, 227, 212, 3);
  static Color synthesiaBlockColor = const Color.fromARGB(255, 25, 104, 188);
  static Paint highlightedKeyPaint = Paint()..color = highlightedKeyColor;
  static Paint synthesiaBlockPaint = Paint()..color = synthesiaBlockColor;

  PianoPainter(this.pressedKeys) {
    if (!PianoKeyArtist.imagesAreLoaded()) {
      PianoKeyArtist.loadImages();
    }
  }

  //this is automatically called when setState() is called, so limit resetting states to
  //only when the pressed keys changes
  @override
  void paint(Canvas canvas, Size size) {
    double whiteKeyWidth = size.width / 52; // 52 white keys on a piano
    double blackKeyWidth = whiteKeyWidth * 0.6;
    double whiteKeyHeight = size.height;
    double blackKeyHeight = size.height * 0.6;
    double blackKeyOffset = whiteKeyWidth - .5 * blackKeyWidth;
    double secondaryOffsetMag =
        blackKeyWidth / 6; //offset of half of an 8-bit pixel

    // Draw white keys
    int keyNumber = 0;
    for (int whiteKey = 0; whiteKey < 52; whiteKey++) {
      Rect whiteKeyRect = Rect.fromLTWH(
          whiteKey * whiteKeyWidth, 0, whiteKeyWidth, whiteKeyHeight);
      PianoKeyArtist.drawWhiteKey(canvas, pressedKeys[keyNumber], whiteKeyRect);
      if (pressedKeys[keyNumber]) {
        canvas.drawRect(whiteKeyRect, highlightedKeyPaint);
      }
      keyNumber++;

      bool isBlackKey = (whiteKey % 7 != 1) && (whiteKey % 7 != 4);
      if (isBlackKey) {
        keyNumber++;
      }
      if (keyNumber >= 88) break;
    }

    keyNumber = 0;
    for (int whiteKey = 0; whiteKey < 52; whiteKey++) {
      keyNumber++;
      bool isBlackKey = (whiteKey % 7 != 1) &&
          (whiteKey % 7 != 4); //Avoid placing black keys on white notes E and B
      if (isBlackKey) {
        if (keyNumber >= 88) break; //prevents last black key from being placed

        double secondaryOffsetDir = 0;
        if (whiteKey % 7 == 0 || whiteKey % 7 == 3) {
          secondaryOffsetDir = 1;
        } else if (whiteKey % 7 == 2 || whiteKey % 7 == 5) {
          secondaryOffsetDir = -1;
        }

        Rect blackKeyRect = Rect.fromLTWH(
            whiteKey * whiteKeyWidth +
                blackKeyOffset +
                secondaryOffsetMag * secondaryOffsetDir,
            0,
            blackKeyWidth,
            blackKeyHeight);
        PianoKeyArtist.drawBlackKey(
            canvas, pressedKeys[keyNumber], blackKeyRect);
        if (pressedKeys[keyNumber]) {
          canvas.drawRect(blackKeyRect, highlightedKeyPaint);
        }
        keyNumber++;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PianoKeyArtist {
  static ui.Image? whiteKeyImage;
  static ui.Image? blackKeyImage;
  static Rect whiteKeyRect = const Rect.fromLTWH(0, 0, 40, 192);
  static Rect blackKeyRect = const Rect.fromLTWH(0, 0, 24, 120);

  static Future<void> loadImages() async {
    final ByteData data =
        await rootBundle.load('assets/images/White_Key_Pixel_HD.png');
    final Uint8List bytes = data.buffer.asUint8List();
    ui.decodeImageFromList(bytes, (ui.Image img) {
      whiteKeyImage = img;
    });
    final ByteData data1 =
        await rootBundle.load('assets/images/Black_Key_Pixel_HD.png');
    final Uint8List bytes1 = data1.buffer.asUint8List();
    ui.decodeImageFromList(bytes1, (ui.Image img) {
      blackKeyImage = img;
    });
  }

  static void drawWhiteKey(Canvas canvas, bool isDown, Rect keyLocation) {
    if (whiteKeyImage != null) {
      canvas.drawImageRect(whiteKeyImage!, whiteKeyRect, keyLocation, Paint());
    }
  }

  static void drawBlackKey(Canvas canvas, bool isDown, Rect keyLocation) {
    if (blackKeyImage != null) {
      canvas.drawImageRect(blackKeyImage!, blackKeyRect, keyLocation, Paint());
    }
  }

  static bool imagesAreLoaded() {
    return whiteKeyImage != null && blackKeyImage != null;
  }
}
