import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/user_entity.dart';
import 'package:ltss/routes/route_imports.gr.dart';
import 'package:ltss/ui/widgets/view_error_page.dart';
import 'package:ltss/ui/widgets/view_loading.dart';

import 'select_customer_cubit.dart';

@RoutePage()
class SelectCustomerScreen extends StatefulWidget implements AutoRouteWrapper {
  final UserEntity? selectedCustomer;

  const SelectCustomerScreen({super.key, this.selectedCustomer});

  @override
  State<SelectCustomerScreen> createState() => _SelectCustomerScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
        create: (context) => SelectCustomerCubit(
              RepositoryProvider.of<UserRepository>(context),
              RepositoryProvider.of<SessionManager>(context),
            ),
        child: this);
  }
}

class _SelectCustomerScreenState extends State<SelectCustomerScreen> {
  @override
  void initState() {
    context.read<SelectCustomerCubit>().fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<SelectCustomerCubit, SelectCustomerState>(
          builder: (context, state) {
            switch (state) {
              case SelectCustomerInitial():
                return Container();
              case LoadingData():
                return const LoadingView();
              case ReceivedData():
                return ListView.separated(
                  itemBuilder: (context, index) {
                    var customer = state.data[index];
                    var isSelected = widget.selectedCustomer?.id == customer.id;
                    return ListTile(
                      onTap: () {
                        AutoRouter.of(context).pop(customer);
                      },
                      leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          child: Text(customer.firstName?.take(1) ?? "")),
                      title: Text(customer.firstName ?? "Nil"),
                      subtitle: Text(customer.mobileNo ?? "Nil"),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle_rounded)
                          : null,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                  itemCount: state.data.length,
                );
              case LoadDataFailed():
                return ErrorPageView(
                  msg: state.msg,
                );
            }
          },
          listener: (context, state) {}),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AutoRouter.of(context).push(const AddCustomerRoute());
        },
        child: const Icon(Icons.add),
      ),
    ));
  }
}
