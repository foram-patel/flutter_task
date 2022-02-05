import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:nb_utils/nb_utils.dart';


const fontRegular = 'Regular';
const fontMedium = 'Medium';
const fontSemibold = 'Semibold';
const fontBold = 'Bold';

/* font sizes*/
const textSizeSmall = 12.0;
const textSizeSMedium = 14.0;
const textSizeMedium = 16.0;
const textSizeLargeMedium = 18.0;
const textSizeNormal = 20.0;
const textSizeLarge = 24.0;
const textSizeXLarge = 30.0;

const no_data = 'assets/images/no_data_found.png';

const app_background = Color(0XFFE9E9E9);

// const colorPrimary = Color(0XFF08A7FB);
// const colorAccent = Color(0XFF08A7FB);
const colorPrimary = Color(0xFFCE0219);
const colorAccent = Color(0xFF1B1918);
const textColorPrimary = Color(0XFF333333);
const textColorSecondary = Color(0XFF747474);
const colorPrimary_light = Color(0XFFE6808C);
const colorPrimaryDark = Color(0XFF3D0007);

String baseUrl='https://reqres.in/api/';

Widget text(
    String text, {
      var fontSize = textSizeMedium,
      textColor = textColorPrimary,
      var fontFamily = fontRegular,
      var isCentered = false,
      var maxLine = 1,
      var latterSpacing,
      var textAllCaps = false,
      var isLongText = false,
      var decoration,
      var isAppbar = false,
      var fontStyle,
      var overflow,
      var textAlign,
    }) {
  return Text(
   textAllCaps
        ? text.toUpperCase()
        : text,
    textAlign: isCentered ? TextAlign.center : textAlign ?? TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    style: TextStyle(
      fontFamily: isAppbar ? fontBold : fontFamily,
      fontSize: isAppbar ? textSizeLargeMedium : fontSize,
      color: isAppbar ? white : textColor,
      height: 1.5,
      fontStyle: fontStyle,
      letterSpacing: latterSpacing,
      decoration: decoration,
    ),
  );
}

Widget formField(
    context,
    label,
    hint, {
      isEnabled = true,
      isDummy = false,
      TextEditingController? controller,
      isPasswordVisible = false,
      isPassword = false,
      bool readonly = false,
      enable = true,
      keyboardType = TextInputType.text,
      FormFieldValidator<String>? validator,
      onSaved,
      textInputAction = TextInputAction.next,
      ValueChanged<String?>? onChanged,
      List<TextInputFormatter>? inputFormatters,
      FocusNode? focusNode,
      FocusNode? nextFocus,
      IconData? suffixIcon,
      IconData? prefixIcon,
      maxLine = 1,
      readOnly = false,
      suffixIconSelector,
      Widget? suffixWidget,
      maxLength,
      var textCapitalization,
      Callback? onTap,
      // GestureTapCallback? onTap,
    }) {
  return TextFormField(
    controller: controller,
    obscureText: isPassword ? isPasswordVisible : false,
    cursorColor: colorPrimary,
    enabled: enable,
    maxLines: maxLine,
    keyboardType: keyboardType,
    validator: validator,
    onSaved: onSaved,
    readOnly: readOnly,
    textCapitalization: textCapitalization != null ? textCapitalization : TextCapitalization.none,
    onChanged: onChanged,
    textInputAction: textInputAction,
    inputFormatters: inputFormatters,
    focusNode: focusNode,
    maxLength: maxLength,
    onFieldSubmitted: (arg) {
      if (nextFocus != null) {
        FocusScope.of(context).requestFocus(nextFocus);
      }
    },
    onTap: onTap,
    decoration: InputDecoration(
      counterText: '',
      border: OutlineInputBorder(),
      hintText: hint,
      labelText: label,
      hintStyle: TextStyle(
        fontSize: textSizeSMedium,
        color: textColorSecondary,
      ),
      labelStyle: TextStyle(
        fontSize: textSizeSMedium,
        color: textColorPrimary,
      ),
      prefixIcon: prefixIcon != null
          ? Icon(
        prefixIcon,
        color: textColorSecondary,
        size: 20,
      )
          : null,
      suffixIcon: isPassword
          ? GestureDetector(
        onTap: suffixIconSelector,
        child: new Icon(
          suffixIcon,
          color: Colors.black,
          size: 20,
        ),
      )
          : suffixWidget,
    ),
    style: TextStyle(
      fontSize: textSizeSMedium,
      color: isDummy ? Colors.transparent : textColorPrimary,
      fontFamily: fontRegular,
    ),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: colorPrimary,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xFF900111),
    ),

    // backgroundColor: colorPrimary,
    elevation: 0,
    textTheme: TextTheme(
      headline6: TextStyle(
        color: white,
        fontFamily: fontBold,
        fontSize: 18,
      ),
    ),
    actionsIconTheme: IconThemeData(color: white),
    iconTheme: IconThemeData(color: white),
  );
}

class CustomButton extends StatefulWidget {
  var textContent;
  VoidCallback onPressed;
  var isStroked = false;
  var buttonColor;

  CustomButton({
    @required this.textContent,
    required this.onPressed,
    this.isStroked = false,
    this.buttonColor,
  });

  @override
  CustomButtonState createState() => CustomButtonState();
}

class CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          color: widget.buttonColor != null ? widget.buttonColor : colorPrimary,
        ),
        padding: EdgeInsets.fromLTRB(16, 10, 16, 12),
        alignment: Alignment.center,
        child: text(
          widget.textContent,
          textColor: widget.isStroked ? colorPrimary : white,
          isCentered: true,
          fontFamily: fontMedium,
          textAllCaps: true,
        ),
      ),
    );
  }
}