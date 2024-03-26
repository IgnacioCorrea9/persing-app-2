import 'package:flutter/material.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/screens/login/login_screen.dart';
import 'package:persing/widgets/appbar.dart';
import 'package:persing/widgets/bottomNavigationBar.dart';

class OnBoardingBenefits extends StatelessWidget {
  OnBoardingBenefits({super.key});

  final Color purpleColor = primaryColor;
  final Color pinkColor = Color(0xFFFF0094);
  final double textSize = 13.5;

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
              child:
                  Image.asset('assets/images/on-boarding/how_function_3.jpg')),
          bottomNavigationBar: WidgetBottomNavigationBar(
            textRight: 'Siguiente',
            textLeft: 'Anterior',
            onPressedLeft: () => Navigator.of(context).pop(),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen())),
          )),
    );
  }
}
