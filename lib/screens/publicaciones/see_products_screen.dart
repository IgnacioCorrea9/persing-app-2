import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persing/core/ResponsiveDesign/responsive_design.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/models/recompensa_home_model.dart';
import 'package:persing/models/sector_by_id_model.dart';
import 'package:persing/models/sector_model.dart';
import 'package:persing/repository/repository.dart';
import 'package:persing/screens/orders/provider/order_provider.dart';
import 'package:persing/screens/orders/ui/ordercart_screen.dart';
import 'package:persing/screens/publicaciones/widgets/products_list.dart';
import 'package:persing/widgets/appbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SeeProductosScreen extends StatefulWidget {
  SeeProductosScreen({Key? key, required this.sectorId}) : super(key: key);
  String sectorId;

  @override
  _SeeProductosScreenState createState() => _SeeProductosScreenState();
}

class _SeeProductosScreenState extends State<SeeProductosScreen> {
  Repository _httpService = Repository();
  late String userId;
  late String sector;
  late ResponsiveDesign responsive;
  var counter = 0;

  Future<void> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString("userId")!;
    });
  }

  final PageController sectorController = PageController();

  List<SectorData> sectors = [];

  final Color pinkColor = Color(0xFFFF0094);
  final Color purpleColor = primaryColor;

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    responsive = ResponsiveDesign(context);

    final orderProvider = Provider.of<OrderProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 50), child: _SearchAppBar()),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: pinkColor,
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderCartScreen(),
              ),
            );
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              if (orderProvider.cart.isNotEmpty)
                Positioned(
                  right: size.width * 0.026,
                  top: size.height * 0.019,
                  child: Icon(
                    Icons.circle,
                    size: 11,
                    color: purpleColor,
                  ),
                )
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getSections(),
            getCredits(),
            Expanded(
              child: FutureBuilder(
                future: _httpService.getSectorId(widget.sectorId),
                builder: (BuildContext context,
                    AsyncSnapshot<List<SectorByIdData>> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data!.length != null &&
                        snapshot.data!.length < 1) {
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
                                placeholder: CachedNetworkImageProvider(
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
                      List<SectorByIdData> posts = snapshot.data!;
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: ProductsList(
                          posts: posts,
                        ),
                      );
                    }
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
          ],
        ));
  }

  Widget getSections() {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FutureBuilder<List<SectorData>>(
              future: sectors.isNotEmpty ? null : _httpService.getSector(),
              builder: (context, snapshot) {
                if ((snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) ||
                    sectors.isNotEmpty) {
                  sectors = snapshot.data!;

                  if (widget.sectorId == null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (widget.sectorId != sectors[0].id) {
                        setState(() {
                          widget.sectorId = sectors[0].id;
                        });
                      }
                    });
                  } else {
                    // validar para que la opción seleccionada aparezca en la primera posición

                    // var sectores = List.of(sectors);
                    // final index = sectores
                    //     .indexWhere((element) => element.id == widget.sectorId);
                    // if (index >= 0) {
                    //   final secttor = sectores.removeAt(index);
                    //   sectores = [secttor, ...sectores];
                    // }
                    // sectors = sectores;
                  }

                  return PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: sectors.length,
                    controller: sectorController,
                    itemBuilder: (context, i) => Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.sectorId = sectors[i].id;
                              _httpService.getSectorId(sectors[i].id);
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 300,
                            ),
                            margin: EdgeInsets.only(
                              top: 10,
                              left: size.width * 0.02,
                            ),
                            height: 60,
                            width: size.width * 0.806,
                            decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(
                                  color: widget.sectorId == sectors[i].id
                                      ? Color(0xFFFF0094)
                                      : Colors.grey[50]!,
                                )),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  height: 60,
                                  width: 50.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Color(0xFFFFF1D5),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: FadeInImage(
                                      placeholder: CachedNetworkImageProvider(
                                        'https://www.icegif.com/wp-content/uploads/loading-icegif-1.gif',
                                      ),
                                      image: CachedNetworkImageProvider(
                                          sectors[i].icono),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: responsive.widthMultiplier(290.0),
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      sectors[i].nombre,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 15.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                      ],
                    ),
                  );
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
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(
              top: 10,
              right: size.width * 0.025,
            ),
            child: GestureDetector(
              onTap: () {
                sectorController.animateToPage(
                  sectorController.page!.toInt() + 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.bounceInOut,
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.11,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getCredits() {
    return FutureBuilder<List<RecompensaHomeData>>(
        future: _httpService.getRecompensaHome(userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final index = snapshot.data!.indexWhere(
              (element) {
                try {
                  return element.sector!.id == widget.sectorId;
                } catch (e) {
                  return false;
                }
              },
            );
            if (index >= 0) {
              final creditos = snapshot.data![index].creditos;
              return Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 16),
                child: Text('Créditos disponibles: \$ ${creditos.toString()}',
                    style: TextStyle(color: Colors.grey)),
              );
            }
          }
          return Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16),
            child: Text('Créditos disponibles: \$ 0',
                style: TextStyle(color: Colors.grey)),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _SearchAppBar extends AppBarColor {
  _SearchAppBar()
      : super(
          title: Text(
            'Productos',
            style: TextStyle(fontSize: 14),
          ),
        );
}
