import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/ui/common/add_user/add_user_cubit.dart';
import 'package:ltss/ui/widgets/view_dropdown_field.dart';
import 'package:ltss/ui/widgets/view_image_picker.dart';
import 'package:ltss/ui/widgets/widgets.dart';
import 'package:ltss/utils/user_type.dart';

class KYCDetailPage extends StatefulWidget {
  const KYCDetailPage({super.key});

  @override
  State<KYCDetailPage> createState() => _KYCDetailPageState();
}

class _KYCDetailPageState extends State<KYCDetailPage> {
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
              validator: (File? file) {},
              onChanged: (File file) {
                shopImage = file;
              },
              label: "Shop Image",
            ),
            ImagePickerView(
              validator: (File? file) {},
              onChanged: (File file) {
                profileImage = file;
              },
              label: "Profile Image",
            ),
            const SizedBox(height: 36,),
            FilledButton(onPressed: () {
              context.read<AddUserCubit>().saveKYCDetails(_pan.text, _aadhaar.text, shopImage!, profileImage!);
            }, child: const Text("Submit"))
          ],
        ),
      ),
    );
  }
}
