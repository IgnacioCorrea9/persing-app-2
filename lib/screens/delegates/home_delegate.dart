// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persing/core/ResponsiveDesign/responsive_design.dart';
import 'package:persing/models/fetchRewardsByUser_model.dart';
import 'package:persing/providers/publicacion.dart';
import 'package:persing/providers/recompensa.dart';
import 'package:persing/screens/publicaciones/see_products_screen.dart';
import 'package:provider/provider.dart';

class Delegate extends SliverPersistentHeaderDelegate {
  final String userId;
  // ignore: unused_field, close_sinks
  late StreamController<List<FetchRewardsByUserData>> _rewardsStream;

  Delegate(this.userId);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    Provider.of<Publicacion>(context, listen: false).toggleLikeDestacados();
    return SizedBox.expand(
      child: GestureDetector(
        onTap: () {},
        child: _ScoreBar(),
      ),
    );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class _ScoreBar extends StatefulWidget {
  const _ScoreBar();

  @override
  State<_ScoreBar> createState() => _ScoreBarState();
}

class _ScoreBarState extends State<_ScoreBar> {
  @override
  void initState() {
    Provider.of<Recompensa>(context, listen: false).fetchScoreByUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveDesign(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SeeProductosScreen(
              sectorId: '',
            ),
          ),
        );
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              gradient: LinearGradient(
                colors: [Colors.pink[300]!, Colors.orange[200]!],
              ),
            ),
            margin: EdgeInsets.symmetric(
              horizontal: responsive.widthMultiplier(16),
              vertical: 16,
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    'assets/images/empresas/cara-persing.svg',
                    color: Colors.white,
                    width: responsive.widthMultiplier(70),
                    semanticsLabel: 'Acme Logo',
                  ),
                ),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                        'Calificación Persing: ${Provider.of<Recompensa>(context).persingScore}', //
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.widthMultiplier(16),
                  ),
                  child: Icon(
                    FontAwesomeIcons.chevronRight,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
