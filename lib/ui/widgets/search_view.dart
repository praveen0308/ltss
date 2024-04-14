import 'package:flutter/material.dart';
import 'package:ltss/res/res.dart';

class SearchView extends StatelessWidget {
  final Function(String q) onTextChanged;
  final Function(String q) onSearch;

  SearchView({super.key, required this.onTextChanged, required this.onSearch});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 36,
        child: TextField(

          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 12,left: 16),
              fillColor: AppColors.primaryLightest,
              hintText: "Search...",
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide.none,
              ),
              filled: true,
              suffixIcon: IconButton(
                onPressed: () {
                  onSearch(_controller.text);
                },
                icon: const Icon(Icons.search_rounded,size: 16,),

              )),
          controller: _controller,
          style: const TextStyle(fontSize: 12),
          onChanged: (txt) {
            onTextChanged(txt);
          },
        ),
      ),
    );
  }
}
