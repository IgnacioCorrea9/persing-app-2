import 'package:flutter/material.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/screens/splash_screen/onboarding_benefits.dart';
import 'package:persing/widgets/appbar.dart';
import 'package:persing/widgets/bottomNavigationBar.dart';

class OnBoardingStar extends StatelessWidget {
  OnBoardingStar({super.key});

  final Color purpleColor = primaryColor;
  final Color pinkColor = Color(0xFFFF0094);
  final double textSize = 12.5;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: Color(0xFFF7F7FF),
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, 50),
            child: AppBarColor(
              textEnd: 'Saltar',
            ),
          ),
          body: SizedBox(
              child: Image.asset(
                  'assets/images/on-boarding/what_find_here_2.jpg')),
          bottomNavigationBar: WidgetBottomNavigationBar(
            textRight: 'Siguiente',
            textLeft: 'Anterior',
            onPressedLeft: () => Navigator.of(context).pop(),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => OnBoardingBenefits())),
          )),
    );
  }
}
