import 'package:flutter/material.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/screens/profile/alert/review_alert.dart';
import 'package:persing/screens/profile/earnings_screen.dart';
import 'package:persing/screens/profile/profile_data_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              openReviewDialog(context);
            },
            backgroundColor: Color(0xFFFF0094),
            child: Icon(Icons.star_outline),
          ),
          backgroundColor: Colors.white,
          appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: primaryColor,
              elevation: 0,
              bottom: PreferredSize(
                  preferredSize: Size(double.infinity, 50),
                  child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 11,
                        left: 16,
                        right: 16,
                      ),
                      child: Container(
                        height: 33,
                        child: TabBar(
                            unselectedLabelColor: Colors.white,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xFFFF0094)),
                            tabs: [
                              Tab(
                                child: Container(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Ganancias",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Datos de perfil",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                            ]),
                      )))),
          body: TabBarView(children: [
            EarningsScreen(),
            ProfileDataScreen(),
          ]),
        ));
  }
}
