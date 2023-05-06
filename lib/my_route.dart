import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kanavocab/screens/choice.dart';
import 'package:kanavocab/screens/keyboard.dart';
import 'package:kanavocab/screens/selection.dart';
import 'package:kanavocab/screens/settings.dart';
import 'package:kanavocab/screens/chart.dart';
import 'main.dart';
import 'package:kanavocab/screens/SetsScreen.dart';
import 'package:kanavocab/screens/memorygame.dart';

const String chartScreen = 'chart';
const String homeScreen = 'home';
const String selectionScreen = 'selection';
const String setttingsScreen = 'settings';
const String keyboardScreen = 'keyboard';
const String choiceScreen = 'choice';
const String setScreen = 'sets';
const String flashcardScreen = 'flashcard';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: homeScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'charts',
          name: chartScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const ChartsScreen();
          },
        ),
        GoRoute(
          path: 'selection',
          name: selectionScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const SelectionScreen();
          },
        ),
        GoRoute(
          path: 'settings',
          name: setttingsScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const SettingsScreen();
          },
        ),
        GoRoute(
          path: 'keyboard',
          name: keyboardScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const KeyboardScreen();
          },
        ),
        GoRoute(
          path: 'choice',
          name: choiceScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const ChoiceScreen();
          },
        ),
        GoRoute(
          path: 'flashcard',
          builder: (BuildContext context, GoRouterState state) {
            return const MemoryGameScreen();
          },
        ),
        GoRoute(
          path: 'sets',
          name: setScreen,
          builder: (BuildContext context, GoRouterState state) {
            return SetsScreen();
          },
        ),
      ],
    ),
  ],
);
