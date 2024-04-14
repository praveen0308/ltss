import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/repository/repository.dart';
import 'package:ltss/ui/admin/dashboard/bloc/dashboard_screen_bloc.dart';
import 'package:ltss/ui/admin/users/data_view/user_list_data_grid.dart';
import 'package:ltss/ui/admin/users/user_list_screen_cubit.dart';
import 'package:ltss/ui/widgets/widgets.dart';
import 'package:ltss/utils/utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class UserListScreen extends StatefulWidget implements AutoRouteWrapper {
  final UserRole type;

  static Widget create({required UserRole role}){
    return BlocProvider(
      create: (context) => UserListScreenCubit(
          RepositoryProvider.of<UserRepository>(context)),
      child: UserListScreen(type: role),
    );
  }
  const UserListScreen({super.key, required this.type});

  @override
  State<UserListScreen> createState() => _UserListScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserListScreenCubit(RepositoryProvider.of<UserRepository>(context)),
      child: this,
    );
  }
}

class _UserListScreenState extends State<UserListScreen> {
  final CustomColumnSizer _customColumnSizer = CustomColumnSizer();

  @override
  void initState() {
    context.read<UserListScreenCubit>().fetchUserStats(widget.type.roleId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserListScreenCubit, UserListScreenState>(
      listener: (context, state) {
        if (state is ReceivedUserStats) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<UserListScreenCubit>().loadUsers(widget.type.roleId);
          });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BlocBuilder<UserListScreenCubit, UserListScreenState>(
            builder: (context, state) {
              if (state is LoadingUserStats) {
                return Shimmer.fromColors(
                    baseColor: Theme.of(context).colorScheme.primaryContainer,
                    highlightColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          height: 80,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        Container(
                          width: 150,
                          height: 80,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ],
                    ));
              }
              if (state is ReceivedUserStats) {
                return Row(
                  children: [
                    DashboardItemView(
                      title: widget.type.name,
                      subTitle: "${state.userCount}",
                      onClick: () {},
                    ),
                    DashboardItemView(
                      title: "Requests",
                      subTitle: "${state.requestCount}",
                      onClick: () {},
                    ),
                    const Spacer(),
                    FilledButton.icon(
                        onPressed: () {
                          /*showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0)), //this right here
                                  child: BlocProvider(
                                    create: (context) => AddUserCubit(
                                        RepositoryProvider.of<UserRepository>(
                                            context),
                                        RepositoryProvider.of<KYCRepository>(
                                            context)),
                                    child: const SizedBox(
                                      width: 400,
                                      child: AddUserScreen(
                                          userTypeAdding: UserRole.distributor),
                                    ),
                                  ),
                                );
                              });*/
                          context
                              .read<DashboardScreenBloc>()
                              .add(ToggleAddUserPage(role: widget.type));

                        },
                        icon: const Icon(Icons.add),
                        label: const Text("Add"))
                  ],
                );
              }
              if (state is UserStatsFailed) {
                return Center(
                  child: Column(
                    children: [
                      const Icon(
                        Icons.error_rounded,
                        size: 80,
                      ),
                      Text(state.msg)
                    ],
                  ),
                );
              }
              return Container();
            },
            buildWhen: (prev, state) {
              return state is LoadingUserStats ||
                  state is ReceivedUserStats ||
                  state is UserStatsFailed;
            },
          ),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SearchView(
                    onTextChanged: (text) {},
                    onSearch: (text) {
                      context.read<UserListScreenCubit>().searchUser(text);
                    }),
                BlocBuilder<UserListScreenCubit, UserListScreenState>(
                  builder: (context, state) {
                    if (state is ReceivedUsers) {
                      final users = state.users;
                      final userDataSource = UserDataSource(
                          users: users,
                          onViewClick: (int id) {
                            var user =
                                users.firstWhere((element) => element.id == id);
                            context
                                .read<DashboardScreenBloc>()
                                .add(ToggleUserDetailPage(userId: id));
                          });
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SfDataGridTheme(
                          data: SfDataGridThemeData(
                              headerColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer),
                          child: SfDataGrid(
                            rowHeight: 24,
                            headerRowHeight: 24,
                              footer: users.isEmpty
                                  ? const Center(
                                      child: Text("No data available"),
                                    )
                                  : null,
                              gridLinesVisibility: GridLinesVisibility.both,
                              headerGridLinesVisibility:
                                  GridLinesVisibility.both,
                              source: userDataSource,
                              columns: <GridColumn>[
                                GridColumn(
                                  columnName: 'id',
                                  width: 50,
                                  label: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: const Text('ID')),
                                ),
                                GridColumn(
                                    columnName: 'first_name',
                                    columnWidthMode: ColumnWidthMode.fill,
                                    label: Container(
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: const Text('First name'))),
                                GridColumn(
                                    columnName: 'last_name',
                                    columnWidthMode: ColumnWidthMode.fill,
                                    label: Container(
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: const Text('Last name'))),
                                GridColumn(
                                    columnName: 'mobile_no',
                                    columnWidthMode: ColumnWidthMode.fill,
                                    label: Container(
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: const Text('Mobile No'))),
                                GridColumn(
                                    columnName: 'email',
                                    columnWidthMode: ColumnWidthMode.fill,
                                    label: Container(
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: const Text(
                                          'Email',
                                          softWrap: false,
                                        ))),
                                GridColumn(
                                    columnName: 'view',
                                    columnWidthMode: ColumnWidthMode.auto,
                                    label: Container(
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: const Text('View'))),
                              ]),
                        ),
                      );
                    }
                    if (state is LoadingUsers) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is LoadUsersFailed) {
                      return Center(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.error_rounded,
                              size: 80,
                            ),
                            Text(state.msg)
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                  buildWhen: (prev, state) {
                    return state is LoadingUsers ||
                        state is LoadUsersFailed ||
                        state is ReceivedUsers;
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomColumnSizer extends ColumnSizer {
  @override
  double computeHeaderCellWidth(GridColumn column, TextStyle style) {
    style = const TextStyle(fontWeight: FontWeight.bold);

    return super.computeHeaderCellWidth(column, style);
  }

  @override
  double computeCellWidth(GridColumn column, DataGridRow row, Object? cellValue,
      TextStyle textStyle) {
    textStyle = const TextStyle(fontWeight: FontWeight.bold);

    return super.computeCellWidth(column, row, cellValue, textStyle);
  }
}
