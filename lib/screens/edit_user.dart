import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:my_flutter_task/utils/app_utils.dart';
import 'package:nb_utils/nb_utils.dart' hide Loader;

class EditUser extends StatefulWidget {
  const EditUser({Key? key}) : super(key: key);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  final _editFormKey = GlobalKey<FormState>();
  bool passwordVisible = true;

  var data;

  @override
  void initState() {
    data=Get.arguments;
    if(data!=null){
      _firstNameController.text=data['first_name'];
      _lastNameController.text=data['last_name'];
      _emailController.text=data['email'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            10.height,
            formField(
              context,
              'First Name',
              'First Name',
              controller: _firstNameController,
              inputFormatters: [
                FilteringTextInputFormatter.deny(
                  RegExp(r'^[ ]|[-.,]'),
                ),
              ],
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter a valid First Name';
                }
                return null;
              },
            ),
            10.height,
            formField(
              context,
              'Last Name',
              'Last Name',
              controller: _lastNameController,
              inputFormatters: [
                FilteringTextInputFormatter.deny(
                  RegExp(r'^[ ]|[-.,]'),
                ),
              ],
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter a valid Last Name';
                }
                return null;
              },
            ),
            10.height,
            formField(
              context,
              'Email',
              'Email',
              controller: _emailController,
              inputFormatters: [
                FilteringTextInputFormatter.deny(
                  RegExp(r'^[ ]|[-.,]'),
                ),
              ],
              validator: (value) {
                if (!value!.validateEmail()) {
                  return 'Enter a valid Email';
                }
                return null;
              },
            ),
            20.height,
            CustomButton(
              textContent: 'Submit',
              onPressed: () {
                editRequest();
              },
            ),
          ],
        ),
      ),
    );
  }

  void editRequest() {
    Loader.show(context,progressIndicator:const CircularProgressIndicator());
    Dio dio=Dio();
    dio.put('${baseUrl}${data['id']}').then((response) {
      Loader.hide();
      if(response.statusCode==200){
        toast('User Updated');
        Get.back();
      }
    });
  }
}
