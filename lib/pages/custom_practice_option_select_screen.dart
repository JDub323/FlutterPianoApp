import 'dart:math';

import 'package:flutter/material.dart';

class Constants {
  static final List<double> valueWeights = [1, 3, .1, -4, 4, 3, 5, 1, 1, 1, 3];
  static final List<double> initialSelectedValues = [
    1 * valueWeights[0],
    0 * valueWeights[0],
    30 * valueWeights[0],
    400 * valueWeights[0],
    0 * valueWeights[0],
    0 * valueWeights[0],
    1 * valueWeights[0],
    1 * valueWeights[0],
    0 * valueWeights[0],
    0 * valueWeights[0],
    0 * valueWeights[0]
  ];
}

class CustomPracticeOptionSelectScreen extends StatefulWidget {
  const CustomPracticeOptionSelectScreen({super.key});

  @override
  State<CustomPracticeOptionSelectScreen> createState() =>
      _CustomPracticeOptionSelectScreenState();
}

class _CustomPracticeOptionSelectScreenState
    extends State<CustomPracticeOptionSelectScreen> {
  double _totalProgress =
      -60; //correct starting value (yes I need to recaluculate this for every adjustment, I know this is awful code)

  final List<double> _selectedValues =
      List.from(Constants.initialSelectedValues);

  // Function to update the selected value and recalculate the progress
  void _updateSelectedValue(int index, double value) {
    setState(() {
      //incrementally update _totalProgress
      _totalProgress -= (_selectedValues[index] * Constants.valueWeights[index])
          .clamp(-70, 70);
      _totalProgress += (value * Constants.valueWeights[index]).clamp(-70, 70);
      _selectedValues[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.blue.shade100, //may have this change depending on difficulty
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
                alignment: Alignment.center,
                child: const Text('Options', style: TextStyle(fontSize: 40))),
          ),
          ProgressBar(
              progress:
                  _totalProgress), //filler number, will be correctly initialized later
          ArrowTextBox(
            label: "Notes",
            helpMessage: 'Changes the number of notes in each obstacle',
            onSelectionChanged: (value) => _updateSelectedValue(0, value),
            valueWeight: 1,
            options: const [
              Selection(1, 'One'),
              Selection(2, 'Two'),
              Selection(3, 'Three'),
              Selection(5, 'Five'),
              Selection(8, 'Eight'),
              Selection(13, 'Thirteen'),
              Selection(21, 'Twenty-One'),
            ],
          ),
          ArrowTextBox(
              label: "Structure",
              helpMessage:
                  'Whether the notes are arranged in a chord or arpeggios of varying difficulty',
              onSelectionChanged: (value) => _updateSelectedValue(1, value),
              valueWeight: 3,
              options: const [
                Selection(0, 'Chords'),
                Selection(1, 'Easy'),
                Selection(2, 'Medium'),
                Selection(3, 'Difficult'),
              ]),
          ArrowTextBox(
              label: 'Tempo',
              helpMessage: 'Changes how fast each obstacle should be played',
              onSelectionChanged: (value) => _updateSelectedValue(2, value),
              valueWeight: .1,
              options: const [
                Selection(30, 'Very Slow'),
                Selection(60, 'Slow'),
                Selection(90, 'Medium'),
                Selection(120, 'Fast'),
                Selection(180, 'Very Fast'),
                Selection(240, 'Extreme'),
              ]),
          ArrowTextBox(
            label: 'Thinking Time',
            helpMessage:
                'Changes the time you get to read the sheet music before you must play the first note',
            onSelectionChanged: (value) => _updateSelectedValue(3, value),
            valueWeight: -4,
            options: const [
              Selection(400, 'Unlimited'),
              Selection(15, 'Long'),
              Selection(8, 'Moderate'),
              Selection(4, 'Short'),
              Selection(1, 'Instant'),
            ],
          ),
          ArrowTextBox(
              label: 'Range',
              helpMessage:
                  'Whether just the middle part of the piano or the whole piano should be used in single obstacles',
              onSelectionChanged: (value) => _updateSelectedValue(4, value),
              valueWeight: 4,
              options: const [
                Selection(0, 'No Hand Movement'),
                Selection(1, 'Small'),
                Selection(2, 'Medium'),
                Selection(3, 'Large'),
                Selection(4, 'The Whole Piano'),
              ]),
          ArrowTextBox(
              label: 'Chromatics',
              helpMessage:
                  'Whether notes outside the current key will be selected. Whether there will be sharps and flats, basically',
              onSelectionChanged: (value) => _updateSelectedValue(5, value),
              valueWeight: 3,
              options: const [
                Selection(0, 'None'),
                Selection(1, 'A Few'),
                Selection(2, 'Some'),
                Selection(3, 'Lots'),
              ]),
          ArrowTextBox(
            label: 'Hands',
            helpMessage: 'Which hand should be used, or both',
            onSelectionChanged: (value) => _updateSelectedValue(6, value),
            valueWeight: 5,
            options: const [
              Selection(1,
                  'Right Only'), //start counting at 1 here so a bitmask can deduce if each hand is used
              Selection(2,
                  'Left Only'), //one bit on represents right hand active, and the two-bit represents left hand
              Selection(7,
                  'Both'), //REMEMBER THAT THE 4 BIT IS ALSO ON TO MAKE WEIGHTS MAKE SENSE IN THE DIFFICULTY BAR
            ],
          ),
          ArrowTextBox(
              label: 'Duration Variance',
              helpMessage:
                  'Whether all notes should be quarter notes, or should vary in length',
              onSelectionChanged: (value) => _updateSelectedValue(7, value),
              valueWeight: 1,
              options: const [
                Selection(1,
                    'Quarter Notes Only'), //same idea as above with the bitmasks
                Selection(3, 'Quarter & Half Notes'),
                Selection(7, 'Quarter, Half, & Eighth'),
              ]),
          ArrowTextBox(
              label: 'Stoccato?',
              helpMessage:
                  'Whether stoccato notes will be mixed in, and to what degree',
              onSelectionChanged: (value) => _updateSelectedValue(8, value),
              valueWeight: 1,
              options: const [
                Selection(0, 'None'),
                Selection(1, 'A few'),
                Selection(2, 'Some'),
                Selection(3, 'Lots'),
              ]),
          ArrowTextBox(
              label: 'Slurs?',
              helpMessage:
                  'Whether legato will be enforced, and how many slurs and ties will be incorporated',
              onSelectionChanged: (value) => _updateSelectedValue(9, value),
              valueWeight: 1,
              options: const [
                Selection(0, 'No Slurs'),
                Selection(1, 'A Few'),
                Selection(2, 'Some'),
                Selection(3, 'Lots'),
              ]),
          ArrowTextBox(
              label: 'Dynamics',
              helpMessage:
                  'Whether loudness will be enforced, and how it should be varied',
              onSelectionChanged: (value) => _updateSelectedValue(10, value),
              valueWeight: 3,
              options: const [
                Selection(0, 'Forte Only'),
                Selection(1, 'Vary Between Obstacles'),
                Selection(2, 'Vary Within Obstacles'),
              ]),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(200, 50)),
                onPressed: () {
                  Navigator.pushNamed(context, '/startScreen');
                },
                child: const Text('Start!'),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ArrowTextBox extends StatefulWidget {
  final List<Selection> options;
  final double valueWeight;
  final String label;
  final String helpMessage;
  final ValueChanged<double>
      onSelectionChanged; // Callback for selection change

  const ArrowTextBox(
      {required this.options,
      required this.label,
      required this.helpMessage,
      required this.onSelectionChanged,
      required this.valueWeight,
      super.key});

  @override
  ArrowTextBoxState createState() => ArrowTextBoxState();
}

class ArrowTextBoxState extends State<ArrowTextBox> {
  int _currentIndex = 0;

  void _incrementIndex() {
    setState(() {
      _currentIndex =
          (_currentIndex + 1) % widget.options.length; // Wrap around
      updateProgressBar();
    });
  }

  void _decrementIndex() {
    setState(() {
      _currentIndex =
          (_currentIndex - 1 + widget.options.length) % widget.options.length;
      updateProgressBar();
    });
  }

  void updateProgressBar() {
    widget.onSelectionChanged(
        widget.options[_currentIndex].value); //weight is multiplied in later
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double dividerIndent = (screenWidth - 400) / 2;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Tooltip(
              message: widget.helpMessage,
              child: IconButton(
                icon: const Icon(Icons.help_outline),
                onPressed: () {},
              ),
            ),
            SizedBox(
              width: 150.0,
              child: Text(
                widget.label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_left),
              onPressed: _decrementIndex,
            ),
            SizedBox(
              width: 130,
              child: Text(
                widget.options[_currentIndex].string,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_right),
              onPressed: _incrementIndex,
            ),
          ],
        ),
        Divider(
          color: Colors.white,
          thickness: 2,
          indent: dividerIndent,
          endIndent: dividerIndent,
        ),
      ],
    );
  }
}

class Selection {
  final double value;
  final String string;
  const Selection(this.value, this.string);
}

class ProgressBar extends StatefulWidget {
  final double progress;
  const ProgressBar({required this.progress, super.key});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  double _progress = 0;

  _ProgressBarState() : super() {
    //initialize progress bar length
    double sum = 0;
    for (int i = 0; i < Constants.initialSelectedValues.length; i++) {
      sum += (Constants.initialSelectedValues[i] * Constants.valueWeights[i])
          .clamp(-70, 70);
    }
    _progress = sigmoid(sum);
  }

  @override
  void didUpdateWidget(ProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setProgress(widget.progress);
  }

  void _setProgress(double progress) {
    setState(() {
      _progress = sigmoid(progress);
    });
  }

  //uses sigmoid squishification function, output always between 0 and 1
  //shifted right 10 and stretched horizontally to give more natural looking movement
  double sigmoid(double progress) {
    print("Progress: $progress");
    double pas = 1 / (1 + pow(1.05, -progress + 10));
    print("Progress after Sigmoid: $pas");
    return pas;
  }

  @override
  Widget build(BuildContext context) {
    Color progressColor;
    if (_progress < 0.33) {
      progressColor = Color.lerp(Colors.green, Colors.orange, _progress * 3)!;
    } else if (_progress < .66) {
      progressColor =
          Color.lerp(Colors.orange, Colors.red, (_progress - 0.33) * 3)!;
    } else if (_progress < .9969) {
      progressColor = Color.lerp(Colors.red,
          const Color.fromARGB(255, 71, 17, 81), (_progress - 0.66) * 3)!;
    } else {
      progressColor = Colors.white;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
      child: Center(
        child: Container(
          width: 500,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: Stack(
            children: [
              Container(
                width: 500 * _progress,
                height: 20,
                decoration: BoxDecoration(
                  color: progressColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
