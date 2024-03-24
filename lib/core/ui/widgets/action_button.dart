import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persing/core/colors.dart';

class ButtonsRow extends StatelessWidget {
  const ButtonsRow({
    super.key,
    this.pinkColor = secondaryColor,
    this.purpleColor = primaryColor,
  });

  final Color pinkColor;
  final Color purpleColor;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ActionButton(
            size: size,
            pinkColor: pinkColor,
            purpleColor: Colors.white,
            title: 'Cancelar',
            onPressed: () {},
          ),
          Expanded(
            child: ActionButton(
              size: size,
              pinkColor: pinkColor,
              purpleColor: Colors.white,
              title: 'Agregar al carrito',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.size,
    required this.title,
    required this.onPressed,
    this.pinkColor = secondaryColor,
    this.purpleColor = primaryColor,
  });

  final Size size;
  final Color pinkColor;
  final Color purpleColor;
  final Function() onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        height: size.height * 0.047,
        decoration: BoxDecoration(
          color: pinkColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: FittedBox(
            child: Text(
              title,
              style: GoogleFonts.nunito(
                color: purpleColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }
}
