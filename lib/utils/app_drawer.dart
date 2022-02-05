import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter_task/utils/app_utils.dart';
import 'package:my_flutter_task/utils/storage.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String userName='';
  @override
  void initState() {
    Storage.get('login_user').then((user) {
      setState(() {
        userName=user['user_name'];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
          createDrawerBodyItem(
              icon: Icons.logout,text: 'Logout', onTap: () async {
                await Storage.delete('login_user');
                Get.offAllNamed('login');
          }),
        ],
      ),
    );
  }
  Widget createDrawerHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: const BoxDecoration(
          color: colorPrimary,
        ),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Hi $userName",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }
  Widget createDrawerBodyItem(
      {required IconData icon, required String text, required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
