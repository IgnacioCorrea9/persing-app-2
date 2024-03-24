import 'package:flutter/material.dart';
import 'package:persing/core/colors.dart';

class PersingAppbar extends AppBar {
  PersingAppbar()
      : super(
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Image.asset('assets/images/splash/logo-onboarding.png',
              width: 100),
          backgroundColor: primaryColor,
          
        );
}
