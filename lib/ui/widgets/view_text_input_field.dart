import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInputFieldView extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;
  final bool? isRequired;
  final String? placeHolder;
  final TextInputType? inputType;
  final int? maxLength;
  final bool isEnabled;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final int? lines;
  final AutovalidateMode? autovalidateMode;

  const TextInputFieldView(
      {super.key,
      required this.label,
      required this.textEditingController,
      this.isRequired = false,
      this.placeHolder,
      this.inputType,
      this.maxLength,
      this.isEnabled = true,
      this.validator,
      this.suffixIcon,
      this.lines = 1, this.autovalidateMode});

  String _getInputLabel() {
    if (isRequired == true) {
      return "$label *";
    } else {
      return label;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            _getInputLabel(),
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
        ),
        TextFormField(
          autovalidateMode: autovalidateMode,
          controller: textEditingController,
          maxLength: maxLength,
          enabled: isEnabled,
          keyboardType: inputType,
          style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
          decoration: InputDecoration(
              suffixIcon: suffixIcon,
              hintText: placeHolder,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2, color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(5),
              )),
          validator: validator,
        )
      ],
    );
  }
}
