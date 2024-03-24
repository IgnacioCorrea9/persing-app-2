import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persing/core/ResponsiveDesign/responsive_design.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/core/ui/widgets/action_button.dart';
import 'package:persing/models/know_more/know_more_discounts_model.dart';
import 'package:persing/screens/orders/provider/order_provider.dart';
import 'package:persing/screens/orders/ui/ordercart_screen.dart';
import 'package:persing/screens/products/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  final KnowMoreDiscountsModelData product;
  final Color purpleColor = primaryColor;
  final Color pinkColor = Color(0xFFFF0094);
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final ResponsiveDesign _responsiveDesign = ResponsiveDesign(context);
    final Size size = MediaQuery.of(context).size;
    final formatter =
        NumberFormat.currency(decimalDigits: 0, locale: 'es_CO', symbol: '');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              productProvider.counter = 1;
            },
            icon: Icon(Icons.arrow_back)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title:
            Image.asset('assets/images/splash/logo-onboarding.png', width: 100),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.044),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.04,
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: product.foto,
                      height: _responsiveDesign.heightMultiplier(150),
                      alignment: Alignment.center,
                      width: _responsiveDesign.widthMultiplier(150),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
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
                    width: size.width * 0.04,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * 0.44,
                        child: Text(
                          product.titulo,
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            color: pinkColor,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.0155,
                      ),
                      if (!product.descuento)
                        Text(
                          '\$${formatter.format(product.precio)}',
                          style: GoogleFonts.nunito(
                              color: purpleColor, fontSize: 14),
                          textAlign: TextAlign.left,
                        ),
                      if (product.descuento)
                        Text(
                          '\$${formatter.format(product.precioDescuento)}',
                          style: GoogleFonts.nunito(
                              color: purpleColor, fontSize: 14),
                          textAlign: TextAlign.left,
                        ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      if (product.descuento)
                        Text(
                          '\$${formatter.format(product.precio)}',
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough),
                          textAlign: TextAlign.left,
                        ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.0336,
              ),
              Text(
                product.descripcion,
                style: GoogleFonts.nunito(color: purpleColor, fontSize: 15),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
              ),
              SizedBox(
                height: size.height * 0.0236,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        if (productProvider.counter != 0) {
                          productProvider.counter--;
                        }
                      },
                      icon: Icon(
                        Icons.remove,
                        color: pinkColor,
                      )),
                  Text(
                    productProvider.counter.toString(),
                    style: GoogleFonts.nunito(
                        color: purpleColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                      onPressed: () {
                        productProvider.counter++;
                      },
                      icon: Icon(
                        Icons.add,
                        color: pinkColor,
                      )),
                ],
              ),
              SizedBox(
                height: size.height * 0.0236,
              ),
              _ButtonsRow(
                size: size,
                pinkColor: pinkColor,
                purpleColor: purpleColor,
                product: product,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ButtonsRow extends StatelessWidget {
  const _ButtonsRow({
    Key? key,
    required this.size,
    required this.pinkColor,
    required this.purpleColor,
    required this.product,
  }) : super(key: key);

  final Size size;
  final Color pinkColor;
  final Color purpleColor;
  final KnowMoreDiscountsModelData product;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);
    return Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ActionButton(
            size: size,
            pinkColor: pinkColor,
            purpleColor: Colors.white,
            title: 'Cancelar',
            onPressed: () {
              Navigator.of(context).pop();
              productProvider.counter = 1;
            },
          ),
          Expanded(
            child: ActionButton(
              size: size,
              pinkColor: pinkColor,
              purpleColor: Colors.white,
              title: 'Agregar al carrito',
              onPressed: () {
                if (productProvider.counter != 0) {
                  product.cantidad = productProvider.counter;
                  orderProvider.addProduct(product);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderCartScreen(),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
