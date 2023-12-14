import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'manage_dmt_state.dart';

class ManageDmtCubit extends Cubit<ManageDmtState> {
  ManageDmtCubit() : super(ManageDmtInitial());
}
