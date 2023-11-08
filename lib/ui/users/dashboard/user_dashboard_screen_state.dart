part of 'user_dashboard_screen_cubit.dart';

@immutable
abstract class UserDashboardScreenState {}

class UserDashboardScreenInitial extends UserDashboardScreenState {}
class LoadingUI extends UserDashboardScreenState {}
class UILoaded extends UserDashboardScreenState {
  final List<Widget> navItems;
  final List<Widget> pages;
  final int activeIndex;

  UILoaded({required this.navItems,required this.pages, required this.activeIndex});

  UILoaded copyWith({
    List<Widget>? navItems,
    List<Widget>? pages,
    int? activeIndex,
  }) {
    return UILoaded(
      navItems: navItems ?? this.navItems,
      pages: pages ?? this.pages,
      activeIndex: activeIndex ?? this.activeIndex,
    );
  }
}
class LoadUIFailed extends UserDashboardScreenState {
  final String msg;

  LoadUIFailed(this.msg);
}
