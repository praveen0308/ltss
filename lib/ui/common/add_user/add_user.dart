import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/ui/common/add_user/add_kyc_detail/kyc_detail.dart';
import 'package:ltss/ui/common/add_user/add_user_cubit.dart';
import 'package:ltss/ui/common/add_user/personal_detail/personal_detail.dart';
import 'package:ltss/utils/utils.dart';
import 'package:easy_stepper/easy_stepper.dart';

@RoutePage()
class AddUserScreen extends StatefulWidget implements AutoRouteWrapper {
  final UserRole userTypeAdding;

  const AddUserScreen({super.key, required this.userTypeAdding});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => AddUserCubit(
          RepositoryProvider.of<UserRepository>(context),
          RepositoryProvider.of<KYCRepository>(context)),
      child: this,
    );
  }
}

class _AddUserScreenState extends State<AddUserScreen> with BasePageState {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddUserCubit, AddUserState>(
      listener: (context, state) {
        if (state is StepUpdated) {
          _pageController.jumpToPage(state.step);
        }
        if(state is AddUserSuccessful){
          context.read<AddUserCubit>().addKYCDetail();
        }
      },
      child: SafeArea(
          child: Scaffold(body: BlocBuilder<AddUserCubit, AddUserState>(
        builder: (context, state) {
          if (state is AddingUserData) {
            return const Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text("Adding user data...")
                ],
              ),
            );
          }
          if (state is AddingUserKYC) {
            return const Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text("Adding user KYC details...")
                ],
              ),
            );
          }
          if (state is AddKYCSuccessful) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Icon(Icons.check_circle_rounded,size: 60,),
                  const Text("User added successfully!!!",textAlign: TextAlign.center,),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: FilledButton(onPressed: (){
                      AutoRouter.of(context).pop();
                    }, child:const Text("Continue")),
                  ),
                ],
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              EasyStepper(
                activeStep: context.read<AddUserCubit>().activeStep,
                lineStyle: const LineStyle(
                  lineLength: 100,
                  lineType: LineType.normal,
                  lineThickness: 3,
                  lineSpace: 1,
                  lineWidth: 10,
                ),
                activeStepTextColor: Colors.black87,
                finishedStepTextColor: Colors.black87,
                internalPadding: 0,
                showLoadingAnimation: false,
                stepRadius: 8,
                showStepBorder: false,
                steps: [
                  EasyStep(
                    customStep: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 7,
                        backgroundColor:
                            context.read<AddUserCubit>().activeStep >= 0
                                ? Theme.of(context).colorScheme.primary
                                : Colors.white,
                      ),
                    ),
                    title: 'Personal Detail',
                  ),
                  EasyStep(
                    customStep: CircleAvatar(
                      radius: 8,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: CircleAvatar(
                        radius: 7,
                        backgroundColor:
                            context.read<AddUserCubit>().activeStep >= 1
                                ? Theme.of(context).colorScheme.primary
                                : Colors.white,
                      ),
                    ),
                    title: 'KYC',
                  ),
                ],
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: PageView(
                  controller: _pageController,
                  children: [
                    BlocProvider.value(
                      value: context.read<AddUserCubit>(),
                      child: PersonalDetailPage(selectedType: widget.userTypeAdding,),
                    ),
                    BlocProvider.value(
                      value: context.read<AddUserCubit>(),
                      child: const KYCDetailPage(),
                    ),
                  ],
                ),
              ))
            ],
          );
        },
      ))),
    );
  }
}
