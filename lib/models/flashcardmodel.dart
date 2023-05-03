import 'package:hive/hive.dart';

part 'flashcardmodel.g.dart';

@HiveType(typeId: 1)
class FlashcardModel {
  @HiveField(0)
  final String frontText;

  @HiveField(1)
  final String backText;

  FlashcardModel({required this.frontText, required this.backText});
}
