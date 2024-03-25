import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/models/home_publicacion_model.dart';
import 'package:persing/providers/auth.dart';
import 'package:persing/providers/publicacion.dart';
import 'package:persing/repository/repository.dart';
import 'package:persing/screens/delegates/home_delegate.dart';
import 'package:persing/screens/index/saved_posts.dart';
import 'package:persing/widgets/filter_screen.dart';
import 'package:persing/widgets/publication_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  void initState() {
    userId = "";
    getPosts = _httpService.getPublicacionesByUser(
        Provider.of<Auth>(context, listen: false).userId);
    super.initState();
  }

  Repository _httpService = Repository();
  late String userId;
  bool isFilter = false;
  List<String> active = [];
  @override
  bool get wantKeepAlive => true;
  // ignore: unused_element
  _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userId")!;
  }

  var getPosts;

  Future<void> _onRefresh() async {
    // ignore: unused_local_variable
    final pubsProvider = Provider.of<Publicacion>(context, listen: false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final postProvider = Provider.of<Publicacion>(context);
    super.build(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 50),
            child: _buildSearchAppbar()),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: Delegate(userId),
            ),
            SliverFillRemaining(
              child: FutureBuilder<List<HomePublicacionesData>>(
                  future: getPosts,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<HomePublicacionesData>> snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      List<HomePublicacionesData> posts = snapshot.data!;
                      if (posts.isNotEmpty) {
                        return Center(
                          child: RefreshIndicator(
                              child: ScrollConfiguration(
                                behavior:
                                    ScrollConfiguration.of(context).copyWith(
                                  scrollbars: false,
                                ),
                                child: ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: posts.length,
                                  itemBuilder: (context, i) {
                                    return PublicationCard(
                                      key: UniqueKey(),
                                      onLiked: () {
                                        posts[i].liked = !posts[i].liked;
                                        if (posts[i].liked) {
                                          posts[i].likes = posts[i].likes + 1;
                                        } else {
                                          posts[i].likes = posts[i].likes - 1;
                                        }
                                      },
                                      onSaved: (String id) {
                                        if (posts[i].guardados.contains(id)) {
                                          posts[i].guardados.remove(id);
                                        } else {
                                          posts[i].guardados.add(id);
                                        }
                                      },
                                      isNew: false,
                                      link: posts[i].link ?? '',
                                      postId: posts[i].id,
                                      guardados: posts[i].guardados,
                                      fecha: posts[i]
                                              .createdAt
                                              .toString()
                                              .substring(0, 11)
                                              .toString() ??
                                          '12/06/2020',
                                      empresaLogo: posts[i].empresa.logo,
                                      videoUrl: posts[i].video,
                                      liked: posts[i].liked,
                                      saved: posts[i].saved,
                                      titulo: posts[i].titulo,
                                      sector: posts[i].sector.id,
                                      likes: posts[i].likes,
                                      descripcion: posts[i].texto,
                                      comentarios: posts[i].comentarios,
                                      nombreEmpresa: posts[i].empresa.nombre,
                                      imageUrl: posts[i].foto,
                                      showMore: true,
                                    );
                                  },
                                ),
                              ),
                              onRefresh: _onRefresh),
                        );
                      } else {
                        return SizedBox(
                          height: size.height * 0.68,
                          child: Center(
                            child: Text(
                              'No tienes publicaciones disponibles',
                              style: GoogleFonts.poppins(
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                          ),
                        );
                      }
                    } else {
                      return SizedBox(
                        height: size.height * 0.76,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(primaryColor),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      );
                    }
                  }),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  // ignore: unused_element
  _navigateFilters(BuildContext context) async {
    final close = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FilterScreen()));
    if (close == "filtered") {
      _onRefresh();
    }
  }

  // ignore: unused_element
  _navigateSavedPosts(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SavedPostsScreen()));
  }

  Widget _buildSearchAppbar() {
    return AppBar(
      leading: null,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title:
          Image.asset('assets/images/splash/logo-onboarding.png', width: 100),
      backgroundColor: primaryColor,
    );
  }
}
