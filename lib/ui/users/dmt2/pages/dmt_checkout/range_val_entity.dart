
import 'package:tuple/tuple.dart';

class RangeValEntity {
  final double start;
  final double end;
  final double value;
  final bool inPercent;

  RangeValEntity(this.start, this.end, this.value, this.inPercent);

  static RangeValEntity fromPair(Tuple2<String, String> pair) {
    double a = 0;
    double b = 0;
    double c = 0;
    var range = pair.item1.split("-");
    if (range.length == 2) {
      a = double.parse(range[0]);
      b = double.parse(range[1]);
    }
    if (pair.item2.contains("%")) {
      var percent = pair.item2.substring(0,pair.item2.length-1);
      c = double.parse(percent)/100;
      return RangeValEntity(a, b, c,true);
    }else{
      c = double.parse(pair.item2);
      return RangeValEntity(a, b, c,false);
    }


  }
}
