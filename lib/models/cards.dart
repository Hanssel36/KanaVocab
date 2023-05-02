import 'package:hive/hive.dart';

part 'cards.g.dart';

@HiveType(typeId: 0)
class Cards {
  @HiveField(0)
  final String title;

  Cards({required this.title});
  factory Cards.fromJson(Map<String, dynamic> json) {
    return Cards(
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
    };
  }
}
