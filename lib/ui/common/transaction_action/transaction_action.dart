import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/dmt_transaction.dart';
import 'package:ltss/repository/transaction_repository.dart';
import 'package:ltss/ui/admin/dashboard/bloc/dashboard_screen_bloc.dart';
import 'package:ltss/ui/common/transaction_action/transaction_action_cubit.dart';
import 'package:ltss/ui/widgets/view_error_page.dart';
import 'package:ltss/ui/widgets/view_highlighted_label.dart';
import 'package:ltss/ui/widgets/view_image_picker.dart';
import 'package:ltss/ui/widgets/view_loading.dart';
import 'package:ltss/ui/widgets/view_text_input_field.dart';

enum TransactionAction {
  accept("DONE"),
  reject("REJECTED"),
  verify("DONE & VERIFIED");

  final String text;

  const TransactionAction(this.text);
}

@RoutePage()
class TransactionActionScreen extends StatefulWidget
    implements AutoRouteWrapper {
  final DmtTransaction transaction;
  final TransactionAction action;

  const TransactionActionScreen(
      {super.key, required this.transaction, required this.action});

  @override
  State<TransactionActionScreen> createState() =>
      _TransactionActionScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionActionCubit(
          RepositoryProvider.of<SessionManager>(context),
          RepositoryProvider.of<DMTRepository>(context),
          RepositoryProvider.of<TransactionRepository>(context)),
      child: this,
    );
  }
}

class _TransactionActionScreenState extends State<TransactionActionScreen> {
  final TextEditingController _comment = TextEditingController();
  File? _screenshot;

  @override
  void initState() {
    context
        .read<TransactionActionCubit>()
        .init(widget.transaction.transactionId!, widget.action);
    super.initState();
  }

  @override
  void dispose() {
    _comment.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: Platform.isAndroid,
        actions: [
          if(Platform.isWindows)IconButton(
              onPressed: () {
                context.read<DashboardScreenBloc>().add(Empty());
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: BlocConsumer<TransactionActionCubit, TransactionActionState>(
          builder: (context, state) {
            switch (state) {
              case Initializing():
                return const LoadingView();
              case InitializationSuccessful():
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (state.uploadSsEnabled)
                      ImagePickerView(
                        validator: (File? file) {},
                        onChanged: (File file) {
                          _screenshot = file;
                        },
                        label: "Screenshot",
                      ),
                    if (state.commentEnabled)
                      TextInputFieldView(
                          label: "Comment", textEditingController: _comment),
                    if (state.tracking != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HighlightedLabel(
                                  text: state.tracking?.lastStatus ?? ""),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Icon(Icons.arrow_right_alt_rounded),
                              ),
                              HighlightedLabel(
                                  text: state.tracking?.status ?? ""),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Image(
                              image:
                                  NetworkImage(state.tracking?.extras ?? "")),
                          const SizedBox(
                            height: 16,
                          ),
                          Text("Comment: ${state.tracking?.comment ?? "Nil"}")
                        ],
                      ),
                    FilledButton(
                        onPressed: () {
                          context.read<TransactionActionCubit>().updateStatus(
                              widget.transaction.transactionId!,
                              widget.action.text,
                              screenshot: _screenshot,
                              comment:
                                  _comment.text.isEmpty ? null : _comment.text);
                        },
                        child: Text(state.buttonText))
                  ],
                );
              case InitializationFailed():
                return ErrorPageView(
                  msg: state.msg,
                );
              default:
                return Container();
            }
          },
          buildWhen: (prev, state) {
            return state is TransactionActionInitial ||
                state is Initializing ||
                state is InitializationSuccessful ||
                state is InitializationFailed;
          },
          listener: (context, state) {
            if(state is Updating){
              SmartDialog.showLoading();
            }else{
              SmartDialog.dismiss();
            }

            if(state is UpdateSuccessful){
              if(Platform.isWindows){
                context.read<DashboardScreenBloc>().add(Empty());
              }else{
                AutoRouter.of(context).pop();
              }

            }
            if(state is UpdateFailed){
              showToast(state.msg, ToastType.error);
            }

          }),
    ));
  }
}
