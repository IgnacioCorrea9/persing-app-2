import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persing/core/colors.dart';

/// Show error dialog on products screen
void showErrorDialog(BuildContext context, String message) {
  String imgUrl = "assets/images/empresas/estado-vacio-pink.png";
  showDialog(
    context: context,
    builder: (ctx) => Center(
      child: Container(
        height: 530,
        child: AlertDialog(
          title: Text(
            "Producto no disponible",
            style: TextStyle(
              color: primaryColor,
              fontSize: 16,
            ),
          ),
          content: Column(
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF0094),
                  ),
                  onPressed: Navigator.of(ctx).pop,
                  child: Text('¡Entendido!',
                      style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
