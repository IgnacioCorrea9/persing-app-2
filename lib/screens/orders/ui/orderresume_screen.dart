import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persing/core/ResponsiveDesign/responsive_design.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/core/ui/widgets/action_button.dart';
import 'package:persing/core/ui/widgets/persing_appbar.dart';
import 'package:persing/screens/orders/provider/order_provider.dart';
import 'package:persing/screens/payment/provider/wompi_provider.dart';
import 'package:persing/screens/payment/ui/screens/payment_form_screen.dart';
import 'package:provider/provider.dart';

import '../../../models/know_more/know_more_discounts_model.dart';
import '../../../providers/recompensa.dart';

class OrderResumeScreen extends StatefulWidget {
  @override
  State<OrderResumeScreen> createState() => _OrderResumeScreenState();
}

class _OrderResumeScreenState extends State<OrderResumeScreen> {
  final Color purpleColor = primaryColor;

  final Color pinkColor = Color(0xFFFF0094);
  @override
  void initState() {
    getTotalDiscount = Provider.of<Recompensa>(context, listen: false)
        .getDiscountBySector(Provider.of<OrderProvider>(
      context,
      listen: false,
    ).cart);
    super.initState();
  }

  bool canPay = false;

  dynamic getTotalDiscount;
  @override
  Widget build(BuildContext context) {
    final wompiProvider = Provider.of<WompiProvider>(context);
    final formatter =
        NumberFormat.currency(decimalDigits: 0, locale: 'es_CO', symbol: '');
    final orderProvider = Provider.of<OrderProvider>(context);
    final awardProvider = Provider.of<Recompensa>(context);
    final ResponsiveDesign _responsiveDesign = ResponsiveDesign(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PersingAppbar(),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: purpleColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.1, vertical: size.height * 0.0168),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Resumen de pedido',
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: orderProvider.cart.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: size.height * 0.015),
              itemBuilder: (_, i) {
                return Column(
                  children: [
                    _OrderDetailItem(
                        index: i,
                        product: orderProvider.cart[i],
                        size: size,
                        responsiveDesign: _responsiveDesign),
                    if (i != orderProvider.cart.length - 1)
                      Divider(
                        thickness: 1.2,
                      ),
                  ],
                );
              },
            ),
          ),
          Divider(
            thickness: 1.24,
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.1,
                    vertical: size.height * 0.0168),
                child: Text(
                  'Descuento total:',
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.1,
                  vertical: size.height * 0.0168,
                ),
                child: FutureBuilder<int>(
                    future: getTotalDiscount,
                    builder: (context, snapshot) {
                      final uniqueSectorsDiscount =
                          awardProvider.uniqueSectors();
                      if (snapshot.hasData) {
                        canPay = true;
                        return Column(
                          children: [
                            Column(children: [
                              for (var i = 0;
                                  i < uniqueSectorsDiscount.length;
                                  i++)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      uniqueSectorsDiscount[i].sector,
                                      style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.08,
                                    ),
                                    Text(
                                      '\$ - ${formatter.format(
                                        uniqueSectorsDiscount[i].totalDiscount,
                                      )}',
                                      style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                            ]),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.0168,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total a pagar:',
                                    style: GoogleFonts.nunito(
                                      color: purpleColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.12,
                                  ),
                                  Text(
                                    '\$${formatter.format(
                                      orderProvider.getTotal(
                                        awardProvider.totalDiscount(),
                                      ),
                                    )}',
                                    style: GoogleFonts.nunito(
                                      color: purpleColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Center(
                          child: SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: purpleColor,
                            ),
                          ),
                        );
                      }
                    }),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ActionButton(
                size: size,
                pinkColor: pinkColor,
                purpleColor: Colors.white,
                title: 'Volver',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ActionButton(
                size: size,
                pinkColor: pinkColor,
                purpleColor: Colors.white,
                title: 'Continuar',
                onPressed: () {
                  if (canPay) {
                    wompiProvider.succeed = false;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentFormScreen(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
        ],
      ),
    );
  }
}

class _OrderDetailItem extends StatelessWidget {
  const _OrderDetailItem({
    Key? key,
    required this.size,
    required ResponsiveDesign responsiveDesign,
    required this.product,
    required this.index,
  })  : _responsiveDesign = responsiveDesign,
        super(key: key);

  final Size size;
  final ResponsiveDesign _responsiveDesign;
  final KnowMoreDiscountsModelData product;
  final int index;

  @override
  Widget build(BuildContext context) {
    final formatter =
        NumberFormat.currency(decimalDigits: 0, locale: 'es_CO', symbol: '');
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.024),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: product.foto,
                  height: _responsiveDesign.heightMultiplier(50),
                  alignment: Alignment.center,
                  width: _responsiveDesign.widthMultiplier(60),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(primaryColor),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(
                width: size.width * 0.025,
              ),
              SizedBox(
                width: size.width * 0.35,
                child: Text(
                  product.titulo,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: GoogleFonts.nunito(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'x ${product.cantidad}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: GoogleFonts.nunito(
                        fontSize: 12,
                      ),
                    ),
                    if (product.descuento)
                      Text(
                        '\$${formatter.format(product.precioDescuento * product.cantidad!)}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                        ),
                      ),
                    if (!product.descuento)
                      Text(
                        '\$${formatter.format(product.precio * product.cantidad!)}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
