import 'package:flutter/material.dart';
import 'package:flutter_application_1/dart_tools/piano_widget.dart';

class Synthesia extends StatelessWidget {
  const Synthesia({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PianoWidget(),
        ],
      ),
    );
  }
}
