import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/generated/assets.dart';
import 'package:ltss/models/domain/user_action.dart';
import 'package:ltss/res/res.dart';
import 'package:ltss/routes/route_imports.gr.dart';
import 'package:ltss/ui/users/dashboard/user_dashboard_screen_cubit.dart';
import 'package:ltss/ui/users/pages/home/home_page_cubit.dart';
import 'package:ltss/ui/users/services/dmt/dmt_screen.dart';
import 'package:ltss/ui/widgets/view_error_page.dart';
import 'package:ltss/ui/widgets/view_loading.dart';
import 'package:ltss/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<HomePageCubit>().loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomePageCubit, HomePageState>(
        listener: (context, state) {},
        builder: (context, state) {
          switch (state) {
            case HomePageInitial():
              return Container();
            case LoadingHome():
              return const LoadingView();
            case HomeDataLoaded():
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            Assets.assetsIcLogo,
                            width: 50,
                            height: 50,
                          ),
                          const Icon(Icons.notifications)
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Welcome, ${state.userName}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 26),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.green.shade200,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Wallet Balance",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                            Text(
                              "₹${state.walletBalance}",
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          "Actions",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.actions.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            var action = state.actions[index];
                            return GestureDetector(
                              onTap: (){
                                handleActionClick(action);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.deepOrange.shade50,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        action.icon,
                                        color: Colors.deepOrange.shade600,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      action.title,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            );
                          })
                    ],
                  ),
                ),
              );
            case LoadingFailed():
              return ErrorPageView(
                msg: state.msg,
              );
          }
        },
      ),
    );
  }

  void handleActionClick(UserAction action) {
    switch (action) {
      case UserAction.serviceDMT:
      // AutoRouter.of(context).push(DMTRoute());
      case UserAction.addCustomer:
        AutoRouter.of(context)
            .push(AddUserRoute(userTypeAdding: UserRole.customer));
      case UserAction.searchUser:
      // TODO: Handle this case.
      case UserAction.transactions:
        context.read<UserDashboardScreenCubit>().switchToPage(
            1); // transactions tab position in nav items and pages
      case UserAction.requestFund:
        AutoRouter.of(context).push(const AddFundRequestRoute());
    }
  }
}
