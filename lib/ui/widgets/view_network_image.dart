import 'package:flutter/material.dart';

class NetworkImageView extends StatelessWidget {
  final String url;
  final String? label;
  final double? height;
  final double? width;
  final VoidCallback? onClick;
  final bool withErrorMsg;

  const NetworkImageView(
      {super.key,
      required this.url,
      this.height,
      this.width,
      this.onClick,
      this.label,
      this.withErrorMsg = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(


        children: [
          if (label != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                label!,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
            ),
          Image.network(
            url,
            height: height ?? 80,
            width: width ?? 80,
            loadingBuilder: (cxt, w, event) {
              return const CircularProgressIndicator();
            },
            errorBuilder: (cxt, obj, stacktrace) {
              if(withErrorMsg){
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all()),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_rounded,
                        size: 80,
                      ),
                      Text("Image loading failed!!")
                    ],
                  ),
                );
              }else{
                return const Icon(
                  Icons.error_rounded,
                  size: 80,
                );
              }
              return const Icon(
                Icons.error_rounded,
                size: 80,
              );

            },
          ),
        ],
      ),
    );
  }
}
