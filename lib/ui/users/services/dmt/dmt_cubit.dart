import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dmt_state.dart';

class DmtCubit extends Cubit<DmtState> {
  DmtCubit() : super(DmtInitial());
}
