import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hirikana/practice/choice.dart';
import 'package:hirikana/practice/keyboard.dart';
import 'package:hirikana/practice/selection.dart';
import 'package:hirikana/settings.dart';
import 'chart.dart';
import 'main.dart';

const String chartScreen = 'chart';
const String homeScreen = 'home';
const String selectionScreen = 'selection';
const String setttingsScreen = 'settings';
const String keyboardScreen = 'keyboard';
const String choiceScreen = 'choice';

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
      ],
    ),
  ],
);
