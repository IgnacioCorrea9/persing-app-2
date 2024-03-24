import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persing/core/ResponsiveDesign/responsive_design.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/models/featured_screen/featured_model.dart';
import 'package:persing/repository/repository.dart';
import 'package:persing/screens/destacados/destacados_seccion_screen.dart';
import 'package:persing/screens/index/saved_posts.dart';
import 'package:persing/widgets/custom_icons.dart';
import 'package:persing/widgets/filter_screen.dart';
import 'package:persing/providers/auth.dart';
import 'package:provider/provider.dart';

import 'descadados_nuevos_screen.dart';

class DestacadosScreen extends StatefulWidget {
  DestacadosScreen({Key? key}) : super(key: key);

  @override
  _DestacadosScreenState createState() => _DestacadosScreenState();
}

class _DestacadosScreenState extends State<DestacadosScreen>
    with AutomaticKeepAliveClientMixin<DestacadosScreen> {
  Repository _httpService = Repository();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  onSearch(String value) {
    setState(() {});
  }

  Future<List<Map<String, dynamic>>> filter(
      Future<List<Map<String, dynamic>>> posts) async {
    final active =
        await Provider.of<Auth>(context, listen: false).getActiveFilters();
    final filtered = <Map<String, dynamic>>[];
    (await posts).forEach((element) {
      if (active.contains(element["sector"]["_id"])) {
        filtered.add(element);
      }
    });
    return filtered;
  }

  Future<void> _onRefresh() async {
    // final pubsProvider = Provider.of<Publicacion>(context, listen: false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final responsive = ResponsiveDesign(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 50),
            child: _buildSearchAppbar()),
        body: FutureBuilder(
          future: _httpService.getSeccions(),
          builder: (BuildContext context,
              AsyncSnapshot<List<FeaturedModelData>> snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              List<FeaturedModelData> posts = snapshot.data!;
              FeaturedModelData postx = posts.removeLast();
              posts.insert(0, postx);
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  controller: ScrollController(keepScrollOffset: false),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: posts.map((FeaturedModelData value) {
                    final imageHeight = responsive.heightMultiplier(150);
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DestacadosSeccionScreen(
                              nombreSection: value.nombre,
                              idSection: value.id!,
                            ),
                          ),
                        );
                      },
                      child: Container(
                          padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                          child: value.nombre != 'nuevos'
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: value.icono!,
                                        height: imageHeight > 150
                                            ? 150
                                            : imageHeight,
                                        alignment: Alignment.center,
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            Center(
                                                child:
                                                    CircularProgressIndicator(
                                          valueColor:
                                              new AlwaysStoppedAnimation<Color>(
                                                  primaryColor),
                                          backgroundColor: Colors.white,
                                        )),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          value.nombre,
                                          style: GoogleFonts.nunito(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DestacadosNuevosScreen(),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: FadeInImage(
                                          alignment: Alignment.center,
                                          height: imageHeight > 150
                                              ? 150
                                              : imageHeight,
                                          image: AssetImage(
                                              'assets/images/empresas/icono.png'),
                                          placeholder:
                                              CachedNetworkImageProvider(
                                            'https://www.icegif.com/wp-content/uploads/loading-icegif-1.gif',
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          'Nuevos',
                                          style: GoogleFonts.nunito(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                    );
                  }).toList(),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
                  backgroundColor: Colors.white,
                ),
              );
            }
          },
        ));
  }

  _navigateFilters(BuildContext context) async {
    final close = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilterScreen(),
      ),
    );

    if (close) {
      _onRefresh();
    }
  }

  _navigateSavedPosts(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SavedPostsScreen()));
  }

  Widget _buildSearchAppbar() {
    return AppBar(
      leading: null,
      toolbarHeight: 70,
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: Center(
        child: TextField(
          style: TextStyle(color: Colors.white),
          onChanged: (value) {
            onSearch(value);
          },
          decoration: InputDecoration(
            isDense: true, // Added this
            contentPadding: EdgeInsets.only(top: 5, bottom: 5),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(1, 240, 240, 240)),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(1, 240, 240, 240))),
            hintText: 'Boletos de cine, llantas, libros',
            hintMaxLines: 1,
            hintStyle: TextStyle(color: Colors.grey[300]),
            prefixIcon: Icon(
              CustomIcons.search,
              color: Colors.white,
            ),
            filled: true,
            fillColor: Colors.deepPurple[400],
          ),
        ),
      ),
      backgroundColor: primaryColor,
      actions: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 17.5,
            ),
            child: GestureDetector(
                onTap: () {
                  _navigateFilters(context);
                },
                child: Icon(CustomIcons.filters, color: Colors.white)),
          ),
        ),
        Center(
          child: Padding(
              padding: const EdgeInsets.only(
                right: 17.5,
              ),
              child: GestureDetector(
                onTap: () {
                  _navigateSavedPosts(context);
                },
                child: Icon(
                  Icons.bookmark_outline,
                  color: Colors.white,
                  size: 30,
                ),
              )),
        )
      ],
    );
  }
}
