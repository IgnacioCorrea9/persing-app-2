import 'dart:async';

import 'package:flutter/material.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/models/publicaciones_saved_model.dart';
import 'package:persing/providers/publicacion.dart';
import 'package:persing/widgets/appbar.dart';
import 'package:persing/widgets/publication_card.dart';
import 'package:provider/provider.dart';

class SavedPostsScreen extends StatefulWidget {
  SavedPostsScreen({Key? key}) : super(key: key);

  @override
  _SavedPostsScreenState createState() => _SavedPostsScreenState();
}

class _SavedPostsScreenState extends State<SavedPostsScreen> {
  late StreamController<List<PublicacionesSavedData>> _publicacionesStream;

  @override
  void initState() {
    _publicacionesStream = StreamController<List<PublicacionesSavedData>>();
    _loadPosts();
    super.initState();
  }

  void _loadPosts() async {
    final pubsProvider = Provider.of<Publicacion>(context, listen: false);
    pubsProvider.fetchSavedPost().then((value) {
      _publicacionesStream.add(value);
    });
  }

  Future<void> _onRefresh() async {
    final pubsProvider = Provider.of<Publicacion>(context, listen: false);
    setState(() {
      pubsProvider.fetchSavedPost().then((value) {
        _publicacionesStream.add(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
            title: Text(
              'Publicaciones guardadas',
              style: TextStyle(fontSize: 14),
            ),
            onPressed: () {},
          ),
        ),
        body: StreamBuilder<List<PublicacionesSavedData>>(
          stream: _publicacionesStream.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length != null && snapshot.data!.length < 1) {
                String imgUrl = "assets/images/empresas/estado-vacio-pink.png";
                return Center(
                  child: Container(
                    padding: EdgeInsets.all(80),
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
                          'En estos momentos no tenemos publicaciones\nguardadas',
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
                return RefreshIndicator(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var post = snapshot.data![index];
                        return PublicationCard(
                          key: UniqueKey(),
                          link: post.link,
                          imageUrl: post.foto,
                          comentarios: post.comentarios,
                          descripcion: post.texto ?? "Sin descripción",
                          fecha: post.createdAt.toString().substring(0, 10) ??
                              "Sin fecha", //
                          likes: post.likes,
                          guardados: post.guardados,
                          titulo: post.titulo,
                          nombreEmpresa: post.empresa.nombre,
                          empresaLogo: post.empresa.logo,
                          postId: post.id,
                          liked: post.liked,
                          saved: post.saved,
                          videoUrl: post.video ?? "",
                          sector: post.sector.id, isNew: false,
                        );
                      },
                    ),
                    onRefresh: _onRefresh);
              }
            }

            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
                backgroundColor: Colors.white,
              ),
            );
          },
        ));
  }
}
