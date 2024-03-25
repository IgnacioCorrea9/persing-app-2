import 'package:flutter/material.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/screens/splash_screen/onboarding_star.dart';
import 'package:persing/widgets/appbar.dart';
import 'package:persing/widgets/bottomNavigationBar.dart';

class OnBoardingSplash extends StatelessWidget {
  OnBoardingSplash({super.key});

  final Color purpleColor = primaryColor;
  final Color pinkColor = Color(0xFFFF0094);
  final double textSize = 14;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: Color(0xffF7F7FF),
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, 50),
            child: AppBarColor(
              textEnd: 'Saltar',
            ),
          ),
          body: SizedBox(
              child: Image.asset(
                  'assets/images/on-boarding/what_is_persing_1.jpg')),
          bottomNavigationBar: WidgetBottomNavigationBar(
            textRight: 'Siguiente',
            textLeft: '',
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => OnBoardingStar())),
          )),
    );
  }
}
