import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/bank_entity.dart';
import 'package:ltss/models/api/entity/bank_vendor.dart';
import 'package:ltss/models/api/entity/user_entity.dart';
import 'package:ltss/ui/admin/dashboard/bloc/dashboard_screen_bloc.dart';
import 'package:ltss/ui/admin/manage_dmt/add_dmt_vendor/add_dmt_vendor_cubit.dart';
import 'package:ltss/ui/widgets/view_error_page.dart';
import 'package:ltss/ui/widgets/widgets.dart';
import 'package:ltss/utils/operations.dart';

class AddDMTVendor extends StatefulWidget {
  final BankVendor? bankVendor;

  const AddDMTVendor({super.key, this.bankVendor});

  @override
  State<AddDMTVendor> createState() => _AddDMTVendorState();
}

class _AddDMTVendorState extends State<AddDMTVendor> {
  final GlobalKey<FormState> _addVendorFormKey = GlobalKey();
  final DropdownFieldViewController<BankEntity> _banks =
      DropdownFieldViewController<BankEntity>();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _mobileNumber = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final DateTextFieldViewController _dob = DateTextFieldViewController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _pincode = TextEditingController();
  final List<UserRole> userTypes = List.empty(growable: true);
  late UserEntity _userEntity;
  BankEntity? _selectedBank;
  var isActive = true;
  var operation = Operations.add;

  @override
  void initState() {
    if (widget.bankVendor != null) {
      _userEntity = widget.bankVendor!.vendor!;
      _selectedBank = widget.bankVendor!.bank!;
      operation = Operations.update;

      _firstName.text = _userEntity.firstName ?? "";
      _lastName.text = _userEntity.lastName ?? "";
      _mobileNumber.text = _userEntity.mobileNo ?? "";
      _email.text = _userEntity.email ?? "";
      _pincode.text = _userEntity.pincode ?? "";
      _address.text = _userEntity.address ?? "";

      _userEntity.dob.let((value) {
        _dob.value = DateFormat("dd-MM-yyyy").parse(value);
      });

      isActive = _userEntity.isActive!;
    }
    context.read<AddDmtVendorCubit>().loadBanks();
    super.initState();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _mobileNumber.dispose();
    _email.dispose();
    _pincode.dispose();
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${operation.isAdd() ? "Add" : "Update"} Vendor"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                context.read<DashboardScreenBloc>().add(Empty());
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: BlocConsumer<AddDmtVendorCubit, AddDmtVendorState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            showSnackBar(context, "Saved Successfully!!!");
            context.read<DashboardScreenBloc>().add(Empty());
          }
        },
        builder: (context, state) {
          if (state.status.isInitializing) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status.isInitializationFailed) {
            return ErrorPageView(msg: state.msg);
          }
          if (state.status.isInitializationSuccessful) {
            _banks.setDropdownItems(state.banks);
            if(_selectedBank!=null){
              var bank = state.banks?.firstWhere(
                      (element) => element.bankId == _selectedBank!.bankId);
              _banks.setDropdownValue(bank);
            }

          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _addVendorFormKey,
              child: SingleChildScrollView(
                child : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownFieldView<BankEntity>(
                      controller: _banks,
                      onChanged: (d) {},
                      label: "Bank",
                      validator: (v) {
                        if (v != null) {
                          return null;
                        }
                        return "Select a bank!!";
                      },
                    ),
                    TextInputFieldView(
                      label: 'First Name',
                      textEditingController: _firstName,
                      validator: (txt) {
                        if (txt != null && txt.isNotEmpty && txt.length > 2) {
                          return null;
                        }
                        return "Enter valid first name!!";
                      },
                    ),
                    TextInputFieldView(
                      label: 'Last Name',
                      textEditingController: _lastName,
                      validator: (txt) {
                        if (txt != null && txt.isNotEmpty && txt.length > 2) {
                          return null;
                        }
                        return "Enter valid last name!!";
                      },
                    ),
                    TextInputFieldView(
                      label: 'Mobile Number',
                      textEditingController: _mobileNumber,
                      isRequired: true,
                      maxLength: 10,
                      inputType: TextInputType.number,
                      validator: (txt) {
                        if (txt != null && txt.length == 10) {
                          return null;
                        }
                        return "Enter valid mobile number !!";
                      },
                    ),
                    TextInputFieldView(
                      label: 'Email',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textEditingController: _email,
                      inputType: TextInputType.emailAddress,
                      validator: (txt) {
                        if (txt != null && txt.isNotEmpty && txt.isValidEmail()) {
                          return null;
                        }
                        return "Enter valid email address !!";
                      },
                    ),
                    DateTextFieldView(
                        label: "DOB",
                        isRequired: false,
                        onDateSelected: (d) {},
                        validator: (v) {
                          return null;
                        }),
                    TextInputFieldView(
                      label: 'Address',
                      textEditingController: _address,
                      validator: (txt) {
                        if (txt != null && txt.isNotEmpty && txt.length > 2) {
                          return null;
                        }
                        return "Enter valid last name!!";
                      },
                    ),
                    TextInputFieldView(
                      label: 'Pincode',
                      textEditingController: _pincode,
                      inputType: TextInputType.number,
                      maxLength: 6,
                      validator: (txt) {
                        if (txt != null && txt.isNotEmpty && txt.length == 6) {
                          return null;
                        }
                        return "Enter valid pincode!!";
                      },
                    ),
                    LoadingButtonView(
                        onPressed: () {
                          if (_addVendorFormKey.currentState!.validate()) {
                            if (operation.isAdd()) {
                              context.read<AddDmtVendorCubit>().addNewVendor(
                                  UserEntity(
                                    firstName: _firstName.text,
                                    lastName: _lastName.text,
                                    mobileNo: _mobileNumber.text,
                                    email: _email.text,
                                    pincode: _pincode.text,
                                    dob: _dob.getFormattedDate(),
                                    address: _address.text,
                                  ),
                                  _banks.value!.bankId!);
                            } else {
                              context.read<AddDmtVendorCubit>().updateVendor(
                                  _userEntity.id!,
                                  UserEntity(
                                    firstName: _firstName.text,
                                    lastName: _lastName.text,
                                    mobileNo: _mobileNumber.text,
                                    email: _email.text,
                                    pincode: _pincode.text,
                                    dob: _dob.getFormattedDate(),
                                    address: _address.text,
                                  ),
                                  _banks.value!.bankId!);
                            }
                          }
                        },
                        text: "Submit",
                        isLoading: state.status.isLoading)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
