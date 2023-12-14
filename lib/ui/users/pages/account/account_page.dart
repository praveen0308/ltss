import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/routes/routes.dart';
import 'package:ltss/ui/users/pages/account/account_page_cubit.dart';
import 'package:ltss/ui/widgets/view_error_page.dart';
import 'package:ltss/ui/widgets/view_highlighted_label.dart';
import 'package:ltss/ui/widgets/view_loading.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    context.read<AccountPageCubit>().loadUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AccountPageCubit, AccountPageState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state) {
            case AccountPageInitial():
              return Container();
            case LoadingUI():
              return const LoadingView();
            case UILoaded():
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 50.0,
                            backgroundImage: NetworkImage(
                              state.profileUrl,
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  state.mobileNumber,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              HighlightedLabel(text: state.role),
                            ],
                          )
                        ],
                      ),
                      FilledButton(
                          onPressed: () {
                            AutoRouter.of(context)
                                .push(const EditProfileRoute());
                          },
                          child: const Text("Edit Profile")),
                      const SizedBox(height: 16),
                      menuItem(Icons.info_outline_rounded, "My Information",
                          () {
                        AutoRouter.of(context).push(const MyProfileRoute());
                      }),
                      menuItem(
                          Icons.privacy_tip_rounded, "Privacy Policy", () {}),
                      menuItem(Icons.help_outline_rounded, "FAQs", () {}),
                      const Divider(),
                      menuItem(Icons.star_half_rounded, "Rate Us", () {}),
                      menuItem(Icons.share_rounded, "Share Us", () {}),
                      menuItem(Icons.logout_rounded, "Log Out", () {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Log Out'),
                                  content: const Text(
                                      'Are you sure you want logout?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Yes'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ));
                      }, iconColor: Colors.red),
                    ],
                  ),
                ),
              );
            case LoadUIFailed():
              return const ErrorPageView();
          }
        },
      ),
    );
  }

  Widget menuItem(IconData icon, String title, VoidCallback onClick,
      {Color? iconColor, bool isBorder = false}) {
    return ListTile(
      onTap: () {
        onClick();
      },
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black, fontSize: 17),
      ),
      shape: isBorder
          ? const Border(
              bottom: BorderSide(color: Colors.black12),
            )
          : null,
      trailing: const Icon(Icons.keyboard_arrow_right_rounded),
    );
  }
}
