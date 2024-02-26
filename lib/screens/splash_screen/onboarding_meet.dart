import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/screens/login/login_screen.dart';
import 'package:persing/widgets/appbar.dart';

class OnBoardingMeetMore extends StatelessWidget {
  OnBoardingMeetMore({super.key});

  final Color purpleColor = primaryColor;
  final Color pinkColor = Color(0xFFFF0094);
  final double textSize = 13.5;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                Image.asset('assets/images/splash/onboarding-more.png',
                    width: 260),
                SizedBox(height: 16),
                Text('¡Conoce Más!',
                    style: GoogleFonts.nunito(
                      textStyle: TextStyle(color: purpleColor, fontSize: 16),
                    )),
                SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    style: TextStyle(height: 2),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Conoce más sobre cómo obtener más ',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: purpleColor, fontSize: textSize),
                          )),
                      TextSpan(
                          text: 'beneficios ',
                          style: GoogleFonts.nunito(
                            textStyle:
                                TextStyle(color: pinkColor, fontSize: textSize),
                          )),
                      TextSpan(
                          text: 'con Persing y la forma como ',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: purpleColor, fontSize: textSize),
                          )),
                      TextSpan(
                          text: 'funciona la publicidad  ',
                          style: GoogleFonts.nunito(
                            textStyle:
                                TextStyle(color: pinkColor, fontSize: textSize),
                          )),
                      TextSpan(
                          text: 'actualmente en la sección de ',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: purpleColor, fontSize: textSize),
                          )),
                      TextSpan(
                          text: '“Conoce Más” ',
                          style: GoogleFonts.nunito(
                            textStyle:
                                TextStyle(color: pinkColor, fontSize: textSize),
                          )),
                      TextSpan(
                          text: 'del menú de configuraciones.',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: purpleColor, fontSize: textSize),
                          )),
                    ],
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 150,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(purpleColor),
                  ),
                  child: Text(
                    'Anterior',
                  ),
                ),
              ),
              Container(
                width: 150,
                child: TextButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen())),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.pinkAccent),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text(
                    'Siguiente',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
