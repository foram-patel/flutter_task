import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter_task/utils/app_router.dart';
import 'package:my_flutter_task/utils/app_utils.dart';

Future<void> main() async {
  String initialRouterName = "/";
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      defaultTransition: Transition.cupertino,
      initialRoute: initialRouterName,
      title: 'Flutter Task',
      theme: ThemeData(
        scaffoldBackgroundColor: app_background,
        primaryColor: colorPrimary,
        accentColor: colorAccent,
        textTheme: const TextTheme(
          bodyText2: TextStyle(fontFamily: fontRegular),
          bodyText1: TextStyle(fontFamily: fontRegular),
        ),
        appBarTheme: appBarTheme(),
      ),
      debugShowCheckedModeBanner: false,
      getPages: AppRouter.pages,
      routingCallback: (routing) async {},
    ),
  );
}


