import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ltss/generated/assets.dart';
import 'package:ltss/local/session_manager.dart';
import 'package:ltss/res/res.dart';
import 'package:ltss/utils/utils.dart';

mixin BasePageState<T extends StatefulWidget> on State<T> {
  late SessionManager cache;

  @override
  void initState() {
    cache = RepositoryProvider.of<SessionManager>(context);
    super.initState();
  }

  Future navigateTo(String destination, {Object? args}) {
    return Navigator.pushNamed(context, destination, arguments: args);
  }

/*  Future replaceWith(String destination, {dynamic args}) {
    return Navigator.pushReplacementNamed(context, destination,
        arguments: args);
  }*/
  Future pushTo(PageRouteInfo destination) {
    return AutoRouter.of(context).push(destination);
  }

  Future replaceWith(PageRouteInfo destination) {
    return AutoRouter.of(context).replace(destination);
  }
  void showToast(String msg, ToastType type) {
    UtilMethods.showToast(msg, type);
  }

  Future<bool> checkInternetConnection() async {
    bool isConnected =
        await InternetConnectivityHelper.checkInternetConnectivity();
    if (isConnected) {
      return true;
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Not Connected'),
            content: const Text('Please check your internet connection.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return false;
    }
  }

  void showLoading(bool flag) {
    flag
        ? SmartDialog.showLoading(
            msg: "Loading...",
          )
        : SmartDialog.dismiss();
  }

  void showNotInternetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Not Connected'),
          content: const Text('Please check your internet connection.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget label(String text,{EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 8.0)}) => Padding(
    padding: padding,
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 15,
      ),
    ),
  );
  Widget divider({double thickness = 1,Color color = Colors.black}) => Divider(thickness: thickness,color: color,);
  Widget vGap({double height = AppDimens.appVerticalSpacing}) => SizedBox(
    height: height,
  );


  Widget hGap({double width = AppDimens.appHorizontalSpacing}) => SizedBox(
        width: width,
      );

  Future<bool> onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void showSuccessDialog(
          {String title = "Success!",
          String btnText = "Continue",
          required msg,
          required Function() onActionBtnClick}) =>
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                actionsPadding:
                    const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                elevation: 5,
                content: SizedBox(
                  height: 250,
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        Assets.assetsArtSuccess,
                      ),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        msg,
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  ),
                ),
                actions: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: onActionBtnClick,
                        child: Text(
                          btnText,
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                  )
                ],
              ));

  void showDeleteConfirmationDialog(
          {String title = "User",
          String btnText = "Yes",
          required msg,
          required Function() onActionBtnClick}) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: SizedBox(
            height: 270,
            child: Column(
              children: [
                SvgPicture.asset(
                  Assets.assetsArtDelete,
                  //package: 'common',
                ),
                FittedBox(
                  child: Text(
                    "Delete $title!",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                vGap(),
                Text(
                  'Sure to delete this $msg ?',
                )
              ],
            ),
          ),
          actions: [
            SizedBox(
              width: 140,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Theme.of(context).primaryColor, width: 2),
                ),
                onPressed: () => Navigator.pop(
                  context,
                  'No',
                ),
                child: Text('No',
                    style:
                    Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).primaryColor)),
              ),
            ),
            SizedBox(
              width: 140,
              child: ElevatedButton(
                onPressed: onActionBtnClick,
                child: Text(
                  btnText,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      );

  void showValidPopup(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Validation Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
