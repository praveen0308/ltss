import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ltss/generated/assets.dart';
import 'package:ltss/repository/auth_repository.dart';
import 'package:ltss/res/colors.dart';
import 'package:ltss/routes/routes.dart';
import 'package:ltss/ui/common/auth/enter_mobile_number/enter_mobile_number_cubit.dart';
import 'package:ltss/ui/widgets/view_loading_button.dart';
import 'package:ltss/utils/ext_methods.dart';

@RoutePage()
class EnterMobileNumberScreen extends StatefulWidget
    implements AutoRouteWrapper {
  const EnterMobileNumberScreen({super.key});

  @override
  State<EnterMobileNumberScreen> createState() =>
      _EnterMobileNumberScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => EnterMobileNumberCubit(
          RepositoryProvider.of<AuthRepository>(context)),
      child: this,
    );
  }
}

class _EnterMobileNumberScreenState extends State<EnterMobileNumberScreen> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    _controller.text = "9699960540";
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<EnterMobileNumberCubit, EnterMobileNumberState>(
        listener: (context, state) {
          if (state is EnterMobileNumberBase) {
            if (state.status == EnterMobileNumberStatus.success) {
              showSnackBar(context, state.msg);
              AutoRouter.of(context)
                  .push(VerifyOtpRoute(mobileNumber: _controller.text));
            }
            if (state.status == EnterMobileNumberStatus.error) {
              showSnackBar(context, state.msg);
            }
          }
        },
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Row(
              children: [
                if (constraints.maxWidth > 600)
                  Expanded(
                      child: Container(
                    color: AppColors.primaryDark,
                  )),
                Expanded(
                  child: BlocBuilder<EnterMobileNumberCubit,
                      EnterMobileNumberState>(
                    builder: (context, state) {
                      if (state is EnterMobileNumberBase) {
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: MediaQuery.of(context).size.height,
                              minWidth: MediaQuery.of(context).size.width,
                            ),
                            child: IntrinsicHeight(
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      SvgPicture.asset(
                                        Assets.assetsArtLogin,
                                        height: 300,
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      const Text("Mobile Number Verification",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 24)),
                                      const Text(
                                        "We will send  you a one time password to your registered mobile number",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      const Text("Enter Mobile No."),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        controller: _controller,
                                        keyboardType: TextInputType.number,
                                        maxLength: 10,
                                        maxLines: 1,
                                        textInputAction: TextInputAction.done,
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                            counterText: "",
                                            hintText: "00000 00000",
                                            border: UnderlineInputBorder()),
                                        validator: (txt) {
                                          if (txt != null &&
                                              txt.isNotEmpty &&
                                              txt.length == 10) {
                                            return null;
                                          } else {
                                            return "Invalid mobile number !!!";
                                          }
                                        },
                                      ),
                                      const Spacer(),
                                      LoadingButtonView(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            context
                                                .read<EnterMobileNumberCubit>()
                                                .requestOTP(_controller.text);
                                          }
                                        },
                                        text: 'Request OTP',
                                        isLoading: state.isLoading,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
