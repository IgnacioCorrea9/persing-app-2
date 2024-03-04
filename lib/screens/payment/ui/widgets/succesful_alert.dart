import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persing/screens/index/index_screen.dart';

successfulAlert(
  BuildContext context, {
  required void Function() onPressed,
}) {
  Size size = MediaQuery.of(context).size;
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          content: Container(
              width: size.width * 0.75,
              height: size.height * 0.5,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.044,
                    vertical: size.height * 0.012),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "¡Tu pago ha sido confirmado!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Icon(
                      Icons.check_circle_outline_rounded,
                      color: Colors.green,
                      size: 50,
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Text(
                      "¡Gracias por tu compra! \n\nAhora nos pondremos en contacto contigo para continuar con la entrega de tu pedido",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    ElevatedButton(
                      onPressed: onPressed ??
                          () async {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => IndexScreen(),
                              ),
                              (route) => false,
                            );
                          },
                      style: ElevatedButton.styleFrom(
                        // ignore: deprecated_member_use
                        backgroundColor: Color(0xffFF0094),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        padding: EdgeInsets.only(
                            top: 10, bottom: 9, left: 18, right: 19),
                      ),
                      child: Text(
                        "Continuar",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              )),
        );
      });
}
