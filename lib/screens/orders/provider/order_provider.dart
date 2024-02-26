import 'package:flutter/material.dart';
import 'package:persing/models/know_more/know_more_discounts_model.dart';
import 'package:provider/provider.dart';

class OrderProvider with ChangeNotifier {
  static OrderProvider get(
    BuildContext context, {
    bool listen = false,
  }) {
    return Provider.of<OrderProvider>(
      context,
      listen: listen,
    );
  }

  List<KnowMoreDiscountsModelData> cart = [];

  void removeProduct(int index) {
    cart.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    cart.clear();
    notifyListeners();
  }

  void addProduct(KnowMoreDiscountsModelData product) {
    cart.add(product);
    notifyListeners();
  }

  int getTotal(int discount) {
    int total = 0;
    for (var i = 0; i < cart.length; i++) {
      if (cart[i].descuento) {
        total = (cart[i].precioDescuento * cart[i].cantidad!) + total;
      } else {
        total = (cart[i].precio * cart[i].cantidad!) + total;
      }
    }
    return total - discount;
  }

  int getDiscountTotal() {
    int discountTotal = 0;
    for (var i = 0; i < cart.length; i++) {
      if (cart[i].descuento) {
        discountTotal =
            ((cart[i].precio - cart[i].precioDescuento) * cart[i].cantidad!) +
                discountTotal;
      }
    }
    return discountTotal;
  }
}
