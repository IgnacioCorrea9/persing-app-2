import 'package:flutter/material.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/providers/comentario.dart';
import 'package:persing/providers/recompensa.dart';
import 'package:persing/screens/destacados/destacados_seccion_screen.dart';
import 'package:persing/screens/empresas/empresa_profile_screen.dart';
import 'package:persing/screens/index/index_screen.dart';
import 'package:persing/screens/publicaciones/publicaciones_by_sector.dart';
import 'package:persing/widgets/appbar.dart';
import 'package:persing/widgets/comment_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class CommentScreen extends StatefulWidget {
  final String postId;
  final String sector;
  final bool isDestacado;
  final bool isNew;
  bool seccion;
  final String idSection;
  final String nombreSection;
  final String? userId;
  final String? isEmpresa;
  CommentScreen(
      {super.key,
      required this.postId,
      required this.sector,
      this.isEmpresa,
      required this.idSection,
      required this.nombreSection,
      required this.isNew,
      required this.seccion,
      this.userId,
      required this.isDestacado});

  @override
  _CommentScreenState createState() => _CommentScreenState(
      this.postId, this.sector, this.seccion, this.isDestacado);
}

class _CommentScreenState extends State<CommentScreen> {
  final String postId;
  final String sector;
  final bool isDestacado;
  late bool seccion;
  late Future<List<Map<String, dynamic>>> _comentarios;
  final _inputController = TextEditingController();
  late bool _sending = false;
  _CommentScreenState(this.postId, this.sector, this.seccion, this.isDestacado);
  late Comentario comsProvider;

  @override
  void initState() {
    super.initState();
    comsProvider = Provider.of<Comentario>(context, listen: false);
    _comentarios = comsProvider.fetchComments(postId);
  }

  Future<void> _onRefresh() async {
    final comsProvider = Provider.of<Comentario>(context, listen: false);
    setState(() {
      _comentarios = Future.value(comsProvider.fetchComments(postId));
    });
  }

  Future<void> _sendComment() async {
    setState(() {
      _sending = true;
    });
    final String comment = _inputController.text;
    if (comment.isNotEmpty) {
      final comsProvider = Provider.of<Comentario>(context, listen: false);
      await comsProvider.postComment(postId, comment, isDestacado);
      if (!widget.isDestacado) {
        Provider.of<Recompensa>(context, listen: false)
            .recordInteraction(postId, sector, "comentario");
      }
      _inputController.text = "";
      await _onRefresh();
      setState(() {
        _sending = false;
      });
    }
  }

  String _getInitials(String name, String apellido) {
    if (apellido != '') {
      return name.substring(0, 1).toUpperCase() +
          apellido.substring(0, 1).toUpperCase();
    } else if (name != '') {
      return name.substring(0, 2).toUpperCase();
    } else {
      return '';
    }
  }

  void activeLoader() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("token") || prefs.containsKey("userId")) {
      await Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => IndexScreen()));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: AppBarColor(
          leading: IconButton(
              onPressed: () {
                if (widget.isNew) {
                  Navigator.pop(context);
                  return;
                }
                if (widget.idSection != null) {
                  Navigator.of(context).pop(
                    MaterialPageRoute(
                      builder: (context) => DestacadosSeccionScreen(
                          nombreSection: widget.nombreSection,
                          idSection: widget.idSection),
                    ),
                  );
                  return;
                }
                if (widget.userId != null) {
                  Navigator.of(context).pop(
                    MaterialPageRoute(
                      builder: (context) =>
                          PublicacionesBySector(sectorId: widget.sector),
                    ),
                  );
                  return;
                }
                if (widget.isEmpresa != null) {
                  Navigator.of(context).pop(
                    MaterialPageRoute(
                      builder: (context) => EmpresaProfileScreen(
                          idEnterprise: widget.isEmpresa ?? ''),
                    ),
                  );
                  return;
                }
                Navigator.pop(context);

                /*  Navigator.pop(context); */
              },
              icon: Icon(Icons.arrow_back)),
          title: Text(
            "Comentarios",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _comentarios,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Widget> cards = <Widget>[];
            for (int i = 0; i < snapshot.data!.length; i++) {
              final comment = snapshot.data![i];
              if (comment["usuario"] != null) {
                cards.add(
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: FutureBuilder(
                      future: comsProvider
                          .fetchScoreByUser(comment['usuario']['_id']),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        String ranking = '';
                        if (snapshot.connectionState == ConnectionState.done) {
                          ranking = snapshot.data;
                        }
                        return CommentCard(
                          ranking: ranking,
                          comment: comment["comentario"],
                          initials: _getInitials(comment["usuario"]["nombre"],
                              comment["usuario"]["apellido"] ?? null),
                        );
                      },
                    ),
                  ),
                );
              }
            }
            return Stack(children: [
              RefreshIndicator(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 24.64),
                  child: snapshot.data!.isEmpty
                      ? Center(
                          child: Text(
                            "Aún no hay comentarios, sé el primero en comentar",
                            style: TextStyle(color: Colors.grey[500]),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: ListView(children: cards),
                        ),
                ),
                onRefresh: _onRefresh,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                width: size.width,
                child: Material(
                  elevation: 10,
                  child: Container(
                    decoration:
                        BoxDecoration(color: Color.fromARGB(1, 240, 240, 240)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: _inputController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Escribe aquí tu comentario",
                          hintStyle: TextStyle(color: Colors.grey),
                          suffixIcon: GestureDetector(
                            onTap: () async {
                              await _sendComment();
                            },
                            child: _sending
                                ? Container(
                                    width: 10,
                                    height: 10,
                                    child: Center(
                                        child: Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                primaryColor),
                                        backgroundColor: Colors.white,
                                      ),
                                    )))
                                : Icon(
                                    Icons.arrow_forward,
                                    color: primaryColor,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ]);
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
              backgroundColor: Colors.white,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
