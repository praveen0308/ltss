import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/fund_request_entity.dart';
import 'package:ltss/ui/users/fund_request_detail/fund_request_detail_cubit.dart';
import 'package:ltss/ui/widgets/view_error_page.dart';
import 'package:ltss/ui/widgets/view_loading.dart';
import 'package:ltss/ui/widgets/widgets.dart';

@RoutePage()
class FundRequestDetailScreen extends StatefulWidget
    implements AutoRouteWrapper {
  final FundRequestEntity data;

  const FundRequestDetailScreen({super.key, required this.data});

  @override
  State<FundRequestDetailScreen> createState() =>
      _FundRequestDetailScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => FundRequestDetailCubit(
          RepositoryProvider.of<FundRequestRepository>(context),
          RepositoryProvider.of<SessionManager>(context)),
      child: this,
    );
  }
}

class _FundRequestDetailScreenState extends State<FundRequestDetailScreen>
    with BasePageState {
  late FundRequestEntity request;

  @override
  void initState() {
    request = widget.data;
    context.read<FundRequestDetailCubit>().loadUI(request);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<FundRequestDetailCubit, FundRequestDetailState>(
      listener: (context, state) {
        showLoading(state.status.isLoading);
        if (state.status.isSuccess) {
          context
              .read<FundRequestDetailCubit>()
              .fetchRequestDetail(request.requestId!);
        }
        if (state.status.isInitializationSuccessful) {
          request = state.data!;
        }
      },
      builder: (context, state) {
        if (state.status.isInitializing) {
          return const LoadingView();
        }
        if (state.status.isInitializationFailed) {
          return ErrorPageView(
            msg: state.msg,
          );
        }
        if (state.status.isError) {
          return ErrorPageView(
            msg: state.msg,
          );
        }
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () {
                    AutoRouter.of(context).pop();
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
          body: Column(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "₹${request.amount}",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const Text("Requested Amount")
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    ListTile(
                      title: const Text("Sender Name"),
                      subtitle: Text(request.sender?.toString() ?? "Nil"),
                    ),
                    ListTile(
                      title: const Text("Role"),
                      subtitle: Text(UserRole.getUserRoleName(
                              request.sender?.roleId?.toInt()) ??
                          "Nil"),
                    ),
                    ListTile(
                      title: const Text("Requested On"),
                      subtitle: Text(request.getFormattedAddedOn()),
                    ),
                    ListTile(
                      title: const Text("Status"),
                      subtitle: HighlightedLabel(text: request.status ?? "Nil"),
                    )
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                if (state.canAcceptReject)
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        context
                            .read<FundRequestDetailCubit>()
                            .updateFundRequest(
                                request.requestId!.toInt(), "REJECTED");
                      },
                      style:
                          FilledButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text("Reject"),
                    ),
                  ),
                if (state.canRevoke)
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        context
                            .read<FundRequestDetailCubit>()
                            .updateFundRequest(
                                request.requestId!.toInt(), "REVOKED");
                      },
                      style:
                          FilledButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text("Revoke"),
                    ),
                  ),
                const SizedBox(
                  width: 16,
                ),
                if (state.canAcceptReject)
                  Expanded(
                    child: FilledButton(
                        onPressed: () {
                          context
                              .read<FundRequestDetailCubit>()
                              .updateFundRequest(
                                  request.requestId!.toInt(), "APPROVED");
                        },
                        style: FilledButton.styleFrom(
                            backgroundColor: Colors.green),
                        child: const Text("Accept")),
                  ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
