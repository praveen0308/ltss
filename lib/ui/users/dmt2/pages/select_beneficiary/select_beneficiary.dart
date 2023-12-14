import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/beneficiary_entity.dart';
import 'package:ltss/models/api/sampurna/sampurna.dart';
import 'package:ltss/routes/route_imports.gr.dart';
import 'package:ltss/ui/widgets/view_error_page.dart';
import 'package:ltss/ui/widgets/view_loading.dart';

import 'select_beneficiary_cubit.dart';

@RoutePage()
class SelectBeneficiaryScreen extends StatefulWidget
    implements AutoRouteWrapper {
  final String mobileNo;

  const SelectBeneficiaryScreen({super.key, required this.mobileNo});

  @override
  State<SelectBeneficiaryScreen> createState() =>
      _SelectBeneficiaryScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
        create: (context) => SelectBeneficiaryCubit(
              RepositoryProvider.of<DMTRepository>(context),
              RepositoryProvider.of<SessionManager>(context),
            ),
        child: this);
  }
}

class _SelectBeneficiaryScreenState extends State<SelectBeneficiaryScreen> {
  Beneficiary? selectedBeneficiary;

  void setSelectedBeneficiary(Beneficiary beneficiary) {
    setState(() {
      selectedBeneficiary = beneficiary;
    });
  }

  @override
  void initState() {
    context.read<SelectBeneficiaryCubit>().fetchData(widget.mobileNo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Select Beneficiary"),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<SelectBeneficiaryCubit, SelectBeneficiaryState>(
                builder: (context, state) {
                  switch (state) {
                    case SelectBeneficiaryInitial():
                      return Container();
                    case LoadingData():
                      return const LoadingView();
                    case ReceivedData():
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          var beneficiary = state.data[index];
                          return RadioListTile<Beneficiary>(
                            title: Text(beneficiary.beneName ?? "Nil"),
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    "Bank Details",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text("Bank : ${beneficiary.bankName}" ?? "Nil"),
                                  Text("Account No. : ${beneficiary.accountNo}" ??
                                      "Nil"),
                                  Text("IFSC : ${beneficiary.ifsc}" ?? "Nil"),
                                ]),
                            value: beneficiary,
                            groupValue: selectedBeneficiary,
                            onChanged: (Beneficiary? value) {
                              setSelectedBeneficiary(value!);
                            },
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
                    case NoBeneficiariesFound():
                      return const Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person,size: 100,),
                          SizedBox(height: 16,),
                          Text("Beneficiaries not found!!!",style: TextStyle(fontSize: 18),)
                        ],
                      ),);
                  }
                },
                listener: (context, state) {
                  if(state is ReceivedData){
                    if(state.data.isNotEmpty){
                      setSelectedBeneficiary(state.data.first);
                    }

                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OutlinedButton(onPressed: (){
                  AutoRouter.of(context).push(const AddBeneficiaryRoute());
                }, child:const Text("Add Beneficiary")),
                FilledButton(onPressed: (){
                  // AutoRouter.of(context).navigate(const DMTCheckoutRoute());
                }, child:const Text("Next")),
              ],
            ),
          ),
        ],
      ),

    ));
  }
}
