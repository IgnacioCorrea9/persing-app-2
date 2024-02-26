import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showSnack(
  Color color,
  String error,
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
  BuildContext ctx,
) {
  final snackbar = SnackBar(
    backgroundColor: color,
    duration: const Duration(milliseconds: 3000),
    content: Text(
      error,
      style: GoogleFonts.nunito(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  ScaffoldMessenger.of(ctx).showSnackBar(
    snackbar,
  );
}
