// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:core';
import 'package:email_validator/email_validator.dart';

const orange = Color(0xFFFF6900);
const black = Color(0x1C1C1C);
const background = Color(0xF0F0F0);
final formatter = NumberFormat('\$#,###.##', "en_US");

void showAlertDialog(
    String title, String message, BuildContext context, String messageButton) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        ElevatedButton(
          onPressed: Navigator.of(ctx).pop,
          child: Text(messageButton),
          style: ElevatedButton.styleFrom(

            primary: Color(0xFFFF0094),
            textStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

void showAlertDialogSign(Function() onPressed, String title, String message,
    BuildContext context, String messageButton) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              ElevatedButton(
                onPressed: onPressed,
                child: Text(messageButton),
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFFFF0094),
                    textStyle: TextStyle(color: Colors.white)),
              ),
            ],
          ));
}

bool validateEmail(String email) {
  return EmailValidator.validate(email);
}


/* bool validateEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
          
          )
      .hasMatch(email);
} */