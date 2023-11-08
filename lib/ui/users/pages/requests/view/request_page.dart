import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/models/api/entity/fund_request_entity.dart';
import 'package:ltss/res/res.dart';
import 'package:ltss/ui/users/pages/requests/view/request_page_cubit.dart';
import 'package:ltss/ui/widgets/view_error_page.dart';
import 'package:ltss/ui/widgets/view_loading.dart';

class RequestPage extends StatefulWidget {
  final bool isSent;

  const RequestPage({super.key, required this.isSent});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  @override
  void initState() {
    if (widget.isSent) {
      context.read<RequestPageCubit>().fetchSentRequests();
    } else {
      context.read<RequestPageCubit>().fetchReceivedRequests();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestPageCubit, RequestPageState>(
        builder: (context, state) {
          return switch (state) {
            RequestPageInitial() => Container(),
            LoadingData() => const LoadingView(),
            OnDataLoaded() => prepareRequestsList(state.data),
            DataLoadFailed() => ErrorPageView(
                msg: state.msg,
              ),
            EmptyData() => const ErrorPageView(
              msg: "No Data",
            ),
          };
        },
        listener: (context, state) {});
  }

  Widget prepareRequestsList(List<FundRequestEntity> fundRequests) {
    return ListView.separated(
        itemBuilder: (context, index) {
          var request  = fundRequests[index];
          return ListTile(
            leading: CircleAvatar(child: Text(request.sender.toString().substring(0,1)),),
            title: Text(request.sender.toString()),
            subtitle: Text(request.getFormattedAddedOn().toString()),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(decoration: BoxDecoration(color: AppColors.primaryLightest,borderRadius: BorderRadius.circular(5)),padding: const EdgeInsets.all(4),child: Text(request.status.toString(),style:const TextStyle(fontSize: 10))),
                Text("₹${request.amount?.toStringAsFixed(0)}",style:const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: fundRequests.length);
  }
}
