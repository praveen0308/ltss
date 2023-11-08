part of 'dashboard_screen_bloc.dart';

class DashboardScreenState extends Equatable {
  final Widget? view;

  const DashboardScreenState({this.view});

  @override
  List<Object?> get props => [view];

  DashboardScreenState copyWith({
    Widget? view,
  }) {
    return DashboardScreenState(
      view: view ?? this.view,
    );
  }
}
