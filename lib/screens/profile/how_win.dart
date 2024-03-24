import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HowWinWithPersing extends StatefulWidget {
  const HowWinWithPersing({Key? key}) : super(key: key);

  @override
  State<HowWinWithPersing> createState() => _HowWinWithPersingState();
}

class _HowWinWithPersingState extends State<HowWinWithPersing> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final spacer = SizedBox(
      height: 8,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(FontAwesomeIcons.chevronLeft,
                color: Colors.white, size: 16)),
        centerTitle: true,
        title: Text('¿Cómo ganas con Persing?',
            style: TextStyle(color: Colors.white, fontSize: 14)),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'En Persing ganas administrando tu información personal, habilitándola (SIN REGALARLA) para que diferentes compañías te muestren contenido basado en tu perfil social y demográfico. Participar es muy fácil:',
                softWrap: true,
                style: TextStyle(fontSize: 16),
              ),
              spacer,
              Text(
                '1. Ingresa tu información personal',
                softWrap: true,
                style: TextStyle(
                  fontSize: 16,
                  color: primaryColor,
                ),
              ),
              spacer,
              Text(
                'Crea tu perfil, ingresa sólo los datos que quieres compartir y selecciona tus intereses. Mientras más información compartas, más valioso será tu perfil. Puedes agregar, modificar o quitar los datos que quieras en cualquier momento.',
                softWrap: true,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              spacer,
              Text(
                '2. Selecciona tus intereses',
                softWrap: true,
                style: TextStyle(
                  fontSize: 16,
                  color: primaryColor,
                ),
              ),
              spacer,
              Text(
                'Elije las categorías de tu interés en la sección “Editar” de tu perfil y Persing te mostrará contenido de éstas. Así conocerás nuevos lanzamientos, productos diferenciados y comerciales memorables, ¡como los que hacían antes! Recuerda que mientras más honesto seas con tus intereses, mejor será el contenido que verás.',
                softWrap: true,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              spacer,
              Text(
                '3. Aprovecha las ganancias que recibes',
                softWrap: true,
                style: TextStyle(
                  fontSize: 16,
                  color: primaryColor,
                ),
              ),
              spacer,
              Text(
                'Ingresa a tu perfil para ver tus ganancias totales y por categoría, selecciona la categoría que quieras explorar y mira los productos / servicios disponibles para redimir en la misma. Si tus ganancias son superiores al costo del producto, ¡adquiérelo! Si no, puedes completar la diferencia y así aprovechar lo que has generado hasta el momento.',
                softWrap: true,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              spacer,
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Tu Calificación Persing es una aproximación al valor general de tu usuario, y variará de acuerdo a tu calificación en cada categoría y a la cantidad de información en tu perfil. Para información más detallada sobre tu calificación y las empresas participantes, ingresa a ',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                        text: 'www.persinglatam.com',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: primaryColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            try {
                              await launchUrl(
                                Uri.parse(
                                  'https://www.persinglatam.com/',
                                ),
                              );
                            } catch (e) {
                              log(e.toString());
                            }
                          })
                  ],
                ),
              ),
              spacer,
            ],
          ),
        ),
      ),
    );
  }
}
