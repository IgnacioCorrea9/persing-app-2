import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persing/core/colors.dart';

class WidgetBottomNavigationBar extends StatelessWidget {
  WidgetBottomNavigationBar(
      {super.key,
      required this.textRight,
      this.onPressed,
      required this.textLeft,
      this.onPressedLeft});

  final Color purpleColor = primaryColor;
  final String textRight;
  final String textLeft;
  final void Function()? onPressed;
  final void Function()? onPressedLeft;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.grey[50],
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            textLeft != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Container(
                      width: 150,
                      child: TextButton(
                        onPressed: onPressedLeft,
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(purpleColor),
                        ),
                        child: Text(
                          textLeft,
                          style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            Container(
              width: 150,
              child: TextButton(
                onPressed: onPressed,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xffff0094)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: Text(textRight,
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
