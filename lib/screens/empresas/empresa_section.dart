import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persing/core/ResponsiveDesign/responsive_design.dart';

class EmpresaSection extends StatefulWidget {
  final String logoUrl;
  final String name;
  final String type;
  EmpresaSection(
      {Key? key, required this.logoUrl, required this.name, required this.type})
      : super(key: key);

  @override
  _EmpresaSectionState createState() =>
      _EmpresaSectionState(this.logoUrl, this.name, this.type);
}

class _EmpresaSectionState extends State<EmpresaSection> {
  late String logoUrl;
  late String name;
  late String type;
  late ResponsiveDesign _responsiveDesign;

  _EmpresaSectionState(this.logoUrl, this.name, this.type);

  @override
  Widget build(BuildContext context) {
    _responsiveDesign = ResponsiveDesign(context);

    String imgUrl =
        "https://cdn.icon-icons.com/icons2/1154/PNG/512/1486564400-account_81513.png";
    return Container(
      width: _responsiveDesign.widthMultiplier(200),
      padding: EdgeInsets.only(
          left: _responsiveDesign.widthMultiplier(16.0),
          right: _responsiveDesign.widthMultiplier(16.0),
          top: _responsiveDesign.heightMultiplier(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
              height: _responsiveDesign.heightMultiplier(90),
              alignment: Alignment.center,
              width: _responsiveDesign.widthMultiplier(166),
              image: CachedNetworkImageProvider(logoUrl ?? imgUrl),
              fit: BoxFit.contain,
              placeholder: CachedNetworkImageProvider(
                'https://www.icegif.com/wp-content/uploads/loading-icegif-1.gif',
              ),
            ),
          ),
          Text(
            name ?? '',
            style: TextStyle(fontSize: 14),
          ),
          Text(
            type,
            style: TextStyle(color: Color(0xFF707070), fontSize: 14),
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
