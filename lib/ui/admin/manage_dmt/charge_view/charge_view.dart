import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/charge_entity.dart';
import 'package:ltss/ui/admin/manage_dmt/charge_view/charge_view_cubit.dart';
import 'package:ltss/ui/widgets/view_error_page.dart';
import 'package:ltss/ui/widgets/view_loading.dart';
import 'package:ltss/ui/widgets/view_status.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:tuple/tuple.dart';

class ChargeView extends StatefulWidget {
  final ChargeEntity chargeEntity;

  const ChargeView({super.key, required this.chargeEntity});

  @override
  State<ChargeView> createState() => _ChargeViewState();
}

class _ChargeViewState extends State<ChargeView> {
  final _name = TextEditingController();
  final _valueController = TextEditingController();
  late ChargeEntity charge;
  bool isEditing = false;
  var isActive = true;
  List<Tuple2> values = [];

  @override
  void initState() {
    charge = widget.chargeEntity;
    _name.text = charge.name ?? "";
    _valueController.text = charge.value ?? "";
    isActive = charge.isActive == true;
    if (charge.value != null) {
      values.addAll(splitIntoTuples(charge.value!));
    }

    super.initState();
  }

  void enableEditing() {
    setState(() {
      isEditing = true;
    });
  }

  void disableEditing() {
    setState(() {
      isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isEditing
        ? Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(border: Border.all()),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          disableEditing();
                        },
                        icon: const Icon(Icons.close)),
                    Text(
                      "Editing ${charge.name}",
                      style: const TextStyle(fontSize: 13),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocConsumer<ChargeViewCubit, ChargeViewState>(
                  builder: (BuildContext context, state) {
                    switch (state) {
                      case ChargeViewInitial():
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextField(
                              controller: _name,
                              onChanged: (txt) {},
                              decoration:
                                  const InputDecoration(label: Text("Name")),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextField(
                              controller: _valueController,
                              onChanged: (txt) {
                                setState(() {
                                  values.clear();
                                  values.addAll(splitIntoTuples(txt));
                                });
                              },
                              decoration:
                                  const InputDecoration(label: Text("Value")),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text("Is Active"),
                            ToggleSwitch(
                              minWidth: 70.0,
                              cornerRadius: 10.0,
                              activeBgColors: [
                                [Colors.red[800]!],
                                [Colors.green[800]!]
                              ],
                              activeFgColor: Colors.white,
                              inactiveBgColor: Colors.grey,
                              inactiveFgColor: Colors.white,
                              initialLabelIndex: isActive ? 1 : 0,
                              totalSwitches: 2,
                              labels: const ["False", "True"],
                              radiusStyle: true,
                              onToggle: (index) {
                                isActive = index == 1;
                              },
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text("Preview:"),
                            valueDisplayTable(values),
                            const SizedBox(
                              height: 8,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            FilledButton(
                                onPressed: () {
                                  context
                                      .read<ChargeViewCubit>()
                                      .updateCharge(
                                          charge.chargeId!,
                                          charge.serviceId!,
                                          _name.text,
                                          _valueController.text,
                                          isActive);
                                },
                                child: const Text("Update")),
                            const SizedBox(
                              height: 8,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  disableEditing();
                                },
                                child: const Text("Cancel")),
                          ],
                        );
                      case Updating():
                        return const LoadingView();
                      case UpdateFailed():
                        return ErrorPageView(
                          msg: state.msg,
                        );
                      case UpdateSuccessful():
                        return Container();
                    }
                  },
                  listener: (BuildContext context, state) {
                    if (state is UpdateSuccessful) {
                      showToast("Updated successfully !!!", ToastType.success);
                      charge = state.newCharge;
                      disableEditing();
                      context.read<ChargeViewCubit>().resetUI();
                    }
                  },
                ),
              ],
            ),
          )
        : Container(
            decoration: BoxDecoration(border: Border.all()),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(charge.name ?? "Nil"),
                  StatusView(status: charge.isActive == true)
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16,),
                  valueDisplayTable(charge.getValues()),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(onPressed: () {
                    enableEditing();
                  }, child: const Text("Edit"))
                ],
              ),
            ),
          );
  }

  Widget valueDisplayTable(List<Tuple2> items) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          var t = items[index];
          return Row(
            children: [
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(border: Border.all()),
                      child: Center(child: Text("${t.item1}")))),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(border: Border.all()),
                      child: Center(child: Text("${t.item2}")))),
            ],
          );
        });
  }
}
