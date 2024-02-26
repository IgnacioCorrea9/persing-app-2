import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persing/core/ResponsiveDesign/responsive_design.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/screens/login/login_screen.dart';

class AppBarColor extends StatefulWidget {
  AppBarColor({
    super.key,
    this.textEnd,
    this.leading,
    this.onPressed,
    this.title,
  });

  final String? textEnd;
  final Widget? leading;
  final void Function()? onPressed;
  final Widget? title;

  @override
  _AppBarColorState createState() => _AppBarColorState();
}

class _AppBarColorState extends State<AppBarColor> {
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveDesign(context);
    return AppBar(
      backgroundColor: primaryColor,
      centerTitle: true,
      leading: widget.leading,
      title: widget.title ??
          Image.asset('assets/images/splash/logo-onboarding.png', width: 100),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 18, right: 15),
          child: widget.textEnd == null
              ? SizedBox(
                  height: 2,
                )
              : Container(
                  width: responsive.widthMultiplier(110),
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen())),
                    child: GestureDetector(
                      onTap: widget.onPressed ?? () {},
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          final span = TextSpan(
                            text: widget.textEnd,
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                          final tp = TextPainter(
                            text: span,
                            textDirection: TextDirection.ltr,
                            maxLines: 1,
                          );
                          tp.layout(maxWidth: constraints.maxWidth);

                          if (tp.didExceedMaxLines) {
                            return RichText(
                              maxLines: 1,
                              text: TextSpan(
                                text: widget.textEnd,
                                style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }
                          return RichText(
                            text: span,
                            maxLines: 1,
                          );
                        },
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
