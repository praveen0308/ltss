import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/bank_entity.dart';
import 'package:ltss/ui/widgets/view_text_input_field.dart';
import 'package:search_choices/search_choices.dart';

import 'add_beneficiary_cubit.dart';

@RoutePage()
class AddBeneficiaryScreen extends StatefulWidget implements AutoRouteWrapper {
  const AddBeneficiaryScreen({super.key});

  @override
  State<AddBeneficiaryScreen> createState() => _AddBeneficiaryScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
        create: (context) => AddBeneficiaryCubit(
              RepositoryProvider.of<DMTRepository>(context),
              RepositoryProvider.of<SessionManager>(context),
            ),
        child: this);
  }
}

class _AddBeneficiaryScreenState extends State<AddBeneficiaryScreen> {
  final _name = TextEditingController();
  final _mobileNo = TextEditingController();
  final _accountNo = TextEditingController();
  final _confirmAccountNo = TextEditingController();
  final _ifsc = TextEditingController();
  BankEntity _selectedBank = BankEntity();
  var bankList = List<DropdownMenuItem<BankEntity>>.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Add Beneficiary"),
          ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextInputFieldView(label: "Name", textEditingController: _name,validator: (s){
                if(s == null || s.length<3){
                  return "Enter valid name!!!";
                }
                return null;
              },),
              TextInputFieldView(label: "Mobile Number", textEditingController: _mobileNo,inputType: TextInputType.number,maxLength: 10,validator: (s) {
                if(s==null || s.length<10){
                  return "Enter valid mobile number!!!";
                }
                return null;
              },),
              TextInputFieldView(label: "Account Number", textEditingController: _accountNo,validator: (s) {
                if(s==null || s.length<9){
                  return "Enter valid account number!!!";
                }
                return null;
              },),
              TextInputFieldView(label: "Confirm Account Number", textEditingController: _confirmAccountNo,validator: (s) {
                if(s==null || s!=_accountNo.text){
                  return "Confirm account number doesn't match !!!";
                }
                return null;
              },),
              const SizedBox(height: 16,),
              const Text("Bank"),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all()
                ),
                child: SearchChoices.single(
                  displayClearIcon: false,
                  underline: "",
                  padding: const EdgeInsets.all(5),
                  items: bankList,
                  value: _selectedBank,
                  hint: "Select one",
                  searchHint: "Select one",
                  onChanged: (value) {
                    setState(() {
                      _selectedBank = value;
                    });
                  },
                  isExpanded: true,
                ),
              ),
              TextInputFieldView(label: "IFSC", textEditingController: _ifsc,validator: (s) {
        if(s==null || s.length<11){
        return "Enter valid IFSC code(ABCDXXXXXXX) !!!";
        }
        return null;
        },),
            ],
          ),
        ),
      ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton(onPressed: (){}, child: const Text("Submit")),
          ),
    ));
  }
}
