import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/models/api/entity/beneficiary_entity.dart';
import 'package:ltss/models/api/entity/user_entity.dart';
import 'package:ltss/routes/routes.dart';
import 'package:ltss/ui/widgets/view_text_input_field.dart';

import 'dmt_cubit.dart';

@RoutePage()
class DMTScreen extends StatefulWidget implements AutoRouteWrapper {
  const DMTScreen({super.key});

  @override
  State<DMTScreen> createState() => _DMTScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => DmtCubit(),
      child: this,
    );
  }
}

class _DMTScreenState extends State<DMTScreen> {
  final TextEditingController _amount = TextEditingController();
  UserEntity? customer;
  BeneficiaryEntity? beneficiary;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("DMT"),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text("Customer"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (customer != null)
                  ListTile(
                    title: const Text("Name"),
                    subtitle: Text(customer?.firstName ?? "Nil"),
                  ),
                if (customer != null)
                  ListTile(
                    title: const Text("Mobile Number"),
                    subtitle: Text(customer?.mobileNo ?? "Nil"),
                  ),
                FilledButton(
                    onPressed: () async {
                      var result = await AutoRouter.of(context).push(
                              SelectCustomerRoute(selectedCustomer: customer))
                          as UserEntity?;

                      if (result != null) {
                        setState(() {
                          customer = result;
                        });
                      }
                    },
                    child:
                        Text(customer == null ? "Select Customer" : "Change"))
              ],
            ),
          ),
          ListTile(
            title: const Text("Beneficiary"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (beneficiary != null)
                  ListTile(
                    title: const Text("Name"),
                    subtitle: Text(beneficiary?.name ?? "Nil"),
                  ),
                if (beneficiary != null)
                  ListTile(
                    title: const Text("Account Number"),
                    subtitle: Text(beneficiary?.accountNumber ?? "Nil"),
                  ),
                if (beneficiary != null)
                  ListTile(
                    title: const Text("Bank"),
                    subtitle: Text(beneficiary?.bank ?? "Nil"),
                  ),
                if (beneficiary != null)
                  ListTile(
                    title: const Text("IFSC"),
                    subtitle: Text(beneficiary?.ifscCode ?? "Nil"),
                  ),
                if (beneficiary != null)
                  ListTile(
                    title: const Text("Mobile Number"),
                    subtitle: Text(beneficiary?.mobileNumber ?? "Nil"),
                  ),
                FilledButton(
                    onPressed: () async {
                      /*var result = await AutoRouter.of(context).push(
                              SelectBeneficiaryRoute(
                                  selectedBeneficiary: beneficiary))
                          as BeneficiaryEntity?;

                      if (result != null) {
                        setState(() {
                          beneficiary = result;
                        });
                      }*/
                    },
                    child: Text(
                        beneficiary == null ? "Select Beneficiary" : "Change"))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextInputFieldView(
                label: "Amount",
                textEditingController: _amount,
                inputType: TextInputType.number),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FilledButton(onPressed: () {}, child: const Text("Transfer")),
      ),
    ));
  }
}
