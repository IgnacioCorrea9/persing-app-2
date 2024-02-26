import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/core/ui/widgets/persing_appbar.dart';

class PersingScaffold extends StatelessWidget {
  const PersingScaffold({
    this.body,
    this.title,
    this.bottom,
  });

  final Widget? body;
  final Widget? bottom;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PersingAppbar(),
      body: Column(
        children: [
          SubAppbar(
            title: title ?? 'Titulo',
          ),
          Expanded(
            child: body ?? Container(),
          ),
          bottom??Container(),
        ],
      ),
    );
  }
}

class SubAppbar extends StatelessWidget {
  const SubAppbar({
    super.key,
    this.title = 'Subtitulo',
    this.show = true,
  });

  final String title;
  final bool show;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Visibility(
      visible: show,
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(0, 1),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.1,
          vertical: size.height * 0.0168,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
