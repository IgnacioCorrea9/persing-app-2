// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/models/know_more/know_more_discounts_model.dart';
import 'package:persing/screens/orders/provider/order_provider.dart';
import 'package:persing/screens/orders/ui/ordercart_screen.dart';
import 'package:persing/screens/products/provider/product_provider.dart';
import 'package:provider/provider.dart';

emptyCartDialog(BuildContext context, KnowMoreDiscountsModelData product) {
  Size size = MediaQuery.of(context).size;

  return showDialog(
      context: context,
      builder: (context) {
        final orderProvider = Provider.of<OrderProvider>(context);
        final productProvider = Provider.of<ProductProvider>(context);
        return AlertDialog(
            insetPadding: EdgeInsets.all(10),
            content: Container(
                width: size.width * 0.7,
                height: size.height * 0.22,
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Actualmente tienes artículos en tu carrito",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: primaryColor)),
                      SizedBox(height: size.height * 0.013),
                      Text(
                          "¿Deseas eliminar los artículos anteriores y continuar?",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: primaryColor)),
                      SizedBox(height: size.height * 0.017),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 9, left: 18, right: 19),
                                primary: Colors.white,
                              ),
                              child: Text(
                                "Cancelar",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                orderProvider.cart.clear();
                                product.cantidad = productProvider.counter;
                                orderProvider.addProduct(product);
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OrderCartScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xffFF0094),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 9, left: 18, right: 19),
                              ),
                              child: Text("Confirmar",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )));
      });
}
