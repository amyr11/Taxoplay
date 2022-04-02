import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

void customDialog(
  BuildContext context,
  CoolAlertType type, {
  String? title,
  String? text,
  void Function()? onConfirmBtnTap,
  void Function()? onCancelBtnTap,
  String confirmBtnText = 'Ok',
  String cancelBtnText = 'Cancel',
  bool showCancelBtn = false,
}) {
  CoolAlert.show(
    context: context,
    type: type,
    confirmBtnText: confirmBtnText,
    cancelBtnText: cancelBtnText,
    backgroundColor: kBackgroundColor,
    confirmBtnColor: kPrimaryColor,
    showCancelBtn: showCancelBtn,
    title: title,
    text: text,
    onConfirmBtnTap: onConfirmBtnTap,
    onCancelBtnTap: onCancelBtnTap,
  );
}
