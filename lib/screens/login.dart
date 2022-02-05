
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_flutter_task/utils/app_utils.dart';
import 'package:my_flutter_task/utils/storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/src/extensions/int_extensions.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginFormKey = GlobalKey<FormState>();
  bool passwordVisible = true;
  TextEditingController _emailOruserNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _loginFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SafeArea(
            child: buildFormContainer(height, width, context),
          ),
        ),
      ),
    );
  }

  Widget buildFormContainer(double height, double width, BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          50.height,
          text(
            'Login',
            fontFamily: fontBold,
            textColor: colorPrimary,
            fontSize: textSizeLarge,
          ),
          30.height,
          emailOrUserName(context),
          20.height,
          inputPassword(context),
          30.height,
          CustomButton(
            textContent: 'Sign In',
            onPressed: () {
              loginRequest(context);
            },
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              text("Don't have an account ?"),
              SizedBox(width: 4),
              GestureDetector(
                child: text(
                  'Register',
                  textColor: colorPrimary,
                  fontFamily: fontBold,
                ),
                onTap: () {
                  Get.toNamed('signup');
                },
              )
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  loginRequest(BuildContext context) async {
    if (_loginFormKey.currentState!.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());

      List appUsers=await Storage.get('users');
      Map? userMatch;
      for(Map user in appUsers){
        if(_emailOruserNameController.text==user['email'] || _emailOruserNameController.text==user['user_name']){
          userMatch=user;
          break;
        }
      }

      if(userMatch==null){
        toast('User Not Found');
      }else if(userMatch!=null && userMatch['password']!=_passwordController.text){
        toast('Incorrect Password');
      }else if(userMatch!=null && userMatch['password']==_passwordController.text){
        await Storage.set('login_user', userMatch);
        Get.toNamed('dashboard');
      }

    }
  }

  Widget inputPassword(BuildContext context) {
    return formField(
      context,
      'Password',
      'Password',
      keyboardType: TextInputType.text,
      isPassword: true,
      isPasswordVisible: passwordVisible,
      textInputAction: TextInputAction.done,
      controller: _passwordController,
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'^[ -.,]'))],
      suffixIcon: passwordVisible ? Icons.visibility_off : Icons.visibility,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter a valid password';
        }
        return null;
      },
    );
  }

  Widget emailOrUserName(BuildContext context) {
    return formField(
      context,
      'Email / User Name',
      'Email / User Name',
      controller: _emailOruserNameController,
      keyboardType: TextInputType.text,
      inputFormatters: [
        FilteringTextInputFormatter.deny(
          RegExp(r'^[-., ]'),
        ),
      ],
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter a valid email or User name';
        }
        return null;
      },
  
    );
  }

}
