import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'report_screen_state.dart';

class ReportScreenCubit extends Cubit<ReportScreenState> {
  ReportScreenCubit() : super(ReportScreenInitial());
}
