import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hirikana/utils/colors.dart';
import 'package:hirikana/widgets/hiragana_select.dart';
import 'package:tuple/tuple.dart';
import '../main.dart';
import '../my_route.dart';

final proquestion = StateProvider<List<Tuple2<String, String>>>((ref) => []);

class SelectionScreen extends ConsumerStatefulWidget {
  const SelectionScreen({super.key});

  @override
  ConsumerState<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends ConsumerState<SelectionScreen> {
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
    ['や', '    ', 'ゆ', '    ', 'よ'],
    ['ら', 'り', 'る', 'れ', 'ろ'],
    ['わ', '    ', '    ', '    ', 'を'],
    ['ん', '    ', '    ', '    ', '    '],
    ["が", "ぎ", "ぐ", "げ", "ご"],
    ["ざ", "じ", "ず", "ぜ", "ぞ"],
    ["だ", "ぢ", "づ", "で", "ど"],
    ["ば", "び", "ぶ", "べ", "ぼ"],
    ["ぱ", "ぴ", "ぷ", "ぺ", "ぽ"],
    ["きゃ", "きゅ", "きょ"],
    ["ぎゃ", "ぎゅ", "ぎょ"],
    ["しゃ", "しゅ", "しょ"],
    ["じゃ", "じゅ", "じょ"],
    ["ちゃ", "ちゅ", "ちょ"],
    ["にゃ", "にゅ", "にょ"],
    ["ひゃ", "ひゅ", "ひょ"],
    ["びゃ", "びゅ", "びょ"],
    ["ぴゃ", "ぴゅ", "ぴょ"],
    ["みゃ", "みゅ", "みょ"],
    ["りゃ", "りゅ", "りょ"]
  ];
  final List<List<String>> _katakanaData = [
    ['ア', 'イ', 'ウ', 'エ', 'オ'],
    ['カ', 'キ', 'ク', 'ケ', 'コ'],
    ['サ', 'シ', 'ス', 'セ', 'ソ'],
    ['タ', 'チ', 'ツ', 'テ', 'ト'],
    ['ナ', 'ニ', 'ヌ', 'ネ', 'ノ'],
    ['ハ', 'ヒ', 'フ', 'ヘ', 'ホ'],
    ['マ', 'ミ', 'ム', 'メ', 'モ'],
    ['ヤ', '    ', 'ユ', '    ', 'ヨ'],
    ['ラ', 'リ', 'ル', 'レ', 'ロ'],
    ['ワ', '    ', '    ', '    ', 'ヲ'],
    ['ン', '    ', '    ', '    ', '    '],
    ["ガ", "ギ", "グ", "ゲ", "ゴ"],
    ["ザ", "ジ", "ズ", "ゼ", "ゾ"],
    ["ダ", "ヂ", "ヅ", "デ", "ド"],
    ["バ", "ビ", "ブ", "ベ", "ボ"],
    ["パ", "ピ", "プ", "ペ", "ポ"],
    ["キャ", "キュ", "キョ"],
    ["ギャ", "ギュ", "ギョ"],
    ["シャ", "シュ", "ショ"],
    ["ジャ", "ジュ", "ジョ"],
    ["チャ", "チュ", "チョ"],
    ["ニャ", "ニュ", "ニョ"],
    ["ヒャ", "ヒュ", "ヒョ"],
    ["ビャ", "ビュ", "ビョ"],
    ["ピャ", "ピュ", "ピョ"],
    ["ミャ", "ミュ", "ミョ"],
    ["リャ", "リュ", "リョ"]
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
    [
      const Tuple2('が', 'ga'),
      const Tuple2('ぎ', 'gi'),
      const Tuple2('ぐ', 'gu'),
      const Tuple2('げ', 'ge'),
      const Tuple2('ご', 'go'),
    ],
    [
      const Tuple2('ざ', 'za'),
      const Tuple2('じ', 'ji'),
      const Tuple2('ず', 'zu'),
      const Tuple2('ぜ', 'ze'),
      const Tuple2('ぞ', 'zo'),
    ],
    [
      const Tuple2('だ', 'da'),
      const Tuple2('ぢ', 'ji'),
      const Tuple2('づ', 'zu'),
      const Tuple2('で', 'de'),
      const Tuple2('ど', 'do'),
    ],
    [
      const Tuple2('ば', 'ba'),
      const Tuple2('び', 'bi'),
      const Tuple2('ぶ', 'bu'),
      const Tuple2('べ', 'be'),
      const Tuple2('ぼ', 'bo'),
    ],
    [
      const Tuple2('ぱ', 'pa'),
      const Tuple2('ぴ', 'pi'),
      const Tuple2('ぷ', 'pu'),
      const Tuple2('ぺ', 'pe'),
      const Tuple2('ぽ', 'po'),
    ],
    [
      const Tuple2('きゃ', 'kya'),
      const Tuple2('きゅ', 'kyu'),
      const Tuple2('きょ', 'kyo')
    ],
    [
      const Tuple2('ぎゃ', 'gya'),
      const Tuple2('ぎゅ', 'gyu'),
      const Tuple2('ぎょ', 'gyo'),
    ],
    [
      const Tuple2('しゃ', 'sha'),
      const Tuple2('しゅ', 'shu'),
      const Tuple2('しょ', 'sho'),
    ],
    [
      const Tuple2('じゃ', 'ja'),
      const Tuple2('じゅ', 'ju'),
      const Tuple2('じょ', 'jo'),
    ],
    [
      const Tuple2('ちゃ', 'cha'),
      const Tuple2('ちゅ', 'chu'),
      const Tuple2('ちょ', 'cho'),
    ],
    [
      const Tuple2('にゃ', 'nya'),
      const Tuple2('にゅ', 'nyu'),
      const Tuple2('にょ', 'nyo'),
    ],
    [
      const Tuple2('ひゃ', 'hya'),
      const Tuple2('ひゅ', 'hyu'),
      const Tuple2('ひょ', 'hyo'),
    ],
    [
      const Tuple2('びゃ', 'bya'),
      const Tuple2('びゅ', 'byu'),
      const Tuple2('びょ', 'byo'),
    ],
    [
      const Tuple2('ぴゃ', 'pya'),
      const Tuple2('ぴゅ', 'pyu'),
      const Tuple2('ぴょ', 'pyo'),
    ],
    [
      const Tuple2('みゃ', 'mya'),
      const Tuple2('みゅ', 'myu'),
      const Tuple2('みょ', 'myo'),
    ],
    [
      const Tuple2('りゃ', 'rya'),
      const Tuple2('りゅ', 'ryu'),
      const Tuple2('りょ', 'ryo'),
    ]
  ];

  final List<List<Tuple2<String, String>>> katakanaList = [
    [
      const Tuple2('ア', 'a'),
      const Tuple2('イ', 'i'),
      const Tuple2('ウ', 'u'),
      const Tuple2('エ', 'e'),
      const Tuple2('オ', 'o')
    ],
    [
      const Tuple2('カ', 'ka'),
      const Tuple2('キ', 'ki'),
      const Tuple2('ク', 'ku'),
      const Tuple2('ケ', 'ke'),
      const Tuple2('コ', 'ko')
    ],
    [
      const Tuple2('サ', 'sa'),
      const Tuple2('シ', 'shi'),
      const Tuple2('ス', 'su'),
      const Tuple2('セ', 'se'),
      const Tuple2('ソ', 'so')
    ],
    [
      const Tuple2('タ', 'ta'),
      const Tuple2('チ', 'chi'),
      const Tuple2('ツ', 'tsu'),
      const Tuple2('テ', 'te'),
      const Tuple2('ト', 'to')
    ],
    [
      const Tuple2('ナ', 'na'),
      const Tuple2('ニ', 'ni'),
      const Tuple2('ヌ', 'nu'),
      const Tuple2('ネ', 'ne'),
      const Tuple2('ノ', 'no')
    ],
    [
      const Tuple2('ハ', 'ha'),
      const Tuple2('ヒ', 'hi'),
      const Tuple2('フ', 'fu'),
      const Tuple2('ヘ', 'he'),
      const Tuple2('ホ', 'ho')
    ],
    [
      const Tuple2('マ', 'ma'),
      const Tuple2('ミ', 'mi'),
      const Tuple2('ム', 'mu'),
      const Tuple2('メ', 'me'),
      const Tuple2('モ', 'mo')
    ],
    [const Tuple2('ヤ', 'ya'), const Tuple2('ユ', 'yu'), const Tuple2('ヨ', 'yo')],
    [
      const Tuple2('ラ', 'ra'),
      const Tuple2('リ', 'ri'),
      const Tuple2('ル', 'ru'),
      const Tuple2('レ', 're'),
      const Tuple2('ロ', 'ro')
    ],
    [const Tuple2('ワ', 'wa'), const Tuple2('ヲ', 'wo')],
    [const Tuple2('ン', 'n')],
    [
      const Tuple2('ガ', 'ga'),
      const Tuple2('ギ', 'gi'),
      const Tuple2('グ', 'gu'),
      const Tuple2('ゲ', 'ge'),
      const Tuple2('ゴ', 'go')
    ],
    [
      const Tuple2('ザ', 'za'),
      const Tuple2('ジ', 'ji'),
      const Tuple2('ズ', 'zu'),
      const Tuple2('ゼ', 'ze'),
      const Tuple2('ゾ', 'zo')
    ],
    [
      const Tuple2('ダ', 'da'),
      const Tuple2('ヂ', 'ji'),
      const Tuple2('ヅ', 'zu'),
      const Tuple2('デ', 'de'),
      const Tuple2('ド', 'do')
    ],
    [
      const Tuple2('バ', 'ba'),
      const Tuple2('ビ', 'bi'),
      const Tuple2('ブ', 'bu'),
      const Tuple2('ベ', 'be'),
      const Tuple2('ボ', 'bo')
    ],
    [
      const Tuple2('パ', 'pa'),
      const Tuple2('ピ', 'pi'),
      const Tuple2('プ', 'pu'),
      const Tuple2('ペ', 'pe'),
      const Tuple2('ポ', 'po')
    ],
    [
      const Tuple2('キャ', 'kya'),
      const Tuple2('キュ', 'kyu'),
      const Tuple2('キョ', 'kyo')
    ],
    [
      const Tuple2('ギャ', 'gya'),
      const Tuple2('ギュ', 'gyu'),
      const Tuple2('ギョ', 'gyo')
    ],
    [
      const Tuple2('シャ', 'sha'),
      const Tuple2('シュ', 'shu'),
      const Tuple2('ショ', 'sho')
    ],
    [
      const Tuple2('ジャ', 'ja'),
      const Tuple2('ジュ', 'ju'),
      const Tuple2('ジョ', 'jo')
    ],
    [
      const Tuple2('チャ', 'cha'),
      const Tuple2('チュ', 'chu'),
      const Tuple2('チョ', 'cho')
    ],
    [
      const Tuple2('ニャ', 'nya'),
      const Tuple2('ニュ', 'nyu'),
      const Tuple2('ニョ', 'nyo')
    ],
    [
      const Tuple2('ヒャ', 'hya'),
      const Tuple2('ヒュ', 'hyu'),
      const Tuple2('ヒョ', 'hyo')
    ],
    [
      const Tuple2('ビャ', 'bya'),
      const Tuple2('ビュ', 'byu'),
      const Tuple2('ビョ', 'byo')
    ],
    [
      const Tuple2('ピャ', 'pya'),
      const Tuple2('ピュ', 'pyu'),
      const Tuple2('ピョ', 'pyo')
    ],
    [
      const Tuple2('ミャ', 'mya'),
      const Tuple2('ミュ', 'myu'),
      const Tuple2('ミョ', 'myo')
    ],
    [
      const Tuple2('リャ', 'rya'),
      const Tuple2('リュ', 'ryu'),
      const Tuple2('リョ', 'ryo')
    ]
  ];

  // The selected lines
  Set<int> _selectedLines = {};

  // Called when a line is selected or unselected
  void _onLineSelected(
      int lineIndex, bool selected, Set<String> filters, bool filterSelect) {
    setState(() {
      if (filterSelect) {
        _selectedLines = {};
        if (filters.contains("All")) {
          for (int i = 0; i < _hiraganaData.length; i++) {
            _selectedLines.add(i);
          }
        }
        if (filters.contains("Basic")) {
          for (int i = 0; i < 11; i++) {
            _selectedLines.add(i);
          }
        }
        if (filters.contains("Variants")) {
          for (int i = 11; i < 16; i++) {
            _selectedLines.add(i);
          }
        }
        if (filters.contains("Combinations")) {
          for (int i = 16; i < _hiraganaData.length; i++) {
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
    });
  }

  void _loadQuestions(Set set) {
    for (var itr in set) {
      if (ref.watch(kanachoice)) {
        int n = hiraganaList[itr].length;
        for (var i = 0; i < n; i++) {
          ref.read(proquestion.notifier).state.add(hiraganaList[itr][i]);
        }
      } else {
        int n = katakanaList[itr].length;
        for (var i = 0; i < n; i++) {
          ref.read(proquestion.notifier).state.add(katakanaList[itr][i]);
        }
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
      if (selectedFilters.isEmpty) {
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
    final mode = ref.watch(gamemode);
    final kana = ref.watch(kanachoice);
    ref.invalidate(proquestion);
    return MaterialApp(
      home: Scaffold(
        backgroundColor: backGroundDark,
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () {
              playGame(context, mode);
            },
            child: Icon(Icons.start_outlined),
          );
        }),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backGroundDark,
          title: const Text("Selection Screen"),
          leading: IconButton(
            onPressed: () => GoRouter.of(context).pushNamed(homeScreen),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: ListView(children: [
          Column(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            selectedFilters.clear();
                            selectedFilters.add("Custom");
                            _selectedLines = {};
                          });
                        },
                        iconSize: 32,
                        color: const Color.fromARGB(192, 255, 255, 255),
                        icon: const Icon(
                          Icons.delete,
                        ),
                      ),
                    ],
                  ),
                  kana ? KanaChart(_hiraganaData) : KanaChart(_katakanaData),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Column KanaChart(List<List<String>> kanaData) {
    return Column(
      children: [
        for (int i = 0; i < kanaData.length; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Checkbox(
                value: _selectedLines.contains(i),
                onChanged: (value) => {
                  _onLineSelected(i, value ?? false, selectedFilters, false),
                },
              ),
              for (int j = 0; j < kanaData[i].length; j++)
                HiraganaSelectionItem(
                  value: kanaData[i][j],
                ),
            ],
          ),
      ],
    );
  }

  void playGame(BuildContext context, String mode) {
    _loadQuestions(_selectedLines);

    ref.read(proquestion.notifier).state.shuffle();
    if (ref.read(proquestion.notifier).state.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please pick at least one line'),
        ),
      );
    } else {
      if (mode == 'choice') {
        GoRouter.of(context).pushNamed(choiceScreen);
      } else {
        GoRouter.of(context).pushNamed(keyboardScreen);
      }
    }
  }
}
