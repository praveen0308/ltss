import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dmt2_state.dart';

class Dmt2Cubit extends Cubit<Dmt2State> {
  Dmt2Cubit() : super(Dmt2Initial());
}
