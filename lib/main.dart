import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hirikana/models/cards.dart';
import 'package:hirikana/utils/colors.dart';
import 'package:hirikana/my_route.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hirikana/models/flashcardmodel.dart';
import 'package:hirikana/models/tuple2_adapter.dart';

final gamemode = StateProvider<String>((ref) => 'mode');
final kanachoice = StateProvider<bool>((ref) => true);

void main() async {
  Hive.registerAdapter(CardsAdapter());
  Hive.registerAdapter(Tuple2AdapterAdapter());
  Hive.registerAdapter(FlashcardModelAdapter());
  await Hive.initFlutter();

  // open box

  var box = await Hive.openBox('myBox');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: backGroundDark,
          elevation: 0,
        ),
        backgroundColor: backGroundDark,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(100.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(tiles),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(10))),
                onPressed: () {
                  setState(() {
                    ref.read(kanachoice.notifier).state =
                        !ref.read(kanachoice.notifier).state;
                  });
                },
                child: Text(
                    style: const TextStyle(fontSize: 30),
                    ref.watch(kanachoice) ? "Hiragana き" : "Katakana \u30A2"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(bottom: 10),
                  decoration: const BoxDecoration(
                    color: tiles,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: IconButton(
                    iconSize: 75,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      ref.read(gamemode.notifier).state = "choice";
                      GoRouter.of(context).pushNamed(selectionScreen);
                    },
                    icon: const Icon(Icons.gamepad),
                  ),
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(bottom: 10),
                  decoration: const BoxDecoration(
                      color: tiles,
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: IconButton(
                      iconSize: 75,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        ref.read(gamemode.notifier).state = "keyboard";
                        GoRouter.of(context).pushNamed(selectionScreen);
                      },
                      icon: const Icon(Icons.keyboard)),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: tiles,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: IconButton(
                    iconSize: 75,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () => {context.go('/sets')},
                    icon: const Icon(Icons.style),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: tiles,
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: IconButton(
                      iconSize: 75,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () => {context.go('/sets')},
                      icon: const Icon(Icons.upload)),
                )
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () =>
                          GoRouter.of(context).pushNamed(chartScreen),
                      iconSize: 50,
                      icon: const Icon(
                        Icons.bookmark_outline,
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          GoRouter.of(context).pushNamed(setttingsScreen),
                      iconSize: 50,
                      icon: const Icon(
                        Icons.settings_outlined,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
