import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/sampurna/get_beneficiary_response.dart';
import 'package:ltss/models/api/sampurna/sender.dart';
import 'package:ltss/routes/route_imports.gr.dart';
import 'package:ltss/ui/users/dmt2/pages/dmt_checkout/dmt_checkout_cubit.dart';
import 'package:ltss/ui/widgets/view_loading.dart';

@RoutePage()
class DMTCheckoutScreen extends StatefulWidget implements AutoRouteWrapper {
  final Sender sender;
  final Beneficiary beneficiary;

  const DMTCheckoutScreen(
      {super.key, required this.sender, required this.beneficiary});

  @override
  State<DMTCheckoutScreen> createState() => _DMTCheckoutScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => DmtCheckoutCubit(
          RepositoryProvider.of<ChargeRepository>(context),
          RepositoryProvider.of<DMTRepository>(context),
          RepositoryProvider.of<BankRepository>(context)),
      child: this,
    );
  }
}

class _DMTCheckoutScreenState extends State<DMTCheckoutScreen> {
  final _amountController = TextEditingController();

  @override
  void initState() {
    context.read<DmtCheckoutCubit>().init(widget.sender, widget.beneficiary);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<DmtCheckoutCubit, DmtCheckoutState>(
        listener: (context, state) {
          if (state.status.isError) {
            showToast(state.msg ?? "Something went wrong!!!", ToastType.error);
          }
          if (state.status.isSuccess) {
            AutoRouter.of(context).pushAndPopUntil(
                const TransactionSuccessRoute(),
                predicate: (route) =>
                    route.settings.name == UserDashboardRoute.name);
          }
        },
        builder: (context, state) {
          if (state.status.isInitializing) {
            return const LoadingView();
          }
          if (state.status.isInitializationFailed) {
            return const LoadingView();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                leading: CircleAvatar(
                  child: Text(widget.sender.senderName!.take(1)),
                ),
                title: Text(widget.sender.senderName ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                    )),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Avl. Limit: ${widget.sender.availbleLimit ?? 0.0}"),
                    Text("Total Limit: ${widget.sender.totalLimit ?? 0.0}"),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  children: [
                    Text(widget.beneficiary.beneName ?? "Nil"),
                    const Spacer(),
                    Visibility(
                        visible: widget.beneficiary.isVerified == true,
                        child: const Icon(
                          Icons.verified_rounded,
                          color: Colors.green,
                        ))
                  ],
                ),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Bank : ${widget.beneficiary.bankName}",
                      ),
                      Text("Account No. : ${widget.beneficiary.accountNo}"),
                      Text("IFSC : ${widget.beneficiary.ifsc}"),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 24),
                  maxLines: 1,
                  maxLength: 8,
                  onChanged: (txt) {
                    if (txt.isNotEmpty) {
                      context
                          .read<DmtCheckoutCubit>()
                          .updateAmount(double.parse(txt));
                    } else {
                      context
                          .read<DmtCheckoutCubit>()
                          .updateAmount(double.parse("0"));
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "0",
                      counterText: "",
                      errorText: state.amountValidationError,
                      prefixIcon: const Icon(Icons.currency_rupee_rounded),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16)),
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              Visibility(
                visible: state.canProceed,
                child: ListTile(
                  title: checkoutRow("Amount", state.amount.toString()),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      checkoutRow("Applicable Charges",
                          state.applicableCharges.toString()),
                      checkoutRow("Total", state.total.toString(), isBold: true)
                    ],
                  ),
                ),
              ),
              FilledButton(
                onPressed: state.canProceed
                    ? () {
                        context.read<DmtCheckoutCubit>().addDmtTransaction();
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
                  state.canProceed
                      ? "PAY ₹${state.total.toStringAsFixed(1)}"
                      : "PAY",
                  style: const TextStyle(fontSize: 16, letterSpacing: 2),
                ),
              )
            ],
          );
        },
      ),
    ));
  }

  Widget checkoutRow(String title, String text, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 16, fontWeight: isBold ? FontWeight.bold : null),
          ),
          Text("₹$text",
              style: TextStyle(
                  fontSize: 16, fontWeight: isBold ? FontWeight.bold : null))
        ],
      ),
    );
  }
}
