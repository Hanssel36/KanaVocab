import 'package:tuple/tuple.dart';
import 'package:hive/hive.dart';

part 'tuple2_adapter.g.dart';

@HiveType(typeId: 2)
class Tuple2Adapter {
  @HiveField(0)
  late dynamic item1;

  @HiveField(1)
  late dynamic item2;

  Tuple2Adapter();

  Tuple2Adapter.fromTuple(Tuple2 tuple) {
    item1 = tuple.item1;
    item2 = tuple.item2;
  }

  Tuple2<dynamic, dynamic> toTuple() {
    return Tuple2(item1, item2);
  }

  Map<String, dynamic> toJson() {
    return {
      'item1': item1,
      'item2': item2,
    };
  }

  static Tuple2Adapter fromMap(Map<String, dynamic> map) {
    Tuple2Adapter tuple2Adapter = Tuple2Adapter();
    tuple2Adapter.item1 = map['item1'];
    tuple2Adapter.item2 = map['item2'];
    return tuple2Adapter;
  }

  static Tuple2Adapter fromJson(Map<String, dynamic> json) {
    Tuple2Adapter tuple2Adapter = Tuple2Adapter();
    tuple2Adapter.item1 = json['item1'];
    tuple2Adapter.item2 = json['item2'];
    return tuple2Adapter;
  }
}
