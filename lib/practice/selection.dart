import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hirikana/assests/colors.dart';
import 'package:hirikana/practice/hiragana_select.dart';
import 'package:tuple/tuple.dart';

import 'choice.dart';
import 'keyboard.dart';

class SelectionScreen extends StatefulWidget {
  final String mode;
  const SelectionScreen({super.key, required this.mode});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  List<String> filters = ['All', 'Basic', 'Variants', 'Combinations', 'Custom'];
  Set<String> selectedFilters = {};

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
  void _onLineSelected(
      int lineIndex, bool selected, Set<String> filters, bool filterSelect) {
    setState(() {
      /*
      if (_selectedLines.length == _hiraganaData.length) {
        filters.clear();
        filters.add("All");
        for (int i = 0; i < _hiraganaData.length; i++) {
          _selectedLines.add(i);
        }
      } else if (filters.contains("Basic") ) {
        for (int i = 0; i < _hiraganaData.length; i++) {
          _selectedLines.add(i);
        }
        }
        */
      if (filterSelect) {
        if (filters.contains("All")) {
          for (int i = 0; i < _hiraganaData.length; i++) {
            _selectedLines.add(i);
          }
        }
        if (filters.contains("Basic")) {
          for (int i = 0; i < _hiraganaData.length; i++) {
            _selectedLines.add(i);
          }
        }
      } else {
        if (selected) {
          _selectedLines.add(lineIndex);
          filters.clear();
          filters.add("Custom");
        } else {
          _selectedLines.remove(lineIndex);
          filters.clear();
          filters.add("Custom");
        }
      }
      print(filters);
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

// Below is Selection Screen stuff before merge
  void _filterChoice(int index) {
    setState(() {
      if (selectedFilters.contains(filters[0]) &&
          !(selectedFilters.contains(filters[index]))) {
        selectedFilters.remove(filters[0]);
        selectedFilters.add(filters[index]);
      } else if (selectedFilters.contains(filters[index])) {
        selectedFilters.remove(filters[index]);
      } else if (selectedFilters.contains(filters[4]) &&
          !(selectedFilters.contains(filters[index]))) {
        selectedFilters.remove(filters[4]);
        selectedFilters.add(filters[index]);
      } else {
        selectedFilters.add(filters[index]);
      }
      if (selectedFilters.contains(filters[0])) {
        selectedFilters.clear();
        selectedFilters.add(filters[0]);
      }
      if (selectedFilters.contains(filters[4])) {
        selectedFilters.clear();
        selectedFilters.add(filters[4]);
      }

      // Resets to All
      if (selectedFilters.length == 0) {
        selectedFilters.add('All');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    selectedFilters.add('All');
    for (int i = 0; i < _hiraganaData.length; i++) {
      _selectedLines.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: backGroundDark,
        appBar: AppBar(
          backgroundColor: backGroundDark,
          title: const Text("Selection Keyboard"),
          leading: IconButton(
            onPressed: () => context.go("/"),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              height: 50.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        _filterChoice(index);
                        _onLineSelected(-1, false, selectedFilters, true);
                      },
                      child: Chip(
                        label: Text(filters[index]),
                        backgroundColor:
                            selectedFilters.contains(filters[index])
                                ? Colors.blue
                                : const Color.fromARGB(255, 224, 224, 224),
                        labelStyle: TextStyle(
                          color: selectedFilters.contains(filters[index])
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Hiragana Selector
            Column(
              children: [
                // The hiragana chart
                Table(
                  children: [
                    for (int i = 0; i < _hiraganaData.length; i++)
                      TableRow(
                        children: [
                          Checkbox(
                            value: _selectedLines.contains(i),
                            onChanged: (value) => {
                              _onLineSelected(
                                  i, value ?? false, selectedFilters, false),
                            },
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
                    _testFunc(_selectedLines);
                    question.shuffle();
                    if (widget.mode == 'choice') {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ChoiceScreen(lines: _selectedLines),
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
            ),
            Text(" Here ${widget.mode}"),
          ],
        ),
      ),
    );
  }
}
