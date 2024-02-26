import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/screens/splash_screen/onboarding_meet.dart';
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
          body: Container(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/images/splash/onboarding-benefits.png',
                      width: 260),
                  SizedBox(height: 16),
                  Text('¿Qué Beneficios Obtendrás?',
                      style: GoogleFonts.nunito(
                        textStyle: TextStyle(color: purpleColor, fontSize: 16),
                      )),
                  SizedBox(height: 16),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(height: 2),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Con Persing obtendrás ',
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  color: purpleColor, fontSize: textSize),
                            )),
                        TextSpan(
                            text: '2 beneficios ',
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  color: pinkColor, fontSize: textSize),
                            )),
                        TextSpan(
                            text: 'muy importantes: \n',
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  color: purpleColor, fontSize: textSize),
                            )),
                        TextSpan(
                            text: '1. Tendrás ',
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  color: purpleColor, fontSize: textSize),
                            )),
                        TextSpan(
                            text: 'compensación económica ',
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  color: pinkColor, fontSize: textSize),
                            )),
                        TextSpan(
                            text: 'por el uso de tus datos personales.\n ',
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  color: purpleColor, fontSize: textSize),
                            )),
                        TextSpan(
                            text: '2. ',
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  color: purpleColor, fontSize: textSize),
                            )),
                        TextSpan(
                            text:
                                'Tendrás control total sobre información tuya ',
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  color: pinkColor, fontSize: textSize),
                            )),
                        TextSpan(
                            text:
                                'compartida. Sólo estarán disponibles los datos que pongas en tu perfil, podrás editarlos cuando quieras, y sabrás exactamente qué beneficios te han representado los mismos.',
                            style: GoogleFonts.nunito(
                              textStyle:
                                  TextStyle(color: purpleColor, fontSize: 13),
                            )),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: WidgetBottomNavigationBar(
            textRight: 'Siguiente',
            textLeft: 'Anterior',
            onPressedLeft: () => Navigator.of(context).pop(),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => OnBoardingMeetMore())),
          )),
    );
  }
}
