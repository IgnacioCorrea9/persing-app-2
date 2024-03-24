import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persing/core/ResponsiveDesign/responsive_design.dart';
import 'package:persing/core/colors.dart';

/// Filter card shown on filterSections
class FilterCard extends StatelessWidget {
  /// Constructor
  const FilterCard({
    super.key,
    required this.elementIndex,
    required this.image,
    required this.text,
    required this.onTap,
    required this.selected,
  });

  /// Filter index on filters screen
  final int elementIndex;

  /// To show if filter is selected or not
  final bool selected;

  /// Callback on widget tap.
  final VoidCallback onTap;

  /// Image to show in widget
  final String image;

  /// Text to show on element.
  final String text;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveDesign(context);
    return InkWell(
      key: Key('id' + elementIndex.toString()),
      onTap: onTap,
      child: Container(
        height: 100,
        width: responsive.widthMultiplier(170),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.symmetric(
          vertical: 6,
          horizontal: responsive.widthMultiplier(8),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? Color(0xFFFF0094) : Colors.white,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[50]!,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 4,
              child: CircleAvatar(
                backgroundColor:
                    Color(0xFFFFF1D5), //snapshot.data[i]['sector']['nombre']
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: FadeInImage(
                    placeholder: CachedNetworkImageProvider(
                      'https://www.icegif.com/wp-content/uploads/loading-icegif-1.gif',
                    ),
                    image: CachedNetworkImageProvider(
                      image,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.only(
                  top: 6.0,
                ),
                alignment: Alignment.center,
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
