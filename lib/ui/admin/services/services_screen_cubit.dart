import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'services_screen_state.dart';

class ServicesScreenCubit extends Cubit<ServicesScreenState> {
  ServicesScreenCubit() : super(ServicesScreenInitial());
}
