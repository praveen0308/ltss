import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ImagePickerView extends StatefulWidget {
  final File? image;
  final String? label;
  final String? Function(File?) validator;
  final Function(File) onChanged;

  const ImagePickerView(
      {super.key,
      this.image,
      this.label,
      required this.validator,
      required this.onChanged});

  @override
  State<ImagePickerView> createState() => _ImagePickerViewState();
}

class _ImagePickerViewState extends State<ImagePickerView> {
  File? pickedImage;

  @override
  void initState() {
    if (widget.image != null) {
      pickedImage = widget.image;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<File>(
      builder: (FormFieldState<File> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(widget.label ?? ""),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () async {
                FilePickerResult? file = await FilePicker.platform
                    .pickFiles(type: FileType.image, allowMultiple: false);
                if (file != null) {

                  setState(() {
                    pickedImage = File(file.files.first.path!);

                    widget.onChanged.call(pickedImage!);
                  });
                }
              },
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                padding: const EdgeInsets.all(6),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        image: pickedImage != null
                            ? DecorationImage(image: FileImage(pickedImage!))
                            : null),
                  ),
                ),
              ),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 10),
                child: Text(
                  field.errorText!,
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 13,
                      color: Colors.red[700],
                      height: 0.5),
                ),
              )
          ],
        );
      },
    );
  }
}
