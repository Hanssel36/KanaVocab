import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hirikana/assests/colors.dart';
import 'package:hirikana/chart.dart';
import 'package:hirikana/practice/choice.dart';
import 'package:hirikana/practice/keyboard.dart';
import 'package:hirikana/practice/selection.dart';

void main() {
  runApp(const MyApp());
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'charts',
          builder: (BuildContext context, GoRouterState state) {
            return const ChartsScreen();
          },
        ),
        GoRoute(
          path: 'choice',
          builder: (BuildContext context, GoRouterState state) {
            return const ChoiceScreen();
          },
        ),
        GoRoute(
          path: 'keyboard',
          builder: (BuildContext context, GoRouterState state) {
            return const KeyboardScreen();
          },
        ),
        GoRoute(
          path: 'selection',
          builder: (BuildContext context, GoRouterState state) {
            return const SelectionScreen();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool change = true;

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
                    change = !change;
                  });
                },
                child: Text(
                    style: const TextStyle(fontSize: 30),
                    change ? "Hiragana き" : "Katakana \u30A2"),
              ),
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
                    onPressed: () => context.go('/selection'),
                    icon: const Icon(Icons.gamepad),
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
                      onPressed: () => context.go('/keyboard'),
                      icon: const Icon(Icons.keyboard)),
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
                      onPressed: () => context.go('/charts'),
                      iconSize: 50,
                      icon: const Icon(
                        Icons.bookmark_outline,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
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
