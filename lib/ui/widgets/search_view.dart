import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  final Function(String q) onTextChanged;
  final Function(String q) onSearch;
  SearchView({super.key, required this.onTextChanged, required this.onSearch});

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search by name..."
              ),
              controller: _controller,
              onChanged: (txt){
                onTextChanged(txt);
              },
            ),
          ),
          const SizedBox(width: 16,),
          ElevatedButton(onPressed: (){
            onSearch(_controller.text);
          }, child:const Text("Search"))
        ],
      ),
    );
  }
}
