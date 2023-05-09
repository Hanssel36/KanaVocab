import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/SetsScreen.dart';
import '../screens/chart.dart';
import '../screens/selection.dart';
import '../screens/settings.dart';
import '../utils/colors.dart';

final currentPageIndex = StateProvider<int>((ref) => 0);

class navigationBar extends ConsumerStatefulWidget {
  const navigationBar({super.key});

  @override
  ConsumerState<navigationBar> createState() => _navigationBarState();
}

class _navigationBarState extends ConsumerState<navigationBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          ref.read(currentPageIndex.notifier).state = index;
        },
        selectedIndex: ref.watch(currentPageIndex),
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.gamepad),
            icon: Icon(Icons.gamepad_outlined),
            label: 'Kana',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: 'Charts',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
      backgroundColor: backGroundDark,
      body: <Widget>[
        SetsScreen(),
        SelectionScreen(),
        ChartsScreen(),
        SettingsScreen()
      ][ref.watch(currentPageIndex)],
    );
  }
}
