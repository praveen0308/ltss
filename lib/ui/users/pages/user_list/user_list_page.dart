import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/routes/routes.dart';
import 'package:ltss/ui/users/pages/user_list/user_list_cubit.dart';
import 'package:ltss/ui/widgets/view_error_page.dart';
import 'package:ltss/ui/widgets/view_loading.dart';
import 'package:ltss/utils/user_type.dart';

class UserListPage extends StatefulWidget {
  final UserRole userType;

  const UserListPage({super.key, required this.userType});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  void initState() {
    context.read<UserListCubit>().loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(widget.userType.name),
          actions: [
            IconButton(
                onPressed: () {
                  AutoRouter.of(context)
                      .push(AddUserRoute(userTypeAdding: widget.userType));
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: BlocConsumer<UserListCubit, UserListState>(
            builder: (context, state) {
              switch (state) {
                case UserListInitial():
                  return Container();
                case LoadingData():
                  return const LoadingView();
                case OnDataLoaded():
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        var user = state.users[index];
                        return ListTile(
                          onTap: () {
                            if (user.id != null) {
                              AutoRouter.of(context)
                                  .push(UserDetailRoute(userId: user.id!));
                            }
                          },
                          title: Text(user.name.toString()),
                          subtitle: Text(user.mobile_no.toString()),
                          leading: CircleAvatar(
                            child: Text(user.name.toString().substring(0, 1)),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: state.users.length);
                case DataLoadFailed():
                  return ErrorPageView(
                    msg: state.msg,
                  );
                case NoData():
                  return const ErrorPageView(
                    msg: "No Data!!",
                  );
              }
            },
            listener: (context, state) {}));
  }
}
