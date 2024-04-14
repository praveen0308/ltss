import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/local/session_manager.dart';
import 'package:ltss/repository/dmt_repository.dart';
import 'package:ltss/ui/users/dmt/add_customer/add_customer_cubit.dart';
import 'package:ltss/ui/widgets/view_date_text_field.dart';
import 'package:ltss/ui/widgets/view_text_input_field.dart';

@RoutePage()
class AddCustomerScreen extends StatefulWidget implements AutoRouteWrapper {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
        create: (context) => AddCustomerCubit(
              RepositoryProvider.of<DMTRepository>(context),
              RepositoryProvider.of<SessionManager>(context),
            ),
        child: this);
  }
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final _addCustomerForm = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _mobileNumber = TextEditingController();
  final _dob = TextEditingController();
  final _pinCode = TextEditingController();
  final _address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _addCustomerForm,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextInputFieldView(
                  label: "First name",
                  textEditingController: _firstName,
                  validator: (s) {
                    if(s==null || s.length<3){
                      return "Enter valid first name!!!";
                    }
                    return null;
                  },
                ),
                TextInputFieldView(
                  label: "Last name",
                  textEditingController: _lastName,
                  validator: (s) {
                    if(s==null || s.length<3){
                      return "Enter valid last name!!!";
                    }
                    return null;
                  },
                ),
                TextInputFieldView(
                  label: "Mobile number",
                  textEditingController: _mobileNumber,
                  inputType: TextInputType.number,
                  maxLength: 10,
                  validator: (s) {
                    if(s==null || s.length<10){
                      return "Enter valid mobile number!!!";
                    }
                    return null;
                  },
                ),
                DateTextFieldView(
                  label: "DOB",
                  isRequired: false,
                  onDateSelected: (DateTime dateTime) {},
                  validator: (String? val) {
                    return null;
                  

                  },
                ),
                TextInputFieldView(
                  label: "Pin Code",
                  textEditingController: _pinCode,
                  inputType: TextInputType.number,
                  maxLength: 6,
                  validator: (s) {
                    if((s !=null && s.isNotEmpty) && s.length<6){
                      return "Enter valid 6-digit pincode";
                    }
                    return null;
                  },
                ),
                TextInputFieldView(
                    label: "Address", textEditingController: _address,validator: (s){
                      return null;
                    

                },),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FilledButton(onPressed: () {
          if(_addCustomerForm.currentState!.validate()){
            // todo call add customer api
            // context.read<AddCustomerCubit>()
          }
        }, child: const Text("Submit")),
      ),
    ));
  }
}
