import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persing/models/sector_by_id_model.dart';
import 'package:persing/repository/repository.dart';
import 'package:persing/screens/products/ui/product_detail.dart';
import 'package:persing/utils/text_formatting.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Card to show product info on products list widget
class ProductCard extends StatefulWidget {
  /// Constructor
  const ProductCard({
    key,
    required this.productData,
    this.fontSize = 14,
  }) : super(key: key);

  /// Product data to show
  final SectorByIdData productData;

  /// FontSize to use
  final double fontSize;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  /// Current user id
  late String userId;
  Repository _httpService = Repository();

  /// Used to expand text section on widget
  final ValueNotifier<double> _widgetHeight = ValueNotifier(302.0);

  final ValueNotifier<bool> _expanded = ValueNotifier(false);

  /// Method to get user id from shared preferences
  Future<void> getUserId() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      userId = preferences.getString("userId")!;
    });
  }

  @override
  void initState() {
<<<<<<< HEAD
    userId = "";
    getUserId();
    super.initState();
=======
    super.initState();
    getUserId();
>>>>>>> main
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    int maxLines = 3;

    return GestureDetector(
      onTap: () {
        _httpService.getProductoIntereses(widget.productData.id, userId);
        final productData = widget.productData.buildDetailModel();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              product: productData,
            ),
          ),
        );
      },
      child: ValueListenableBuilder(
        valueListenable: _widgetHeight,
        builder: (BuildContext context, double value, Widget? child) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey,
                width: 0.2,
              ),
            ),
            margin: EdgeInsets.only(
              bottom: 8,
              left: 4,
              right: 4,
              top: 1,
            ),
            height: value,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: widget.productData.foto,
                  height: 150,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(primaryColor),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.productData.titulo,
                            style: TextStyle(
                              fontSize: widget.fontSize,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                          ),
                          Text(
                            TextFormatting.getFormattedCurrency(
                              widget.productData.precio,
                            ),
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            flex: 2,
                            child: ValueListenableBuilder(
                              valueListenable: _expanded,
                              builder: (BuildContext context, bool value2,
                                  Widget? child) {
                                return LayoutBuilder(
                                  builder: (context, size) {
                                    // Build the textSpan

                                    var span = TextSpan(
                                      text: widget.productData.descripcion,
                                      style: TextStyle(
                                        fontSize: widget.fontSize,
                                      ),
                                    );

                                    // Use a textPainter to determine if it will exceed max lines
                                    var tp = TextPainter(
                                      maxLines: maxLines,
                                      textAlign: TextAlign.justify,
                                      textDirection: TextDirection.ltr,
                                      text: span,
                                    );

                                    // trigger it to layout
                                    tp.layout(maxWidth: size.maxWidth);

                                    // whether the text overflowed or not
                                    var exceeded = tp.didExceedMaxLines;

                                    final text = Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text.rich(
                                          span,
                                          maxLines: exceeded
                                              ? maxLines - 1
                                              : maxLines,
                                          textAlign: TextAlign.justify,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        if (exceeded && !value2)
                                          InkWell(
                                            onTap: () {
                                              double height =
                                                  _widgetHeight.value;
                                              bool exceed = true;

                                              /// If text overflow
                                              while (exceed) {
                                                // Use a textPainter to determine if it will exceed max lines
                                                var tp = TextPainter(
                                                  maxLines: maxLines,
                                                  textAlign: TextAlign.justify,
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  text: span,
                                                );
                                                // trigger it to layout
                                                tp.layout(
                                                    maxWidth: size.maxWidth);

                                                if (tp.didExceedMaxLines) {
                                                  maxLines += 1;

                                                  /// Add height based on text maxLines
                                                  height +=
                                                      (widget.fontSize + 6.5);
                                                } else {
                                                  exceed = false;
                                                  _widgetHeight.value = height;
                                                }
                                              }
                                              _expanded.value = true;
                                            },
                                            child: Text(
                                              'Ver más',
                                              style: TextStyle(
                                                fontSize: widget.fontSize,
                                                color: primaryColor,
                                              ),
                                            ),
                                          )
                                      ],
                                    );
                                    if (value2) {
                                      return Scrollbar(
                                        child: SingleChildScrollView(
                                          child: text,
                                        ),
                                      );
                                    }
                                    return text;
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
