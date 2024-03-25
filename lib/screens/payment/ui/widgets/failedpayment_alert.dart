import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

failedPaymentAlert(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        insetPadding: EdgeInsets.all(10),
        content: Container(
          width: size.width * 0.75,
          height: size.height * 0.4,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.044),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "¡Ha ocurrido un error!",
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
                  Icons.cancel_outlined,
                  color: Colors.red,
                  size: 50,
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Text(
                  "Por favor verifica tus datos de pago e inténtalo de nuevo",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    // ignore: deprecated_member_use
<<<<<<< HEAD
                    primary: Color(0xffFF0094),
=======
                    backgroundColor: Color(0xffFF0094),
>>>>>>> main
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 9,
                      left: 18,
                      right: 19,
                    ),
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
          ),
        ),
      );
    },
  );
}
