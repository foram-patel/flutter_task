import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_flutter_task/utils/app_utils.dart';
import 'package:my_flutter_task/utils/storage.dart';
import 'package:nb_utils/nb_utils.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final _registerFormKey = GlobalKey<FormState>();
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Form(
            key: _registerFormKey,
            child: Column(
              children: [
                80.height,
                text(
                  'Signup',
                  fontFamily: fontBold,
                  textColor: colorPrimary,
                  fontSize: textSizeLarge,
                ),
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
                  'User Name',
                  'User Name',
                  controller: _userNameController,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(
                      RegExp(r'^[-., ]'),
                    ),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid User Name';
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
                      RegExp(r'^[-., ]'),
                    ),
                  ],
                  validator: (value) {
                    if (!value!.validateEmail()) {
                      return 'Enter a valid Email';
                    }
                    return null;
                  },
                ),
                10.height,
                formField(
                  context,
                  'Password',
                  'Password',
                  keyboardType: TextInputType.text,
                  isPassword: true,
                  isPasswordVisible: passwordVisible,
                  textInputAction: TextInputAction.done,
                  controller: _passwordController,
                  inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'^[ -.,]'))],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Password';
                    }
                    return null;
                  },
                  suffixIconSelector: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                  suffixIcon: passwordVisible ? Icons.visibility_off : Icons.visibility,
                ),
                20.height,
                CustomButton(
                  textContent: 'Submit',
                  onPressed: () async {
                   if(_registerFormKey.currentState!.validate()){
                     Map user={
                       'first_name':_firstNameController.text,
                       'last_name':_lastNameController.text,
                       'user_name':_userNameController.text,
                       'email':_emailController.text,
                       'password':_passwordController.text,
                     };
                     List appUsers=await Storage.get('users');
                     appUsers.add(user);
                     await Storage.set('users', appUsers);
                     toast('Successfully Registered');
                     print('** ${await Storage.get('users')}');
                     Get.toNamed('login');
                   }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
