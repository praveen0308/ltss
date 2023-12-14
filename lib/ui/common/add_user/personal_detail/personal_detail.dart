import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/ui/common/add_user/add_user_cubit.dart';
import 'package:ltss/ui/widgets/widgets.dart';
import 'package:ltss/utils/user_type.dart';

class PersonalDetailPage extends StatefulWidget {
  final UserRole selectedType;
  const PersonalDetailPage({super.key, required this.selectedType});

  @override
  State<PersonalDetailPage> createState() => _PersonalDetailPageState();
}

class _PersonalDetailPageState extends State<PersonalDetailPage> {
  final DropdownFieldViewController _ddlController =
      DropdownFieldViewController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _mobileNumber = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _pincode = TextEditingController();
  final List<UserRole> userTypes = List.empty(growable: true);

  @override
  void initState() {
  /*  userTypes.clear();
    userTypes.add(UserType.distributor);
    userTypes.add(UserType.retailer);
    userTypes.add(UserType.vendor);
    _ddlController.setDropdownItems(userTypes); */
    userTypes.clear();
    userTypes.add(widget.selectedType);
    _ddlController.setDropdownItems(userTypes);

    setState(() {
      _ddlController.setDropdownValue(widget.selectedType);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Visibility(
            visible: false,
            child: DropdownFieldView<UserRole>(
              controller: _ddlController,
              onChanged: (d) {},
              label: "Role",
              isEnabled: false,
            ),
          ),
          TextInputFieldView(
            label: 'First Name',
            textEditingController: _firstName,
          ), TextInputFieldView(
            label: 'Last Name',
            textEditingController: _lastName,
          ),
          TextInputFieldView(
            label: 'Mobile Number',
            textEditingController: _mobileNumber,
            isRequired: true,
          ),
          TextInputFieldView(
            label: 'Email',
            textEditingController: _email,
          ),
          TextInputFieldView(
            label: 'Address',
            textEditingController: _address,
          ),TextInputFieldView(
            label: 'Pincode',
            textEditingController: _pincode,
            inputType: TextInputType.number,
            maxLength: 6,
          ),
          FilledButton(
              onPressed: () {
                context.read<AddUserCubit>().saveUserData(_ddlController.value,
                    _firstName.text,_lastName.text, _mobileNumber.text, _email.text, _address.text,_pincode.text);
              },
              child: const Text("Next"))
        ],
      ),
    );
  }
}
