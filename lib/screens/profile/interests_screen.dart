// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persing/core/colors.dart';
<<<<<<< HEAD
=======
import 'package:persing/providers/auth.dart';
import 'package:persing/providers/sector.dart';
import 'package:persing/providers/user.dart';
>>>>>>> main
import 'package:persing/screens/index/index_screen.dart';
import 'package:persing/widgets/appbar.dart';
import 'package:persing/widgets/filter_card.dart';
import 'package:provider/provider.dart';
<<<<<<< HEAD
import 'package:persing/providers/sector.dart';
import 'package:persing/providers/auth.dart';
import 'package:persing/providers/user.dart';
=======

>>>>>>> main
import '../../constants.dart';

class InterestsScreen extends StatefulWidget {
  InterestsScreen({Key? key}) : super(key: key);

  @override
  _InterestsScreenState createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  // sectores
  late Future<List<Map<String, dynamic>>> sectores;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    sectores = mapSectores(Provider.of<Sector>(context).fetchSectores());
  }

  Future<List<Map<String, dynamic>>> mapSectores(
      Future<List<Map<String, dynamic>>> sec) async {
    List<String> active =
        await Provider.of<Auth>(context).getActiveInterests() ?? [];
    final secs = await sec;
    secs.forEach((element) {
      if (active.contains(element['_id'])) {
        element['selected'] = true;
      } else {
        element['selected'] = false;
      }
    });
    return secs;
  }

  void _previousScreen() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => IndexScreen(
          initialIndex: 0,
        ),
      ),
      (Route<dynamic> route) => false,
    );
  }

  void deselectAll() async {
    final sec = await sectores;
    sec.forEach((element) {
      element['selected'] = false;
    });
    setState(() {
      sectores = Future.value(sec);
    });
  }

  dynamic _getSelectedSectors() async {
    final sectors = await sectores;
    List<String> ids = <String>[];
    sectors.forEach((e) {
      if (e['selected']) {
        ids.add(e['_id']);
      }
    });
    return ids;
  }

  Widget getTagObjects(List<Map<String, dynamic>> tags) {
    List<Widget> list = <Widget>[];
    for (var i = 0; i < tags.length; i++) {
      list.add(new Container(
          margin: EdgeInsets.only(right: 15, top: 8, bottom: 8, left: 0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
<<<<<<< HEAD
              padding: EdgeInsets.all(9),
              primary: tags[i]['selected'] ? primaryColor : Colors.white,
              onPrimary: tags[i]['selected'] ? Colors.white : Colors.black,
=======
              foregroundColor: tags[i]['selected'] ? Colors.white : Colors.black, padding: EdgeInsets.all(9), backgroundColor: tags[i]['selected'] ? primaryColor : Colors.white,
>>>>>>> main
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            key: Key('id' + i.toString()),
            onPressed: () =>
                setState(() => tags[i]['selected'] = !tags[i]['selected']),
            child: Text(
              tags[i]['nombre'],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          )));
    }
    return Wrap(children: list);
  }

  saveInterests() async {
    Map<String, dynamic> obj = {'intereses': await _getSelectedSectors()};
    try {
      await Provider.of<User>(context, listen: false).editUser(obj);
      _previousScreen();
    } on FlutterError catch (error) {
      showAlertDialog('Error', error.message, context, 'Cerrar');
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: AppBarColor(
          textEnd: 'Limpiar filtros',
          onPressed: () => deselectAll(),
          title: Text(
            'Mis intereses',
            style: GoogleFonts.nunito(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: sectores,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                  bottom: 10,
                  top: 10,
                ),
                child: Wrap(
                  children: List.generate(
                    snapshot.data.length,
                    (i) => FilterCard(
                      elementIndex: i,
                      image: snapshot.data[i]['icono'],
                      text: snapshot.data[i]['nombre'],
                      selected: snapshot.data[i]["selected"],
                      onTap: () => setState(() => snapshot.data[i]["selected"] =
                          !snapshot.data[i]["selected"]),
                    ),
                  ),
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: Material(
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(1, 240, 240, 240),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ButtonTheme(
                minWidth: size.width,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
<<<<<<< HEAD
                    primary: Color(0xFFFF0094),
                    onPrimary: Colors.white,
=======
                    foregroundColor: Colors.white, backgroundColor: Color(0xFFFF0094),
>>>>>>> main
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: () {
                    saveInterests();
                  },
                  child: Text(
                    'Filtrar',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
