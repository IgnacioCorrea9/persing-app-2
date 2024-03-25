import 'package:flutter/material.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/models/publicaciones_sector_model.dart';
import 'package:persing/repository/repository.dart';
import 'package:persing/widgets/appbar.dart';
import 'package:persing/widgets/publication_card.dart';
import 'package:persing/widgets/returnButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PublicacionesBySector extends StatefulWidget {
  PublicacionesBySector({
    super.key,
    required this.sectorId,
  });
  final String sectorId;

  @override
  _PublicacionesBySectorState createState() => _PublicacionesBySectorState();
}

class _PublicacionesBySectorState extends State<PublicacionesBySector> {
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
<<<<<<< HEAD
    userId = "";
=======
>>>>>>> main
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 50),
            child: _buildSearchAppbar()),
        backgroundColor: Colors.white,
        body: Container(
          child: FutureBuilder(
            future:
                _httpService.getPublicacionBySector(widget.sectorId, userId),
            builder: (BuildContext context,
                AsyncSnapshot<List<PublicacionesBySectorData>> snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                //if (snapshot.data!.length != null && snapshot.data!.length < 1) {
                if (snapshot.data!.length < 1) {
                  String imgUrl =
                      "assets/images/empresas/estado-vacio-pink.png";
                  return Center(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          FadeInImage(
                            alignment: Alignment.center,
                            width: 200,
                            height: 200,
                            image: AssetImage(imgUrl),
                            placeholder: NetworkImage(
                              'https://www.icegif.com/wp-content/uploads/loading-icegif-1.gif',
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'En estos momentos no tenemos productos\npara esta categoría',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  List<PublicacionesBySectorData> post = snapshot.data!;
                  post.forEach((element) {});
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return PublicationCard(
                        key: UniqueKey(),
                        link: post[i].link,
                        imageUrl: post[i].foto,
                        comentarios: post[i].comentarios,
                        descripcion: post[i].texto ?? "Sin descripción",
                        fecha: post[i].createdAt.toString().substring(0, 10) ??
                            "Sin fecha", //
                        likes: post[i].likes,
                        guardados: post[i].guardados,
                        titulo: post[i].titulo,
                        nombreEmpresa: post[i].empresa.nombre,
                        empresaLogo: post[i].empresa.logo,
                        postId: post[i].id,
                        liked: post[i].liked, //post[i].liked,
                        saved: post[i].saved,
                        videoUrl: post[i].video,
                        sector: post[i].sector.id,
                        usuarioId: userId,
                        isNew: false,
                      );
                    },
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
                    backgroundColor: Colors.white,
                  ),
                );
              }
            },
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showErrorDialog(String message) {
    String imgUrl = "assets/images/empresas/estado-vacio-pink.png";
    showDialog(
        context: context,
        builder: (ctx) => Center(
              child: Container(
                height: 530,
                child: AlertDialog(
                  title: Text("Producto no disponible",
                      style: TextStyle(color: primaryColor, fontSize: 16)),
                  content: Column(
                    children: [
                      FadeInImage(
                        alignment: Alignment.center,
                        width: 200,
                        height: 200,
                        image: AssetImage(imgUrl),
                        placeholder: NetworkImage(
                          'https://www.icegif.com/wp-content/uploads/loading-icegif-1.gif',
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(message,
                          style: TextStyle(color: primaryColor, fontSize: 16)),
                      SizedBox(height: 20),
                      Container(
                          width: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey[50],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white60,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: Navigator.of(ctx).pop,
                            child: Text('¡Entendido!',
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFFF0094),
                                textStyle: TextStyle(color: Colors.white)),
                          ))
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget _buildSearchAppbar() {
    return AppBarColor(
      leading: ReturnButton(),
      title: Text(
        'Publicaciones por sector',
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}
