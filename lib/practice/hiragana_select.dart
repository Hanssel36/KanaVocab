import 'package:flutter/material.dart';
import 'package:hirikana/practice/choice.dart';
import 'package:hirikana/practice/keyboard.dart';
import 'package:tuple/tuple.dart';

class HiraganaChart extends StatefulWidget {
  final String mode;

  const HiraganaChart({super.key, required this.mode});

  @override
  _HiraganaChartState createState() => _HiraganaChartState();
}

class _HiraganaChartState extends State<HiraganaChart> {
  // The hiragana chart data
  final List<List<String>> _hiraganaData = [
    ['あ', 'い', 'う', 'え', 'お'],
    ['か', 'き', 'く', 'け', 'こ'],
    ['さ', 'し', 'す', 'せ', 'そ'],
    ['た', 'ち', 'つ', 'て', 'と'],
    ['な', 'に', 'ぬ', 'ね', 'の'],
    ['は', 'ひ', 'ふ', 'へ', 'ほ'],
    ['ま', 'み', 'む', 'め', 'も'],
    ['や', ' ', 'ゆ', ' ', 'よ'],
    ['ら', 'り', 'る', 'れ', 'ろ'],
    ['わ', ' ', ' ', ' ', 'を'],
    ['ん', ' ', ' ', ' ', ' '],
  ];
  final List<List<Tuple2<String, String>>> hiraganaList = [
    [
      const Tuple2('あ', 'a'),
      const Tuple2('い', 'i'),
      const Tuple2('う', 'u'),
      const Tuple2('え', 'e'),
      const Tuple2('お', 'o')
    ],
    [
      const Tuple2('か', 'ka'),
      const Tuple2('き', 'ki'),
      const Tuple2('く', 'ku'),
      const Tuple2('け', 'ke'),
      const Tuple2('こ', 'ko')
    ],
    [
      const Tuple2('さ', 'sa'),
      const Tuple2('し', 'shi'),
      const Tuple2('す', 'su'),
      const Tuple2('せ', 'se'),
      const Tuple2('そ', 'so')
    ],
    [
      const Tuple2('た', 'ta'),
      const Tuple2('ち', 'chi'),
      const Tuple2('つ', 'tsu'),
      const Tuple2('て', 'te'),
      const Tuple2('と', 'to')
    ],
    [
      const Tuple2('な', 'na'),
      const Tuple2('に', 'ni'),
      const Tuple2('ぬ', 'nu'),
      const Tuple2('ね', 'ne'),
      const Tuple2('の', 'no')
    ],
    [
      const Tuple2('は', 'ha'),
      const Tuple2('ひ', 'hi'),
      const Tuple2('ふ', 'fu'),
      const Tuple2('へ', 'he'),
      const Tuple2('ほ', 'ho')
    ],
    [
      const Tuple2('ま', 'ma'),
      const Tuple2('み', 'mi'),
      const Tuple2('む', 'mu'),
      const Tuple2('め', 'me'),
      const Tuple2('も', 'mo')
    ],
    [const Tuple2('や', 'ya'), const Tuple2('ゆ', 'yu'), const Tuple2('よ', 'yo')],
    [
      const Tuple2('ら', 'ra'),
      const Tuple2('り', 'ri'),
      const Tuple2('る', 'ru'),
      const Tuple2('れ', 're'),
      const Tuple2('ろ', 'ro')
    ],
    [const Tuple2('わ', 'wa'), const Tuple2('を', 'wo')],
    [const Tuple2('ん', 'n')],
  ];

  // The selected lines
  final Set<int> _selectedLines = {};

  // Called when a line is selected or unselected
  void _onLineSelected(int lineIndex, bool selected) {
    setState(() {
      if (selected) {
        _selectedLines.add(lineIndex);
      } else {
        _selectedLines.remove(lineIndex);
      }
    });
  }

  final List<Tuple2<String, String>> question = [];

  void _testFunc(Set set) {
    for (var itr in set) {
      int n = hiraganaList[itr].length;
      for (var i = 0; i < n; i++) {
        question.add(hiraganaList[itr][i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _testFunc(_selectedLines);

    return Column(
      children: [
        // The hiragana chart
        Table(
          children: [
            for (int i = 0; i < _hiraganaData.length; i++)
              TableRow(
                children: [
                  Checkbox(
                    value: _selectedLines.contains(i),
                    onChanged: (value) => _onLineSelected(i, value ?? false),
                  ),
                  for (int j = 0; j < _hiraganaData[i].length; j++)
                    HiraganaSelectionItem(
                      value: _hiraganaData[i][j],
                    ),
                ],
              ),
          ],
        ),

        // A button to show the selected lines
        ElevatedButton(
          onPressed: () {
            if (widget.mode == 'choice') {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChoiceScreen(lines: _selectedLines),
                ),
              );
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => KeyboardScreen(
                    lines: _selectedLines,
                    question: question,
                  ),
                ),
              );
            }
            print('Selected lines: $_selectedLines');
          },
          child: const Text('Start'),
        ),
      ],
    );
  }
}

class HiraganaSelectionItem extends StatelessWidget {
  final String value;

  const HiraganaSelectionItem({
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Text(value),
      ),
    );
  }
}
