import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton.filled(
              style: IconButton.styleFrom(backgroundColor: Colors.cyan),
              onPressed: () {
                Navigator.pushNamed(context, '/shopScreen');
              },
              icon: const Icon(Icons.diamond_outlined, color: Colors.white),
            ),
            IconButton.outlined(
              onPressed: () {
                Navigator.pushNamed(context, '/settingsScreen');
              },
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
      ),
      body: const CustomButtonColumn(),
    );
  }
}

class CustomButtonColumn extends StatefulWidget {
  const CustomButtonColumn({super.key});

  @override
  CustomButtonColumnState createState() => CustomButtonColumnState();
}

class CustomButtonColumnState extends State<CustomButtonColumn> {
  bool _topIsExpanded = false;
  bool _bottomIsExpanded = false;
  static const int durationMS = 300;

  void _toggleTop() {
    setState(() {
      _topIsExpanded = !_topIsExpanded;
      _bottomIsExpanded = false;
    });
  }

  void _toggleBottom() {
    setState(() {
      _bottomIsExpanded = !_bottomIsExpanded;
      _topIsExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.65; // 80% of screen width
    const buttonHeight = 60.0; // Fixed height for buttons
    final smallButtonWidth = screenWidth * .5;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _toggleTop,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(buttonWidth, buttonHeight),
          ),
          child: const Text('Sight Reading'),
        ),
        const SizedBox(height: 20), // Space between buttons
        AnimatedContainer(
          duration: const Duration(milliseconds: durationMS),
          curve: Curves.easeInOut,
          height: _topIsExpanded ? 180 : 0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/customPracticeOptionSelectScreen');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(smallButtonWidth, buttonHeight),
                  ),
                  child: const Text('Practice'),
                ),
                const SizedBox(height: 10), // Space between buttons
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(smallButtonWidth, buttonHeight),
                  ),
                  child: const Text('Game'),
                ),
                const SizedBox(height: 10), // Space between buttons
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(smallButtonWidth, buttonHeight),
                  ),
                  child: const Text('Daily Game'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20), // Space between buttons
        ElevatedButton(
          onPressed: _toggleBottom,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(buttonWidth, buttonHeight),
          ),
          child: const Text('Song Listening'),
        ),
        const SizedBox(height: 20), // Space between buttons
        AnimatedContainer(
          duration: const Duration(milliseconds: durationMS),
          curve: Curves.easeInOut,
          height: _bottomIsExpanded ? 180 : 0,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(smallButtonWidth, buttonHeight),
                  ),
                  child: const Text('Recently Played: (put song here)'),
                ),
                const SizedBox(height: 10), // Space between buttons
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(smallButtonWidth, buttonHeight),
                  ),
                  child: const Text('Song Selection'),
                ),
                const SizedBox(height: 10), // Space between buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/synthesia');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(smallButtonWidth, buttonHeight),
                  ),
                  child: const Text('Synthesia'),
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: durationMS),
          curve: Curves.easeInOut,
          height: (_topIsExpanded || _bottomIsExpanded) ? 0 : 180,
        ),
      ],
    );
  }
}
