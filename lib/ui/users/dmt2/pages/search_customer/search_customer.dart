import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/sampurna/get_beneficiary_response.dart';
import 'package:ltss/models/api/sampurna/sender.dart';
import 'package:ltss/res/colors.dart';
import 'package:ltss/routes/route_imports.gr.dart';
import 'package:ltss/ui/users/dmt2/pages/search_customer/search_customer_cubit.dart';
import 'package:ltss/ui/widgets/view_loading.dart';

@RoutePage()
class SearchCustomerScreen extends StatefulWidget implements AutoRouteWrapper {
  const SearchCustomerScreen({super.key});

  @override
  State<SearchCustomerScreen> createState() => _SearchCustomerScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchCustomerCubit(RepositoryProvider.of<DMTRepository>(context)),
      child: this,
    );
  }
}

class _SearchCustomerScreenState extends State<SearchCustomerScreen> {
  final _mobileNo = TextEditingController();

  /* Beneficiary? selectedBeneficiary;

  void setSelectedBeneficiary(Beneficiary beneficiary) {
    setState(() {
      selectedBeneficiary = beneficiary;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<SearchCustomerCubit, SearchCustomerState>(
        listener: (context, state) {
          if (state.status.isCustomerDataLoaded) {
            context.read<SearchCustomerCubit>().fetchBeneficiaries();
          }

        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _mobileNo,
                        maxLength: 10,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            counterText: "",
                            hintText: "00000 00000",
                            contentPadding: EdgeInsets.only(left: 16)),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 22),
                        textInputAction: TextInputAction.search,
                        onChanged: (txt) {
                          context.read<SearchCustomerCubit>().resetData(txt);
                        },
                        onFieldSubmitted: (txt) {
                          context.read<SearchCustomerCubit>().searchCustomer();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<SearchCustomerCubit>().searchCustomer();
                      },
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: customerDataUI(state.sender, state.beneficiaries)),
              FilledButton(
                onPressed: state.canProceed
                    ? () {
                        AutoRouter.of(context).navigate(DMTCheckoutRoute(
                            sender: context.read<SearchCustomerCubit>().sender!,
                            beneficiary: context
                                .read<SearchCustomerCubit>()
                                .selectedBeneficiary!));
                      }
                    : null,
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(16)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    )),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                child: Text(
                  "Proceed".toUpperCase(),
                  style: const TextStyle(fontSize: 16, letterSpacing: 1.5),
                ),
              )
            ],
          );
        },
      ),
    ));
  }

  Widget customerDataUI(DataStatus<Sender>? sender,
      DataStatus<List<Beneficiary>>? beneficiaries) {
    if (sender != null) {
      switch (sender) {
        case Empty<Sender>():
          return Container();
        case Loading<Sender>():
          return const LoadingView();
        case Data<Sender>():
          {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    color: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: const Text(
                      "Customer Detail",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
                ListTile(
                  leading: CircleAvatar(
                    child: Text(sender.data.senderName!.take(1)),
                  ),
                  title: Text(sender.data.senderName ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                      )),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Avl. Limit: ${sender.data.availbleLimit ?? 0.0}"),
                      Text("Total Limit: ${sender.data.totalLimit ?? 0.0}"),
                    ],
                  ),
                ),
                Container(
                    color: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: const Text(
                      "Beneficiaries",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
                Container(
                  color: AppColors.primaryLightest,
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                      onPressed: () {
                        AutoRouter.of(context)
                            .push(const AddBeneficiaryRoute());
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Add New Benficiary")),
                ),
                if (beneficiaries != null)
                  Expanded(child: beneficiariesDataUI(beneficiaries))
              ],
            );
          }
        case Error<Sender>():
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person_search,
                size: 80,
              ),
              Text(
                sender.msg,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 48,
              ),
              FilledButton(
                  onPressed: () {}, child: const Text("Create Customer"))
            ],
          );
      }
    } else {
      return Container();
    }
  }

  Widget beneficiariesDataUI(DataStatus<List<Beneficiary>> state) {
    switch (state) {
      case Empty():
        return Container();
      case Loading():
        return const LoadingView();
      case Data():
        {
          return ListView.separated(
            itemBuilder: (context, index) {
              var beneficiary = state.data[index];
              return RadioListTile<Beneficiary>(
                title: Row(
                  children: [
                    Text(beneficiary.beneName ?? "Nil"),
                    const Spacer(),
                    Visibility(
                        visible: beneficiary.isVerified == true,
                        child: const Icon(Icons.verified_rounded,color: Colors.green,))
                  ],
                ),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Bank : ${beneficiary.bankName}",
                      ),
                      Text("Account No. : ${beneficiary.accountNo}"),
                      Text("IFSC : ${beneficiary.ifsc}"),
                    ]),
                value: beneficiary,
                groupValue:
                    context.read<SearchCustomerCubit>().selectedBeneficiary!,
                onChanged: (Beneficiary? value) {
                  context.read<SearchCustomerCubit>().setBeneficiary(value!);
                  setState(() {

                  });
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemCount: state.data.length,
          );
        }
      case Error():
        return Column(
          children: [
            Text(state.msg),
          ],
        );
    }
  }
}
