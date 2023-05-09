import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanavocab/models/cards.dart';
import 'package:kanavocab/my_route.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kanavocab/models/flashcardmodel.dart';
import 'package:kanavocab/models/tuple2_adapter.dart';
import 'package:kanavocab/widgets/navBar.dart';

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
      home: navigationBar(),
    );
  }
}
