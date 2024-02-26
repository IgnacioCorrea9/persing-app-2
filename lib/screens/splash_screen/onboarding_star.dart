import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          body: Container(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/images/splash/onboarding-star.png',
                      width: 260),
                  SizedBox(height: 8),
                  Text('¿Cómo funciona?',
                      style: GoogleFonts.nunito(
                        textStyle: TextStyle(color: purpleColor, fontSize: 16),
                      )),
                  SizedBox(height: 16),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(height: 2),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Es ',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: purpleColor, fontSize: textSize),
                          ),
                        ),
                        TextSpan(
                          text: 'muy fácil',
                          style: GoogleFonts.nunito(
                            textStyle:
                                TextStyle(color: pinkColor, fontSize: textSize),
                          ),
                        ),
                        TextSpan(
                          text: ', lo único que debes hacer es ',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: purpleColor, fontSize: textSize),
                          ),
                        ),
                        TextSpan(
                          text: 'ingresar tus datos personales',
                          style: GoogleFonts.nunito(
                            textStyle:
                                TextStyle(color: pinkColor, fontSize: textSize),
                          ),
                        ),
                        TextSpan(
                          text: ', seleccionar ',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: purpleColor, fontSize: textSize),
                          ),
                        ),
                        TextSpan(
                          text: 'tus intereses',
                          style: GoogleFonts.nunito(
                            textStyle:
                                TextStyle(color: pinkColor, fontSize: textSize),
                          ),
                        ),
                        TextSpan(
                          text: ', ¡y listo!\n',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: purpleColor, fontSize: textSize),
                          ),
                        ),
                        TextSpan(
                          text:
                              'Te mostraremos publicidad a tu medida: entretenida, sobre tus gustos, y lo más importante, sólo cuando tú decidas verla. ',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: purpleColor, fontSize: textSize),
                          ),
                        ),
                        TextSpan(
                          text: 'Mientras',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: purpleColor, fontSize: textSize),
                          ),
                        ),
                        TextSpan(
                          text: ' más interactúes',
                          style: GoogleFonts.nunito(
                            textStyle:
                                TextStyle(color: pinkColor, fontSize: textSize),
                          ),
                        ),
                        TextSpan(
                          text: ' con ella,',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: purpleColor, fontSize: textSize),
                          ),
                        ),
                        TextSpan(
                          text: ' mejor calificación ',
                          style: GoogleFonts.nunito(
                            textStyle:
                                TextStyle(color: pinkColor, fontSize: textSize),
                          ),
                        ),
                        TextSpan(
                          text: 'obtendrás, \n y mientras',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: purpleColor, fontSize: textSize),
                          ),
                        ),
                        TextSpan(
                          text: ' mejor calificación ',
                          style: GoogleFonts.nunito(
                            textStyle:
                                TextStyle(color: pinkColor, fontSize: textSize),
                          ),
                        ),
                        TextSpan(
                          text: 'tengas, mejores beneficios generarás para ti.',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: purpleColor, fontSize: textSize),
                          ),
                        ),
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
                MaterialPageRoute(builder: (context) => OnBoardingBenefits())),
          )),
    );
  }
}
