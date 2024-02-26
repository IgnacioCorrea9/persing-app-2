import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/models/featured_screen/news_publications_model.dart';
import 'package:persing/repository/repository.dart';
import 'package:persing/widgets/publication_card.dart';
import 'package:persing/widgets/returnButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DestacadosNuevosScreen extends StatefulWidget {
  DestacadosNuevosScreen({super.key});

  @override
  _DestacadosNuevosScreenState createState() => _DestacadosNuevosScreenState();
}

class _DestacadosNuevosScreenState extends State<DestacadosNuevosScreen> {
  Repository _httpService = Repository();
  late String userId;

  Future<void> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString("userId")!;
    });
  }

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ReturnButton(),
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text('Nuevos', style: GoogleFonts.nunito(fontSize: 16)),
      ),
      body: FutureBuilder(
        future: _httpService.getNewsPublications(userId),
        builder: (BuildContext context,
            AsyncSnapshot<List<NewsPublicationsModelData>> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            List<NewsPublicationsModelData> posts = snapshot.data!;
            return ListView.builder(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: posts.length,
              itemBuilder: (context, i) {
                return PublicationCard(
                  key: UniqueKey(),
                  link: '',
                  imageUrl: posts[i].foto,
                  sector: posts[i].sector.id,
                  isNew: true,
                  isDestacado: false,
                  comentarios: posts[i].comentarios,
                  descripcion: posts[i].texto ?? "Sin descripción",
                  fecha: posts[i].createdAt.toString().substring(0, 10) ??
                      "Sin fecha", //
                  likes: posts[i].likes,
                  guardados: [],
                  titulo: posts[i].titulo,
                  nombreEmpresa: posts[i].empresa.nombre,
                  empresaLogo: posts[i].empresa.logo,
                  postId: posts[i].id,
                  liked: posts[i].liked, //post[i].liked,
                  saved: false,
                  videoUrl: posts[i].video,
                  seccion: false,
                  //sector: post[i].sector.id,
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                backgroundColor: Colors.white,
              ),
            );
          }
        },
      ),
    );
  }
}
