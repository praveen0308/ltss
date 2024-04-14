import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/base/base_page.dart';
import 'package:ltss/local/session_manager.dart';
import 'package:ltss/models/api/entity/user_detail_entity.dart';
import 'package:ltss/repository/user_repository.dart';
import 'package:ltss/routes/routes.dart';
import 'package:ltss/ui/users/my_profile/my_profile_cubit.dart';
import 'package:ltss/ui/widgets/view_error_page.dart';
import 'package:ltss/ui/widgets/view_loading.dart';
import 'package:ltss/ui/widgets/widgets.dart';
import 'package:ltss/utils/user_type.dart';

@RoutePage()
class MyProfileScreen extends StatefulWidget implements AutoRouteWrapper {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => MyProfileCubit(
          RepositoryProvider.of<SessionManager>(context),
          RepositoryProvider.of<UserRepository>(context)),
      child: this,
    );
  }
}

class _MyProfileScreenState extends State<MyProfileScreen>
    with BasePageState<MyProfileScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _aadhaar = TextEditingController();
  final TextEditingController _pan = TextEditingController();
  late UserDetailEntity user;

  @override
  void initState() {
    context.read<MyProfileCubit>().fetchUserDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<MyProfileCubit, MyProfileState>(
        listener: (context, state) {
          if (state is OnDataLoaded) {
            user = state.data;
            _email.text = user.email ?? "";
            _mobile.text = user.mobileNo ?? "";
            _address.text = user.address ?? "";
            _aadhaar.text = user.aadhaar ?? "";
            _pan.text = user.pan ?? "";
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
                    NetworkImageView(url: user.profileImage??""),
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
                  url: user.shopImage??"",
                  width: double.infinity,
                  height: 200,
                  withErrorMsg: true,
                ),
                label("Profile Image"),
                NetworkImageView(
                    url: user.profileImage??"",
                    width: double.infinity,
                    height: 200,
                    withErrorMsg: true),
                const SizedBox(
                  height: 32,
                ),
                /*OutlinedButton(
                    onPressed: () {
                      AutoRouter.of(context).push(const EditProfileRoute());
                    },
                    child: const Text("Edit Profile")),*/
              ],
            )),
          );
        },
      ),
    ));
  }
}
