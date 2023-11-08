import 'package:flutter/material.dart';
import 'package:ltss/app_initialization/app_initialization.dart';
import 'package:ltss/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_initialization/providers.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var preferences = await SharedPreferences.getInstance();
  var providers = await AppProviders.getAppProviders(preferences,AppConstants.emulatorBaseUrl);

  runApp(MyApp(providers: providers,));
}