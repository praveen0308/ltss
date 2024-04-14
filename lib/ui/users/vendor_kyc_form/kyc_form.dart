import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/routes/route_imports.gr.dart';
import 'package:ltss/ui/users/vendor_kyc_form/kyc_form_cubit.dart';
import 'package:ltss/ui/widgets/view_image_picker.dart';
import 'package:ltss/ui/widgets/widgets.dart';

@RoutePage()
class KYCFormPage extends StatefulWidget implements AutoRouteWrapper {
  const KYCFormPage({super.key});

  @override
  State<KYCFormPage> createState() => _KYCFormPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) =>
        KycFormCubit(RepositoryProvider.of<KYCRepository>(context)),
      child: this,);
  }
}

class _KYCFormPageState extends State<KYCFormPage> {
  final TextEditingController _pan = TextEditingController();
  final TextEditingController _aadhaar = TextEditingController();

  File? shopImage;
  File? profileImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("KYC Form"),
        ),
        body: BlocConsumer<KycFormCubit, KycFormState>(
          listener: (context, state) {
            if (state is KYCFormFailed) {
              showToast(state.msg, ToastType.error);
            }
            if (state is KYCFormDone) {
              showToast("KYC done successfully!!!", ToastType.success);
              AutoRouter.of(context).popAndPush(const TNCFormRoute());
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextInputFieldView(
                      label: 'PAN',
                      textEditingController: _pan,
                    ),
                    TextInputFieldView(
                      label: 'Aadhaar Number',
                      textEditingController: _aadhaar,
                      isRequired: true,
                    ),
                    ImagePickerView(
                      validator: (File? file) {
                        return null;
                      },
                      onChanged: (File file) {
                        shopImage = file;
                      },
                      label: "Shop Image",
                    ),
                    ImagePickerView(
                      validator: (File? file) {
                        return null;
                      },
                      onChanged: (File file) {
                        profileImage = file;
                      },
                      label: "Profile Image",
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    FilledButton(
                        onPressed: () {
                          context.read<KycFormCubit>().submitKYCForm(
                              _pan.text, _aadhaar.text, shopImage!,
                              profileImage!);
                        },
                        child: const Text("Submit"))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
