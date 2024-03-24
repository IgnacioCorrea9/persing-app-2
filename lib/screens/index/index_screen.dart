// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/screens/destacados/destacados_screen.dart';
import 'package:persing/screens/discover/discover_screen.dart';
import 'package:persing/screens/home/home_screen.dart';
import 'package:persing/screens/profile/profile_screen.dart';
import 'package:persing/widgets/custom_icons.dart';

class IndexScreen extends StatefulWidget {
  IndexScreen({
    Key? key,
    this.initialIndex = 0,
  }) : super(key: key);

  final int initialIndex;

  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  ValueNotifier<int> _currentIndex = ValueNotifier(0);
  late PageController pageController;

  var ctime;

  @override
  void initState() {
    _currentIndex.value = widget.initialIndex;
    pageController = PageController(initialPage: widget.initialIndex);
    super.initState();
  }

  whenPageChanges(int pageIndex) {
    _currentIndex.value = pageIndex;
  }

  onTapChangePage(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();
        if (ctime == null || now.difference(ctime) > Duration(seconds: 2)) {
          //add duration of press gap
          ctime = now;
          Fluttertoast.showToast(
            msg: "Presione de nuevo para salir",
          );
          return Future.value(false);
        }

        return Future.value(true);
      },
      child: Scaffold(
        body: PageView(
          children: <Widget>[
            HomeScreen(),
            DestacadosScreen(),
            DiscoverScreen(),
            ProfileScreen(),
          ],
          controller: pageController,
          onPageChanged: whenPageChanges,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: _currentIndex,
          builder: (BuildContext context, dynamic value, _) {
            return BottomNavigationBar(
              onTap: onTapChangePage,
              currentIndex: value,
              type: BottomNavigationBarType.fixed,
              backgroundColor: primaryColor,
              unselectedItemColor: Colors.white,
              selectedLabelStyle:
                  TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
              unselectedLabelStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              selectedItemColor: Color(0xFFFF0094),
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 3),
                    child: Icon(
                      CustomIcons.inicio_activo,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  label: 'Inicio',
                  backgroundColor: primaryColor,
                  activeIcon: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 3),
                    child: Icon(
                      CustomIcons.inicio_activo,
                      color: Color(0xFFFF0094),
                      size: 28,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 3),
                    child: Icon(
                      CustomIcons.destacados_inactivo,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  label: 'Destacados',
                  backgroundColor: primaryColor,
                  activeIcon: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 3),
                    child: Icon(
                      CustomIcons.destacados_activo,
                      color: Color(0xFFFF0094),
                      size: 28,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 3),
                    child: Icon(
                      FontAwesomeIcons.globeAmericas,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  label: 'Conoce más',
                  activeIcon: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 3),
                    child: Icon(
                      FontAwesomeIcons.globeAmericas,
                      color: Color(0xFFFF0094),
                      size: 28,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 3),
                    child: Icon(
                      CustomIcons.perfil_activo,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  label: 'Perfil',
                  activeIcon: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 3),
                    child: Icon(
                      CustomIcons.perfil_inactivo,
                      color: Color(0xFFFF0094),
                      size: 28,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
