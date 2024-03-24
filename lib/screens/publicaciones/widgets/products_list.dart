import 'package:flutter/material.dart';
import 'package:persing/models/sector_by_id_model.dart';
import 'package:persing/screens/publicaciones/widgets/product_card.dart';

//// Products list shown on SeeProducts screen
class ProductsList extends StatelessWidget {
  /// Constructor
  const ProductsList({
    key,
    required this.posts,
  }) : super(key: key);

  /// Products list to show
  final List<SectorByIdData> posts;
  @override
  Widget build(BuildContext context) {
    final half = (posts.length / 2).ceil();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: Column(
            children: List.generate(
              half,
              (index) => ProductCard(
                productData: posts[index],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Column(
            children: List.generate(
              (posts.length - half),
              (index) => ProductCard(
                productData: posts[half + index],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
