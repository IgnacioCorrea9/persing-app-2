import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persing/core/ResponsiveDesign/responsive_design.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/models/enterprises/enterprises_by_id_model.dart';
import 'package:persing/repository/repository.dart';
import 'package:persing/widgets/appbar.dart';
import 'package:persing/widgets/publication_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmpresaProfileScreen extends StatefulWidget {
  EmpresaProfileScreen({Key? key, required this.idEnterprise})
      : super(key: key);
  final String idEnterprise;
  @override
  _EmpresaProfileScreenState createState() => _EmpresaProfileScreenState();
}

class _EmpresaProfileScreenState extends State<EmpresaProfileScreen> {
  late ResponsiveDesign _responsiveDesign;
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
    _responsiveDesign = ResponsiveDesign(context);
    String imgUrl = "assets/images/empresas/estado-vacio-purple.png";
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
            title: Text('Perfil de empresa', style: TextStyle(fontSize: 14)),
            onPressed: () {},
          ),
        ),
        body: FutureBuilder(
            future: _httpService.getEmpresaById(widget.idEnterprise, userId),
            builder: (BuildContext context,
                AsyncSnapshot<List<EnterprisesByIdModelData>> snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done &&
                  snapshot.data!.length > 0) {
                List<EnterprisesByIdModelData> posts = snapshot.data!;
                final dateFormat = DateFormat('dd-MM-yyyy');
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          if (i == 0)
                            _buildEmpresaInformation(
                                posts[0].empresa.nombre,
                                posts[0].empresa.descripcion,
                                posts[0].empresa.logo,
                                posts[0].empresa.nit),
                          PublicationCard(
                            key: UniqueKey(),
                            isEmpresa: widget.idEnterprise,
                            link: posts[i].link!,
                            guardados: posts[i].guardados,
                            isDestacado: false,
                            liked: posts[i].liked,
                            saved: posts[i].saved,
                            videoUrl: posts[i].video!,
                            //sector: posts[i].sector,
                            postId: posts[i].id,
                            fecha: dateFormat.format(posts[i].createdAt),
                            empresaLogo: posts[i].empresa.logo,
                            titulo: posts[i].titulo,
                            likes: posts[i].likes,
                            descripcion: posts[i].texto,
                            comentarios: posts[i].comentarios,
                            nombreEmpresa: posts[i].empresa.nombre,
                            imageUrl: posts[i].foto!,
                            isNew: false, sector: posts[i].sector.nombre,
                          ),
                        ],
                      );
                    });
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
                    backgroundColor: Colors.white,
                  ),
                );
              } else {
                return Container(
                    padding: EdgeInsets.all(32),
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Aún no existen publicaciones de esta empresa",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        FadeInImage(
                          alignment: Alignment.center,
                          width: _responsiveDesign.widthMultiplier(200),
                          image: AssetImage(imgUrl),
                          placeholder: NetworkImage(
                            'https://www.icegif.com/wp-content/uploads/loading-icegif-1.gif',
                          ),
                        ),
                        SizedBox()
                      ],
                    ));
              }
            }));
  }

  Widget _buildEmpresaInformation(
      String nameEnterprise,
      String descriptionEnterprise,
      String logoEnterprise,
      String sectorDescription) {
    return Container(
        color: Colors.grey[50],
        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: _responsiveDesign.widthMultiplier(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.contain,
                                image: new NetworkImage(logoEnterprise)),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                nameEnterprise,
                                style: TextStyle(
                                    color: Color(0xFF707070), fontSize: 18),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              width: 250,
                              child: Text(
                                descriptionEnterprise,
                                style: TextStyle(
                                    color: Color(0xFF707070),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 10,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 12),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            child: Text('Ver Página Web',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: primaryColor)),
                            onTap: () {}),
                        SizedBox(
                          height: 8,
                        ),
                        Wrap(
                          children: [
                            Text(
                              'Nit: ${sectorDescription ?? ''}',
                              style: TextStyle(fontSize: 14),
                            )
                          ],
                        )
                      ])),
            ],
          ),
        ));
  }
}
