import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/user_entity.dart';
import 'package:ltss/ui/users/pages/requests/add/add_fund_request_cubit.dart';
import 'package:ltss/ui/widgets/view_text_input_field.dart';

@RoutePage()
class AddFundRequestScreen extends StatefulWidget implements AutoRouteWrapper {
  const AddFundRequestScreen({super.key});

  @override
  State<AddFundRequestScreen> createState() => _AddFundRequestScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => AddFundRequestCubit(
        RepositoryProvider.of<FundRequestRepository>(context),
        RepositoryProvider.of<UserRepository>(context),
      ),
      child: this,
    );
  }
}

class _AddFundRequestScreenState extends State<AddFundRequestScreen>
    with BasePageState<AddFundRequestScreen> {
  var selectedDistributor = 0;
  final List<UserEntity> distributors = List.empty(growable: true);
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    context.read<AddFundRequestCubit>().loadDistributors();
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AddFundRequestCubit, AddFundRequestState>(
            builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Distributors",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var distributor = distributors[index];
                    return RadioListTile(
                        value: distributor.id,
                        title: Text(distributor.firstName ?? "Nil"),
                        subtitle: Text(
                            UserRole.getUserRoleName(distributor.roleId) ?? ""),
                        groupValue: selectedDistributor,
                        onChanged: (v) {
                          selectedDistributor = v ?? 0;
                          setState(() {});
                        });
                  },
                  itemCount: distributors.length,
                ),
                TextInputFieldView(
                  label: "Amount",
                  textEditingController: _amountController,
                  isRequired: true,
                  inputType: TextInputType.number,
                ),
                TextInputFieldView(
                  label: "Comment",
                  textEditingController: _commentController,
                  isRequired: false,
                  inputType: TextInputType.text,
                ),
                const Spacer(),
                FilledButton(
                    onPressed: () {
                      context.read<AddFundRequestCubit>().addFundRequest(
                          selectedDistributor,
                          double.parse(_amountController.text),
                          _commentController.text);
                    },
                    child: const Text("Submit"))
              ],
            ),
          );
        }, listener: (context, state) {
          showLoading(state is LoadingDistributors || state is AddingRequest);
          if (state is DistributorsLoaded) {
            distributors.clear();
            distributors.addAll(state.distributors);
            selectedDistributor = distributors[0].id ?? 0;
          }

          if (state is AddedSuccessfully) {
            showSnackBar(context, "Added Successfully!!");
            AutoRouter.of(context).pop();
          }

          if (state is AddFundRequestFailed) {
            showSnackBar(context, state.msg);
          }

          if (state is LoadDistributorsFailed) {
            showSnackBar(context, state.msg);
          }
        }),
      ),
    );
  }
}
