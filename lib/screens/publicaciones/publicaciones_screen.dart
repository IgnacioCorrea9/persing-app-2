import 'package:flutter/material.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/models/publicaciones_model.dart';
import 'package:persing/models/sector_model.dart';
import 'package:persing/repository/repository.dart';
import 'package:persing/screens/publicaciones/publicaciones_by_sector.dart';
import 'package:persing/widgets/appbar.dart';
import 'package:persing/widgets/publication_card.dart';

class PublicacionesScreen extends StatefulWidget {
  PublicacionesScreen({Key? key}) : super(key: key);

  @override
  _PublicacionesScreenState createState() => _PublicacionesScreenState();
}

class _PublicacionesScreenState extends State<PublicacionesScreen> {
  Repository _httpService = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 90,
              child: FutureBuilder(
                future: _httpService.getSector(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<SectorData>> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    List<SectorData> posts = snapshot.data!;
                    return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: posts.length,
                        itemBuilder: (context, i) => Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PublicacionesBySector(
                                          sectorId: posts[i].id,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    height: 70,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[50],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          height: 85,
                                          width: 50.0,
                                          child: CircleAvatar(
                                            backgroundColor: Color(0xFFFFF1D5),
                                            child: FadeInImage(
                                                placeholder: NetworkImage(
                                                  'https://www.icegif.com/wp-content/uploads/loading-icegif-1.gif',
                                                ),
                                                image: NetworkImage(
                                                    posts[i].icono)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, right: 5),
                                          child: Text(posts[i].nombre,
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 16)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                              ],
                            ));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(primaryColor),
                        backgroundColor: Colors.white,
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(0.0),
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: FutureBuilder(
                    future: _httpService.getPublicaciones(),
                    // _httpService.getPublicacionBySector('602a7d62762efc2080f88cc7'),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<PublicacionesData>> snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        List<PublicacionesData> posts = snapshot.data!;
                        return ListView.builder(
                            physics: ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: posts.length,
                            itemBuilder: (context, i) => PublicationCard(
                                key: UniqueKey(),
                                postId: posts[i].id,
                                fecha: posts[i]
                                        .createdAt
                                        .toString()
                                        .substring(0, 11)
                                        .toString() ??
                                    '12/06/2020',
                                empresaLogo: posts[i].empresa.logo,
                                titulo: posts[i].titulo,
                                guardados: posts[i].guardados,
                                likes: posts[i].likes.length,
                                videoUrl: posts[i].video,
                                descripcion: posts[i].texto,
                                comentarios: posts[i].comentarios,
                                nombreEmpresa: posts[i].empresa.nombre,
                                imageUrl: posts[i].foto));
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(primaryColor),
                            backgroundColor: Colors.white,
                          ),
                        );
                      }
                    },
                  )),
            ),
          ],
        ),
      ),
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 50),
          child: _buildSearchAppbar()),
    );
  }

  Widget _buildSearchAppbar() {
    return AppBarColor(
      title: Text(
        'Publicaciones',
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}
