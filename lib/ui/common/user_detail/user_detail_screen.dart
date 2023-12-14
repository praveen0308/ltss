import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/user_detail_entity.dart';
import 'package:ltss/ui/admin/dashboard/bloc/dashboard_screen_bloc.dart';
import 'package:ltss/ui/common/user_detail/user_detail_cubit.dart';
import 'package:ltss/ui/widgets/view_error_page.dart';
import 'package:ltss/ui/widgets/view_loading.dart';
import 'package:ltss/ui/widgets/widgets.dart';

import '../../../routes/route_imports.gr.dart';

@RoutePage()
class UserDetailScreen extends StatefulWidget implements AutoRouteWrapper {
  final int userId;

  const UserDetailScreen({super.key, required this.userId});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDetailCubit(
          RepositoryProvider.of<UserRepository>(context),
          RepositoryProvider.of<SessionManager>(context)),
      child: this,
    );
  }
}

class _UserDetailScreenState extends State<UserDetailScreen>
    with BasePageState<UserDetailScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _aadhaar = TextEditingController();
  final TextEditingController _pan = TextEditingController();

  bool blockEnabled = false;
  bool unBlockEnabled = false;

  late UserDetailEntity user;

  @override
  void initState() {
    context.read<UserDetailCubit>().fetchUserDetail(userId: widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: Platform.isAndroid,
        actions: [
          if (Platform.isWindows)
            IconButton(
                onPressed: () {
                  context.read<DashboardScreenBloc>().add(Empty());
                },
                icon: const Icon(Icons.clear))
        ],
      ),
      body: BlocConsumer<UserDetailCubit, UserDetailState>(
        listener: (context, state) {
          showLoading(state is PerformingAction);
          if (state is PerformActionFailed) {
            showSnackBar(context, state.msg);
          }
          if (state is ActionSuccessful) {
            showSnackBar(context, state.msg);
            context
                .read<UserDetailCubit>()
                .fetchUserDetail(userId: widget.userId);
          }
          if (state is OnDataLoaded) {
            user = state.data;
            _email.text = user.email ?? "";
            _mobile.text = user.mobileNo ?? "";
            _address.text = user.address ?? "";
            _aadhaar.text = user.aadhaar ?? "";
            _pan.text = user.pan ?? "";

            blockEnabled = state.blockEnabled;
            unBlockEnabled = state.unblockEnabled;
          }
        },
        builder: (context, state) {
          if (state is LoadingData) {
            return const LoadingView();
          }
          if (state is NoData) {
            return const ErrorPageView(
              msg: "NO DATA",
            );
          }
          if (state is DataLoadFailed) {
            return ErrorPageView(
              msg: state.msg,
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    NetworkImageView(url: user.profileImage.toString()),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.getName() ?? "",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18)),
                          const SizedBox(
                            height: 5,
                          ),
                          HighlightedLabel(
                              text: UserRole.getUserRoleName(
                                      user.roleId?.toInt()) ??
                                  "")
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                WalletView(balance: user.walletBalance ?? 0),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: DashboardItemView(
                          title: "Requests",
                          subTitle: user.requestCount.toString(),
                          onClick: () {}),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: DashboardItemView(
                          subTitle: user.userCount.toString(),
                          title: "Users",
                          onClick: () {}),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 32, bottom: 8),
                  child: Text(
                    "Details",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                TextInputFieldView(
                  label: "Email",
                  textEditingController: _email,
                  isEnabled: false,
                ),
                TextInputFieldView(
                  label: "Mobile No.",
                  textEditingController: _mobile,
                  isEnabled: false,
                ),
                TextInputFieldView(
                  label: "Address",
                  textEditingController: _address,
                  isEnabled: false,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 32, bottom: 8),
                  child: Text(
                    "KYC Details",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                TextInputFieldView(
                  label: "AADHAAR",
                  textEditingController: _aadhaar,
                  isEnabled: false,
                ),
                TextInputFieldView(
                  label: "PAN",
                  textEditingController: _pan,
                  isEnabled: false,
                ),
                label("Shop Image"),
                NetworkImageView(
                  url: user.shopImage.toString(),
                  width: double.infinity,
                  height: 200,
                  withErrorMsg: true,
                ),
                label("Profile Image"),
                NetworkImageView(
                    url: user.profileImage.toString(),
                    width: double.infinity,
                    height: 200,
                    withErrorMsg: true),
                const SizedBox(
                  height: 32,
                ),
                if (blockEnabled)
                  OutlinedButton(
                      onPressed: () {
                        context
                            .read<UserDetailCubit>()
                            .blockUser(userId: widget.userId);
                      },
                      child: const Text("Block")),
                if (unBlockEnabled)
                  OutlinedButton(
                      onPressed: () {
                        context
                            .read<UserDetailCubit>()
                            .blockUser(userId: widget.userId, status: true);
                      },
                      child: const Text("Unblock")),
              ],
            )),
          );
        },
      ),
    ));
  }
}
