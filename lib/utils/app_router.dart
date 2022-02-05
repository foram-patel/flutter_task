import 'package:get/get.dart';
import 'package:my_flutter_task/screens/dashboard.dart';
import 'package:my_flutter_task/screens/edit_user.dart';
import 'package:my_flutter_task/screens/login.dart';
import 'package:my_flutter_task/screens/signup.dart';
import 'package:my_flutter_task/screens/splash.dart';

class AppRouter {
  static List<GetPage> pages = [
    //Common
    GetPage(name: '/', page: () => Splash()),
    GetPage(name: 'signup', page: () => Signup()),
    GetPage(name: 'dashboard', page: () => Dashboard()),
    GetPage(name: 'edit-user', page: () => EditUser()),
    GetPage(name: 'login', page: () => Login()),
  ];
}
