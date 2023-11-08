import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/ui/users/edit_profile/edit_profile_cubit.dart';
import 'package:ltss/ui/widgets/view_error_page.dart';
import 'package:ltss/ui/widgets/view_loading.dart';
import 'package:ltss/ui/widgets/widgets.dart';

@RoutePage()
class EditProfileScreen extends StatefulWidget implements AutoRouteWrapper {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(
          RepositoryProvider.of<AuthRepository>(context),
          RepositoryProvider.of<SessionManager>(context)),
      child: this,
    );
  }
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _mobileNumber = TextEditingController();
  final _address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: BlocConsumer<EditProfileCubit, EditProfileState>(
          builder: (context, state) {
        if (state.status.isInitializing) return const LoadingView();
        if (state.status.isInitializationFailed) {
          return ErrorPageView(msg: state.msg);
        }

        return Column(
          children: [
            TextInputFieldView(label: "Name", textEditingController: _name),
            TextInputFieldView(
              label: "Mobile Number",
              textEditingController: _mobileNumber,
              isEnabled: false,
            ),
            TextInputFieldView(label: "Email", textEditingController: _email),
            TextInputFieldView(
                label: "Address", textEditingController: _address),
            const Spacer(),
            LoadingButtonView(
                onPressed: () {
                  context
                      .read<EditProfileCubit>()
                      .updateProfile(_name.text, _email.text, _address.text);
                },
                text: "Update Profile",
                isLoading: state.status.isLoading)
          ],
        );
      }, listener: (context, state) {
        if (state.status.isInitializationSuccessful) {
          _name.text = state.name ?? "";
          _mobileNumber.text = state.mobileNumber ?? "";
          _email.text = state.email ?? "";
          _address.text = state.address ?? "";
        }
        if (state.status.isSuccess) {
          showSnackBar(context, state.msg);
          AutoRouter.of(context).pop();
        }
      }),
    ));
  }
}
