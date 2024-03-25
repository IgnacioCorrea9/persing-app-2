import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/models/featured_screen/featured_section_model.dart';
import 'package:persing/repository/repository.dart';
import 'package:persing/widgets/publication_card.dart';
import 'package:persing/widgets/returnButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DestacadosSeccionScreen extends StatefulWidget {
  DestacadosSeccionScreen({
    super.key,
    this.idSection = '',
    this.nombreSection = '',
  });
  final String idSection;
  final String nombreSection;
  @override
  _DestacadosSeccionScreenState createState() =>
      _DestacadosSeccionScreenState();
}

class _DestacadosSeccionScreenState extends State<DestacadosSeccionScreen> {
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
    userId = "";
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String imgUrl = "assets/images/empresas/estado-vacio-purple.png";

    return Scaffold(
        appBar: AppBar(
          leading: ReturnButton(),
          centerTitle: true,
          backgroundColor: primaryColor,
          title: Text(widget.nombreSection,
              style: GoogleFonts.nunito(fontSize: 16)),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: FutureBuilder(
                  future:
                      _httpService.getDetailsSeccions(widget.idSection, userId),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<FeaturedSectionModelData>> snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done &&
                        snapshot.data!.length > 0) {
                      List<FeaturedSectionModelData> post = snapshot.data!;
                      return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: post.length,
                        itemBuilder: (context, i) {
                          return PublicationCard(
                            key: UniqueKey(),
                            link: '',
                            imageUrl: post[i].foto ?? "",
                            sector: post[i].seccion.id,
                            isDestacado: true,
                            comentarios: post[i].comentarios,
                            descripcion: post[i].texto ?? "Sin descripción",
                            fecha:
                                post[i].createdAt.toString().substring(0, 10) ??
                                    "Sin fecha",
                            likes: post[i].likes,

                            guardados: [],
                            titulo: post[i].titulo,
                            nombreEmpresa: post[i].titulo,
                            empresaLogo: post[i].seccion.icono,
                            postId: post[i].id,
                            liked: post[i].liked,
                            saved: false,
                            videoUrl: post[i].video!,
                            seccion: true,
                            idSection: widget.idSection,
                            nombreSection: widget.nombreSection,
                            isNew: false,
                            //sector: post[i].sector.id,
                          );
                        },
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(primaryColor),
                          backgroundColor: Colors.white,
                        ),
                      );
                    } else {
                      return Center(
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Aún no existen publicaciones",
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                                FadeInImage(
                                  alignment: Alignment.center,
                                  width: 200,
                                  height: 200,
                                  image: AssetImage(imgUrl),
                                  placeholder: NetworkImage(
                                    'https://www.icegif.com/wp-content/uploads/loading-icegif-1.gif',
                                  ),
                                ),
                                SizedBox()
                              ],
                            )),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }

  void showAlertDialog(String title, String message, BuildContext context,
      String messageButton) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                ElevatedButton(
                  onPressed: Navigator.of(ctx).pop,
                  child: Text(messageButton),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF0094),
                      textStyle: TextStyle(color: Colors.white)),
                ),
              ],
            ));
  }
}
