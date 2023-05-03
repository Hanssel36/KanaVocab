import 'package:hive/hive.dart';
import 'package:tuple/tuple.dart';

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
}
