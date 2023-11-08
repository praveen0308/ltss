import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/generated/assets.dart';
import 'package:ltss/repository/repository.dart';
import 'package:ltss/res/res.dart';
import 'package:ltss/routes/routes.dart';
import 'package:ltss/ui/common/auth/verify_otp/verify_otp_cubit.dart';
import 'package:ltss/utils/utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

@RoutePage()
class VerifyOtpScreen extends StatefulWidget implements AutoRouteWrapper{
  final String mobileNumber;

  const VerifyOtpScreen({super.key, required this.mobileNumber});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyOtpCubit(
          RepositoryProvider.of<AuthRepository>(context)),
      child: this,
    );
  }
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> with BasePageState {
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  final TextEditingController textEditingController = TextEditingController();
  String currentText = "";

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyOtpCubit, VerifyOtpState>(
      listener: (context, state) {
        showLoading(state is VerifyingOTP ||
            state is ResendingOTP ||
            state is LoadingProfile);
        if (state is OTPVerificationSuccess) {
          showSnackBar(context, "OTP verification successful!!!");
          context.read<VerifyOtpCubit>().fetchProfileData();
        }
        if (state is OTPResentSuccessfully) {
          showSnackBar(context, "OTP resent successful!!!");
        }

        if (state is ProfileLoaded) {
          if (state.roleId == UserRole.admin.roleId) {
            AutoRouter.of(context).navigate(const DashboardRoute());
          } else {
            AutoRouter.of(context).navigate(const UserDashboardRoute());
          }
        }
        if (state is OTPVerificationFailed) {
          showSnackBar(context, state.msg);
          textEditingController.text = "";
        }

        if (state is OTPResendFailed) {
          showSnackBar(context, state.msg);
          textEditingController.text = "";
        }

        if (state is LoadProfileFailed) {
          showSnackBar(context, state.msg);
          textEditingController.text = "";
        }
      },
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Row(
              children: [
                if (constraints.maxWidth > 600)
                  Expanded(
                      child: Container(
                        color: AppColors.primaryDark,
                      )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        SvgPicture.asset(
                          Assets.assetsArtOtpCode,
                          height: 200,
                          width: 200,
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        const Text("Mobile Number Verification",
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                                text: TextSpan(
                                    text: "Enter the OTP sent to ",
                                    style: Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                      TextSpan(
                                          text: widget.mobileNumber,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),

                                    ])),
                            IconButton(onPressed: (){
                              AutoRouter.of(context).navigate(const EnterMobileNumberRoute());
                            }, icon: const Icon(Icons.edit))
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: PinCodeTextField(
                            length: 6,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                                shape: PinCodeFieldShape.underline,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 50,
                                fieldWidth: 40,
                                inactiveColor: AppColors.primaryLight,
                                selectedColor: AppColors.primaryColor,
                                activeColor: AppColors.primaryColor),
                            animationDuration: const Duration(milliseconds: 300),
                            errorAnimationController: errorController,
                            controller: textEditingController,
                            onCompleted: (v) {
                              print("Completed");
                            },
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                currentText = value;
                              });
                            },
                            beforeTextPaste: (text) {
                              print("Allowing to paste $text");
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                            appContext: context,
                          ),
                        ),
                        /*Countdown(
                  seconds: 120,
                  build: (BuildContext context, double time) =>
                      Text(formattedTime(timeInSecond: time.toInt())),
                  interval: const Duration(seconds: 1),
                  onFinished: () {
                    print('Timer is done!');
                  },
              ),*/

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Didn't received OTP?"),
                            TextButton(
                                onPressed: () {
                                  context.read<VerifyOtpCubit>().requestOTP(widget.mobileNumber);
                                },
                                child: const Text(
                                  "Resend",
                                ))
                          ],
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                                onPressed: currentText.length == 6
                                    ? () {
                                  context
                                      .read<VerifyOtpCubit>()
                                      .verifyOtp(widget.mobileNumber, currentText);
                                }
                                    : null,
                                child: const Text("Verify OTP")))
                      ],
                    ),
                  ),
                ),
              ],
            );
          },

        ),

      ),
    );
  }

  formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }
}
