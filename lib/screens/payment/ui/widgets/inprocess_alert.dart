import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

inProcessPaymentDialog(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  final Color pinkColor = Color(0xFFFF0094);
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          content: Container(
              width: size.width * 0.75,
              height: size.height * 0.24,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.044),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("¡Estamos procesando tu pago!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    LinearProgressIndicator(
                      backgroundColor: pinkColor.withOpacity(0.1),
                      color: pinkColor,
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Text("Por favor espera...",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              )),
        );
      });
}
