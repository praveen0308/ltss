import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/routes/route_imports.gr.dart';
import 'package:ltss/ui/users/pages/requests/fund_requests_cubit.dart';
import 'package:ltss/ui/users/pages/requests/view/request_page.dart';
import 'package:ltss/ui/users/pages/requests/view/request_page_cubit.dart';

class FundRequestsPage extends StatefulWidget {
  const FundRequestsPage({super.key});

  @override
  State<FundRequestsPage> createState() => _FundRequestsPageState();
}

class _FundRequestsPageState extends State<FundRequestsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool? isAdd;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        isAdd = _tabController.index == 0;
      });
    });
    context.read<FundRequestsCubit>().initUI();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FundRequestsCubit, FundRequestsState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state) {
          case FundRequestsInitial():
            {
              return Container();
            }
          case InitiatingUI():
            {
              return Container();
            }
          case UILoaded():
            {
              var sVisibility = state.sentVisibility;
              var rVisibility = state.receivedVisibility;

              isAdd ??= sVisibility;

              return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  bottom: (sVisibility && rVisibility)
                      ? TabBar(
                          controller: _tabController,
                          tabs: const [
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.call_made_rounded),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text("SENT")
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.call_received_rounded),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text("RECEIVED")
                                ],
                              ),
                            ),
                          ],
                        )
                      : null,
                  title: const Text('Fund Requests'),
                  actions: [
                    Visibility(
                        visible: isAdd == true,
                        child: IconButton(
                            onPressed: () {
                              AutoRouter.of(context).push(const AddFundRequestRoute());
                            }, icon: const Icon(Icons.add)))
                  ],
                ),
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    if (sVisibility)
                      BlocProvider.value(
                        value: BlocProvider.of<RequestPageCubit>(context),
                        child: const RequestPage(isSent: true),
                      ),
                    if (rVisibility)
                      BlocProvider.value(
                        value: BlocProvider.of<RequestPageCubit>(context),
                        child: const RequestPage(isSent: false),
                      ),
                  ],
                ),
              );
            }
        }
      },
    );
  }
}
