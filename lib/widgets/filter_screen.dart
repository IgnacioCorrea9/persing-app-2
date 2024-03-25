// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/providers/auth.dart';
import 'package:persing/providers/sector.dart';
import 'package:persing/widgets/appbar.dart';
import 'package:persing/widgets/filter_card.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late Future<List<Map<String, dynamic>>> sectores;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    sectores = mapSectores(Provider.of<Sector>(context).fetchSectores());
  }

  Future<List<Map<String, dynamic>>> mapSectores(
      Future<List<Map<String, dynamic>>> sec) async {
    List<String> active =
        await Provider.of<Auth>(context).getActiveFilters() ?? [];
    final secs = await sec;
    secs.forEach((element) {
      if (active.contains(element["_id"])) {
        element["selected"] = true;
      } else {
        element["selected"] = false;
      }
    });
    return secs;
  }

  void deselectAll() async {
    final sec = await sectores;
    sec.forEach((element) {
      element["selected"] = false;
    });
    setState(() {
      sectores = Future.value(sec);
    });
  }

  dynamic _getSelectedSectors() async {
    final sectors = await sectores;
    List<String> ids = <String>[];
    sectors.forEach((e) {
      if (e["selected"]) {
        ids.add(e["_id"]);
      }
    });
    return ids;
  }

  Widget getTagObjects(List<Map<String, dynamic>> tags) {
    List<Widget> list = <Widget>[];
    for (var i = 0; i < tags.length; i++) {
      list.add(new Container(
          height: 100,
          margin: EdgeInsets.only(right: 15, top: 8, bottom: 8, left: 0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
<<<<<<< HEAD
              padding: EdgeInsets.all(9),
              primary: tags[i]["selected"] ? Colors.white : Colors.white,
              onPrimary: tags[i]["selected"] ? primaryColor : Colors.black,
=======
              foregroundColor: tags[i]["selected"] ? primaryColor : Colors.black, backgroundColor: tags[i]["selected"] ? Colors.white : Colors.white, padding: EdgeInsets.all(9),
>>>>>>> main
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            key: Key('id' + i.toString()),
            onPressed: () =>
                setState(() => tags[i]["selected"] = !tags[i]["selected"]),
            child: Row(
              children: [
                Icon(FontAwesomeIcons.apple),
                Container(
                  child: Text(
                    tags[i]["nombre"],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )));
    }
    return Wrap(children: list);
  }

  void saveFilters(BuildContext ctx) async {
    try {
      await Provider.of<Sector>(context, listen: false)
          .saveFilters(await _getSelectedSectors());
      Navigator.pop(ctx, "filtered");
    } on FlutterError {}
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: AppBarColor(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back)),
          onPressed: () => deselectAll(),
          textEnd: 'Limpiar filtros',
          title: Text('Filtros',
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
      ),
      body: FutureBuilder(
        future: sectores,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Map<String, dynamic>> tags = snapshot.data;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: const EdgeInsets.only(
                  bottom: 10,
                  top: 10,
                ),
                child: Wrap(
                  children: List.generate(
                    tags.length,
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
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
              backgroundColor: Colors.white,
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        child: Material(
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
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      saveFilters(context);
                    },
                    child: Text(
                      "Filtrar",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
