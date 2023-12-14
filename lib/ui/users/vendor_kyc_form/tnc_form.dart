import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:ltss/generated/assets.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../routes/route_imports.gr.dart';

@RoutePage()
class TNCFormScreen extends StatefulWidget {
  const TNCFormScreen({super.key});

  @override
  State<TNCFormScreen> createState() => _TNCFormState();
}

class _TNCFormState extends State<TNCFormScreen> {
  String tnc = "";
  bool isLoading = true;
  bool isAccepted = false;

  @override
  void initState() {
    loadTnc();
    super.initState();
  }

  void loadTnc() {
    rootBundle.loadString(Assets.assetsTnc).then((text) {
      setState(() {
        tnc = text;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("Terms and conditions")),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HtmlWidget(
                      tnc,
                      renderMode: RenderMode.column,
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      value: isAccepted,
                      onChanged: (val) {
                        setState(() {
                          isAccepted = val ?? false;
                        });
                      },
                      title: const Text("I accept terms and conditions."),
                    ),
                    FilledButton(
                        onPressed: isAccepted
                            ? () {
                                AutoRouter.of(context)
                                    .popAndPush(const UserDashboardRoute());
                              }
                            : null,
                        child: const Text("Get Started"))
                  ],
                ),
              ),
            ),
    ));
  }
}
