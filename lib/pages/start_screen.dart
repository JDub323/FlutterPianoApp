import 'package:flutter/material.dart';
import 'package:flutter_application_1/dart_tools/piano_artist.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PianoKeyArtist.loadImages();
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Background_Image_1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Centered button
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/homeScreen');
              },
              child: const Text('Start!'),
            ),
          ),
        ],
      ),
    );
  }
}
