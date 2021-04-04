import 'package:audioplayers/audio_cache.dart'; //Importing the audioplayers plugin in order to play a sound
import 'package:flutter/material.dart';

//Main function
void main() {

  //Calling runApp method, which takes a Widget as an argument
  runApp(PianoApp());
}

//Dart automatically knows which DataType should the variable have
final _audioPlayer = AudioCache();

//Our app is Stateless, but components inside it can be either Stateless or Stateful
class PianoApp extends StatelessWidget {

  //Flutter "Draws" each widget on screen, when build() method is called
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Piano',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      //Our app has a HomeScreen, which is our Stateful Piano widget
      home: Piano(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Piano extends StatefulWidget {

  //Creating a State of Stateful Piano widget
  @override
  _PianoState createState() => _PianoState();
}

//Names starting with underscore _ mean the class/variable/function is private and can't be accessed from outside
class _PianoState extends State<Piano> {

  //Setting the initial value as false, so lower notes are played
  bool _higherOctave = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Flutter Piano',
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
        actions: [
          Switch(
            value: _higherOctave,
            onChanged: (bool) {

              //Using setState() reflects the new value of variable, wherever it is used throughout the app
              setState(() {
                _higherOctave = !_higherOctave;
              });
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _pianoKeyList(_higherOctave),
        ),
      ),
    );
  }
}

void _playNote(String fileName) {

  //Using play method to play a note
  _audioPlayer.play(fileName);
}

//_pianoKeyList has return type of List<Expanded>, simply means list of Expanded Widgets
List<Expanded> _pianoKeyList(bool higherOctave) {

  //Creating a list of colors to represent individual piano key, 8 notes in an octave, 8 colors in list
  final List<MaterialColor> _pianoKeyColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.indigo,
    Colors.red,
  ];

  return List.generate(
    //Returning a list of same length as _pianoKeyColors
    _pianoKeyColors.length,
    (index) {
      return Expanded(
        child: MaterialButton(
          color: _pianoKeyColors[index],
          onPressed: () {
            //If, higherOctave is true, it'll play higher notes, else it'll play lower notes
            _playNote(higherOctave ? 'sounds/higher_${index + 1}.mp3' : 'sounds/lower_${index + 1}.mp3'); //Ternary operator
          },
        ),
      );
    },
  );
}
