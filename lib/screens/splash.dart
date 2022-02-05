import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter_task/utils/app_utils.dart';
import 'package:my_flutter_task/utils/storage.dart';
import 'package:nb_utils/nb_utils.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
 initState() {
    super.initState();
    Storage.get('users').then((value) {
      Storage.set('users', []);
    });

    Future.delayed(Duration(seconds: 4),() async {
      if(await Storage.get('login_user')==null){
        Get.toNamed('login');
      }else{
        Get.toNamed('dashboard');
      }
    });

  }

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                text(
                  'Flutter Task',
                  textColor: colorPrimary,
                  fontSize: textSizeXLarge,
                  fontFamily: fontBold,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
