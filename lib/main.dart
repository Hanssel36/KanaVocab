import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hirikana/chart.dart';
import 'package:hirikana/practice/choice.dart';
import 'package:hirikana/practice/keyboard.dart';

void main() {
  runApp(MyApp());
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomeScreen();
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
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool change = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        backgroundColor: const Color.fromARGB(255, 42, 42, 42),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        change = !change;
                      });
                    },
                    child: Text(
                        style: TextStyle(fontSize: 20),
                        change ? "Hiragana き" : "Katakana \u30A2")),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 100, 99, 99),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: IconButton(
                        iconSize: 75,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () => context.go('/choice'),
                        icon: Icon(Icons.gamepad))),
                Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 100, 99, 99),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: IconButton(
                        iconSize: 75,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () => context.go('/keyboard'),
                        icon: Icon(Icons.keyboard)))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => context.go('/charts'),
                    iconSize: 50,
                    icon: const Icon(
                      Icons.bookmark_outline,
                    )),
                IconButton(
                    onPressed: () {},
                    iconSize: 50,
                    icon: const Icon(
                      Icons.settings_outlined,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
