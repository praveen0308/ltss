import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'notifications_screen_state.dart';

class NotificationsScreenCubit extends Cubit<NotificationsScreenState> {
  NotificationsScreenCubit() : super(NotificationsScreenInitial());
}
