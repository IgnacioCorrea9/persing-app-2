import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persing/core/ResponsiveDesign/responsive_design.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/core/ui/widgets/action_button.dart';
import 'package:persing/models/know_more/know_more_discounts_model.dart';
import 'package:persing/providers/recompensa.dart';
import 'package:persing/screens/orders/provider/order_provider.dart';
import 'package:persing/screens/orders/ui/orderresume_screen.dart';
import 'package:provider/provider.dart';

class OrderCartScreen extends StatelessWidget {
  OrderCartScreen({
    Key? key,
  }) : super(key: key);

  final Color purpleColor = primaryColor;
  final Color pinkColor = Color(0xFFFF0094);
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final ResponsiveDesign _responsiveDesign = ResponsiveDesign(context);
    final Size size = MediaQuery.of(context).size;
    final awardProvider = Provider.of<Recompensa>(context);
    final formatter =
        NumberFormat.currency(decimalDigits: 0, locale: 'es_CO', symbol: '');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title:
            Image.asset('assets/images/splash/logo-onboarding.png', width: 100),
        backgroundColor: primaryColor,
      ),
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
                  'Carrito de compras',
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
                    return _CartItem(
                        index: i,
                        product: orderProvider.cart[i],
                        size: size,
                        responsiveDesign: _responsiveDesign);
                  })),
          Divider(
            thickness: 1.24,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.1, vertical: size.height * 0.0168),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '\$${formatter.format(orderProvider.getTotal(0))}',
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ActionButton(
                size: size,
                pinkColor: pinkColor,
                purpleColor: Colors.white,
                title: 'Vaciar carrito',
                onPressed: () {
                  awardProvider.discountBySector.clear();
                  Navigator.of(context).pop();
                  orderProvider.clearCart();
                },
              ),
              ActionButton(
                size: size,
                pinkColor: orderProvider.cart.isEmpty ? Colors.grey : pinkColor,
                purpleColor: Colors.white,
                title: 'Continuar',
                onPressed: () {
                  if (orderProvider.cart.isNotEmpty) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OrderResumeScreen(),
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

class _CartItem extends StatelessWidget {
  const _CartItem({
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
    final orderProvider = Provider.of<OrderProvider>(context);
    final formatter =
        NumberFormat.currency(decimalDigits: 0, locale: 'es_CO', symbol: '');
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: size.width * 0.01,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: product.foto,
                height: _responsiveDesign.heightMultiplier(80),
                alignment: Alignment.center,
                width: _responsiveDesign.widthMultiplier(120),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
                    backgroundColor: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(
                  width: size.width * 0.45,
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          product.titulo,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.nunito(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.0045,
                ),
                Text(
                  'Unidades: ${formatter.format(product.cantidad)}',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.0045,
                ),
                if (product.descuento)
                  Column(
                    children: [
                      Text(
                        'Precio und: \$${formatter.format(product.precioDescuento)}',
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.0045,
                      ),
                      Text(
                        'Precio total: \$${formatter.format(product.precioDescuento * product.cantidad!)}',
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                if (!product.descuento)
                  Column(
                    children: [
                      Text(
                        'Precio und: \$${formatter.format(product.precio)}',
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.0045,
                      ),
                      Text(
                        'Precio total: \$${formatter.format(product.precioDescuento * product.cantidad!)}',
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            IconButton(
                onPressed: () {
                  orderProvider.removeProduct(index);
                },
                icon: Icon(Icons.delete_outline_rounded))
          ],
        ),
        Divider(
          thickness: 1,
        ),
      ],
    );
  }
}
