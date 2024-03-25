// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persing/core/ResponsiveDesign/responsive_design.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/models/enterprises_model.dart';
import 'package:persing/models/know_more/know_more_discounts_model.dart';
import 'package:persing/models/sector_model.dart';
import 'package:persing/repository/repository.dart';
import 'package:persing/screens/empresas/empresa_profile_screen.dart';
import 'package:persing/screens/empresas/empresa_section.dart';
import 'package:persing/providers/auth.dart';
import 'package:persing/screens/index/saved_posts.dart';
import 'package:persing/screens/orders/provider/order_provider.dart';
import 'package:persing/screens/orders/ui/ordercart_screen.dart';
import 'package:persing/screens/products/provider/product_provider.dart';
import 'package:persing/screens/products/ui/product_detail.dart';
import 'package:persing/screens/publicaciones/publicaciones_by_sector.dart';
import 'package:persing/utils/text_formatting.dart';
import 'package:persing/widgets/custom_icons.dart';
import 'package:persing/widgets/filter_screen.dart';
import 'package:persing/widgets/text_layout_builder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiscoverScreen extends StatefulWidget {
  DiscoverScreen({super.key});

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  late ResponsiveDesign _responsiveDesign;
  late Repository _httpService = Repository();
  late String userId;
  final List<Tab> myTabs = <Tab>[
    Tab(
      child: Container(
          height: 80,
          // width: 200,
          decoration: BoxDecoration(
            color: Colors.grey[50],
            boxShadow: [
              BoxShadow(
                color: Colors.white60,
                offset: Offset(0.0, 1.0),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Card(
            borderOnForeground: true,
            // elevation: 0.0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.stickyNote, color: primaryColor),
                  SizedBox(width: 10),
                  Text(
                    'Descubre por categorías',
                    style: TextStyle(fontSize: 14, color: primaryColor),
                    maxLines: 2,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          )),
    ),
    Tab(
        child: Container(
            height: 80,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              boxShadow: [
                BoxShadow(
                  color: Colors.white60,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Card(
              borderOnForeground: true,
              elevation: 0.0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.building, color: primaryColor),
                    SizedBox(width: 10),
                    Text(
                      'Mira todas las empresas',
                      style: TextStyle(fontSize: 14, color: primaryColor),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ),
            ))),
    Tab(
        child: Container(
            height: 80,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              boxShadow: [
                BoxShadow(
                  color: Colors.white60,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Card(
              borderOnForeground: true,
              elevation: 0.0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.sun, color: primaryColor),
                    SizedBox(width: 10),
                    Container(
                      width: 110,
                      child: Text(
                        'Descuentos',
                        style: TextStyle(fontSize: 14, color: primaryColor),
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
              ),
            ))),
  ];

  late TabController _tabController;

  late ResponsiveDesign responsive;

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

  Future<void> getUser() async {
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
    _tabController = TabController(vsync: this, length: myTabs.length);
    getUser();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _navigateEmpresaProfile(String id) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EmpresaProfileScreen(idEnterprise: id)));
  }

  final Color purpleColor = primaryColor;
  final Color pinkColor = Color(0xFFFF0094);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final orderProvider = Provider.of<OrderProvider>(context);
    responsive = ResponsiveDesign(context);
    final productProvider = Provider.of<ProductProvider>(context);
    _responsiveDesign = ResponsiveDesign(context);
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        floatingActionButton: _tabController.index == 2
            ? FloatingActionButton(
                backgroundColor: pinkColor,
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderCartScreen()));
                },
                child: Stack(
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    if (orderProvider.cart.isNotEmpty)
                      Positioned(
                          left: size.width * 0.036,
                          bottom: size.height * 0.016,
                          child: Icon(
                            Icons.circle,
                            size: 11,
                            color: purpleColor,
                          ))
                  ],
                ),
              )
            : null,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 50),
            child: _buildSearchAppbar()),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: _responsiveDesign.heightMultiplier(4.0)),
                      child: FutureBuilder(
                        future: _httpService.getSector(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<SectorData>> snapshot) {
                          if (snapshot.hasData &&
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            List<SectorData> posts = snapshot.data!;
                            final imageHeight =
                                _responsiveDesign.heightMultiplier(60);
                            final imageWight =
                                _responsiveDesign.widthMultiplier(60);
                            return GridView.builder(
                                physics: ClampingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      MediaQuery.of(context).orientation ==
                                              Orientation.landscape
                                          ? 3
                                          : 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: (3 / 2),
                                ),
                                itemCount: posts.length,
                                itemBuilder: (context, i) => Column(
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
                                              width: _responsiveDesign
                                                  .widthMultiplier(180),
                                              child: Card(
                                                borderOnForeground: true,
                                                elevation: 0.1,
                                                child: Column(
                                                  children: [
                                                    CachedNetworkImage(
                                                      width: imageHeight > 60
                                                          ? 60
                                                          : imageHeight,
                                                      imageUrl: posts[i].icono,
                                                      height: imageWight > 60
                                                          ? 60
                                                          : imageWight,
                                                      alignment:
                                                          Alignment.center,
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  downloadProgress) =>
                                                              Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          valueColor:
                                                              new AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Color(
                                                                      0xFF1F0681)),
                                                          backgroundColor:
                                                              Colors.white,
                                                        ),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    ),
                                                    LayoutBuilderTextSizeDown(
                                                      text: posts[i].nombre,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                      downValue: 0.1,
                                                      textAlign:
                                                          TextAlign.center,
                                                      lowestFontSize: 13,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ),
                                        SizedBox(width: 15),
                                      ],
                                    ));
                          } else {
                            return Center(
                                child: Center(
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    primaryColor),
                                backgroundColor: Colors.white,
                              ),
                            ));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
                child: Padding(
              padding: EdgeInsets.all(0.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: FutureBuilder(
                  future: _httpService.getEmpresas(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<DataEnterprises>> snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      List<DataEnterprises> posts = snapshot.data!;
                      return GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        childAspectRatio: 0.9,
                        children: List.generate(
                          posts.length,
                          (i) => GestureDetector(
                            onTap: () => _navigateEmpresaProfile(posts[i].id),
                            child: EmpresaSection(
                              logoUrl: posts[i].logo ?? '',
                              name: posts[i].nombre ?? 'Nombre vacío',
                              type: posts[i].descripcion ?? 'Tipo vacío',
                            ),
                          ),
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
            )),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: FutureBuilder(
                      future: _httpService.knowMoreDiscounts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<KnowMoreDiscountsModelData>>
                              snapshot) {
                        if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          List<KnowMoreDiscountsModelData> posts =
                              snapshot.data!;
                          return GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            childAspectRatio: 0.9,
                            children: List.generate(
                              posts.length,
                              (i) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailScreen(
                                        product: posts[i],
                                      ),
                                    ),
                                  );

                                  productProvider.counter = 1;
                                },
                                child: Container(
                                  width: _responsiveDesign.widthMultiplier(205),
                                  padding: EdgeInsets.only(
                                      left: _responsiveDesign
                                          .widthMultiplier(16.0),
                                      right: _responsiveDesign
                                          .widthMultiplier(16.0),
                                      top: _responsiveDesign
                                          .heightMultiplier(8.0)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: posts[i].foto,
                                          height: _responsiveDesign
                                              .heightMultiplier(90),
                                          alignment: Alignment.center,
                                          width: _responsiveDesign
                                              .widthMultiplier(166),
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  new AlwaysStoppedAnimation<
                                                      Color>(
                                                Color.fromARGB(
                                                    255, 109, 77, 238),
                                              ),
                                              backgroundColor: Colors.white,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          posts[i].titulo ?? '',
                                          style: TextStyle(fontSize: 14),
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                      posts[i].descuento
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  TextFormatting
                                                      .getFormattedCurrency(
                                                    posts[i].precio,
                                                  ),
                                                  style: TextStyle(
                                                      color: Color(0xFF707070),
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      fontSize: 14),
                                                  maxLines: 2,
                                                ),
                                                Text(
                                                  TextFormatting
                                                      .getFormattedCurrency(
                                                    posts[i].precioDescuento,
                                                  ),
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 14,
                                                  ),
                                                  maxLines: 2,
                                                )
                                              ],
                                            )
                                          : Text(
                                              TextFormatting
                                                  .getFormattedCurrency(
                                                posts[i].precio,
                                              ),
                                              style: TextStyle(
                                                  color: Color(
                                                    0xFF707070,
                                                  ),
                                                  fontSize: 14),
                                              maxLines: 2,
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Center(
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    primaryColor),
                                backgroundColor: Colors.white,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
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
                    child: Text('¡Entendido!'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF0094),
                        textStyle: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _navigateFilters(BuildContext context) async {
    final close = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FilterScreen()));

    if (close) {
      //_onRefresh();
    }
  }

  _navigateSavedPosts(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SavedPostsScreen()));
  }

  Widget _buildSearchAppbar() {
    return AppBar(
      leading: null,
      centerTitle: false,
      automaticallyImplyLeading: false,
<<<<<<< HEAD
      toolbarHeight: 150,
=======
      toolbarHeight: 105,
>>>>>>> main
      title: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8,
          ),
          child: TextField(
            style: TextStyle(color: Colors.white),
            onChanged: (value) {
              onSearch(value);
            },
            decoration: InputDecoration(
              isDense: true, // Added this
              contentPadding: EdgeInsets.only(top: 5, bottom: 5),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(1, 240, 240, 240),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(1, 240, 240, 240),
                ),
              ),
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
      ),
      backgroundColor: primaryColor,
      actions: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 17.5,
              top: 8,
            ),
            child: GestureDetector(
              onTap: () {
                _navigateFilters(context);
              },
              child: Icon(
                CustomIcons.filters,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 17.5,
              top: 8,
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
            ),
          ),
        )
      ],
      bottom: TabBar(
        onTap: (value) {
          setState(() {});
        },
        controller: _tabController,
        isScrollable: true,
        automaticIndicatorColorAdjustment: true,
        indicatorColor: Color(0xFFFF0094),
        indicatorWeight: 0.1,
        labelPadding: EdgeInsets.only(top: 10.0),
        unselectedLabelColor: Colors.grey,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: [
          _TabBarBottomElements(
            text: 'Descubre por categorías',
            isSelected: _tabController.index == 0,
          ),
          _TabBarBottomElements(
            text: 'Mira todas las empresas',
            isSelected: _tabController.index == 1,
          ),
          _TabBarBottomElements(
            text: 'Descuentos',
            isSelected: _tabController.index == 2,
          ),
        ],
      ),
    );
  }
}

/// TabBar elements shown on screen appBar
class _TabBarBottomElements extends StatelessWidget {
  /// Constructor
  const _TabBarBottomElements({
<<<<<<< HEAD
    super.key,
=======
>>>>>>> main
    this.text = '',
    this.isSelected = false,
  });

  final String text;

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveDesign(context);
    return Container(
      color: Colors.white,
      child: Container(
        height: 65,
        width: responsive.widthMultiplier(200),
        decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Color(0xFFFF0094) : Colors.white,
            ),
            color: Colors.grey[50],
            boxShadow: [
              BoxShadow(
                color: Colors.white60,
                offset: Offset(0.0, 1.0),
                blurRadius: 6.0,
              ),
            ],
            borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 10,
        ),
        child: Card(
          borderOnForeground: true,
          elevation: 0.0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.stickyNote,
                  color: primaryColor,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: LayoutBuilderTextSizeDown(
                    text: text,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(
                        0xFF1F0681,
                      ),
                    ),
                    maxLines: 2,
                    downValue: 0.2,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
