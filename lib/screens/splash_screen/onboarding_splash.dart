import 'package:flutter/material.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/screens/splash_screen/onboarding_star.dart';
import 'package:persing/widgets/appbar.dart';
import 'package:persing/widgets/bottomNavigationBar.dart';
import 'package:google_fonts/google_fonts.dart';

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
          body: Container(
            padding: EdgeInsets.all(18),
            child: Column(
              children: [
                Image.asset('assets/images/splash/onboarding-splash.png',
                    width: 260),
                SizedBox(height: 16),
                Text('¡Bienvenido!',
                    style: GoogleFonts.nunito(
                      textStyle: TextStyle(color: purpleColor, fontSize: 16),
                    )),
                SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    style: TextStyle(wordSpacing: 2, height: 1.5),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Bienvenid@ a',
                        style: GoogleFonts.nunito(
                          textStyle:
                              TextStyle(color: purpleColor, fontSize: textSize),
                        ),
                      ),
                      TextSpan(
                        text: ' Persing',
                        style: GoogleFonts.nunito(
                          textStyle:
                              TextStyle(color: pinkColor, fontSize: textSize),
                        ),
                      ),
                      TextSpan(
                        text: ', ¡la primera aplicación donde',
                        style: GoogleFonts.nunito(
                          textStyle:
                              TextStyle(color: purpleColor, fontSize: textSize),
                        ),
                      ),
                      TextSpan(
                        text: ' tú',
                        style: GoogleFonts.nunito(
                          textStyle:
                              TextStyle(color: pinkColor, fontSize: textSize),
                        ),
                      ),
                      TextSpan(
                        text: ' eres quien',
                        style: GoogleFonts.nunito(
                          textStyle:
                              TextStyle(color: purpleColor, fontSize: textSize),
                        ),
                      ),
                      TextSpan(
                        text: ' saca provecho',
                        style: GoogleFonts.nunito(
                          textStyle:
                              TextStyle(color: pinkColor, fontSize: textSize),
                        ),
                      ),
                      TextSpan(
                        text: ' de tu',
                        style: GoogleFonts.nunito(
                          textStyle:
                              TextStyle(color: purpleColor, fontSize: textSize),
                        ),
                      ),
                      TextSpan(
                        text: ' información personal',
                        style: GoogleFonts.nunito(
                          textStyle:
                              TextStyle(color: pinkColor, fontSize: textSize),
                        ),
                      ),
                      TextSpan(
                        text: '!',
                        style: GoogleFonts.nunito(
                          textStyle:
                              TextStyle(color: purpleColor, fontSize: textSize),
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
          bottomNavigationBar: WidgetBottomNavigationBar(
            textRight: 'Siguiente',
            textLeft: '',
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => OnBoardingStar())),
          )),
    );
  }
}
