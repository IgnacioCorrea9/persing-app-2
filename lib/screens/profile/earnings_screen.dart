import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/models/fetchRewardsByUser_model.dart';
import 'package:persing/providers/user.dart';
import 'package:persing/screens/profile/how_win.dart';
import 'package:persing/screens/profile/interests_screen.dart';
import 'package:persing/screens/publicaciones/see_products_screen.dart';
import 'package:persing/widgets/custom_icons.dart';
import 'package:provider/provider.dart';
import 'package:persing/providers/recompensa.dart';
import '../../constants.dart';

class EarningsScreen extends StatefulWidget {
  EarningsScreen({Key? key}) : super(key: key);

  @override
  _EarningsScreenState createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  late StreamController<List<FetchRewardsByUserData>> _rewardsStream;
  late StreamController<Map<String, dynamic>> _userStream;

  _navigateInterests(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InterestsScreen(),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    _rewardsStream = StreamController<List<FetchRewardsByUserData>>();
    _userStream = StreamController<Map<String, dynamic>>();
    _loadRewards();
    _loadUser();
    super.didChangeDependencies();
  }

  void _loadUser() async {
    final pubsProvider = Provider.of<User>(context, listen: false);
    pubsProvider.fetchUser().then((_) {
      _userStream.add(pubsProvider.user);
    });
  }

  void _loadRewards() async {
    final pubsProvider = Provider.of<Recompensa>(context, listen: false);
    pubsProvider.fetchRewardsByUser().then((value) {
      _rewardsStream.add(value);
    });
  }

  Future<void> _onRefresh() async {
    final rewsProvider = Provider.of<Recompensa>(context, listen: false);
    setState(() {
      rewsProvider.fetchRewardsByUser().then((value) {
        _rewardsStream.add(value);
      });
    });
    final userProvider = Provider.of<User>(context, listen: false);
    userProvider.fetchUser().then((_) {
      _userStream.add(userProvider.user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10.3),
        child: Column(
          children: [
            _buildEarningsResume(),
            GestureDetector(
              onTap: () {
                _navigateInterests(context);
              },
              child: Container(
                margin: EdgeInsets.only(top: 9, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Intereses", style: TextStyle(fontSize: 16)),
                    Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              CustomIcons.setting,
                              size: 22,
                              color: primaryColor,
                            ),
                            SizedBox(width: 20),
                            Text(
                              "Editar",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            StreamBuilder(
                stream: _rewardsStream.stream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<FetchRewardsByUserData>> snapshot) {
                  if (snapshot.hasData) {
                    List<FetchRewardsByUserData> reward = snapshot.data!;

                    List<FetchRewardsByUserData> userReward = [];

                    for (var rewards in reward) {
                      if (rewards.sector != null) {
                        userReward.add(rewards);
                      }
                    }

                    return RefreshIndicator(
                        child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: userReward.length,
                          itemBuilder: (context, i) => _buildEarningsCard(
                              userReward[i].sector?.nombre ?? '',
                              userReward[i].creditos,
                              userReward[i].ranking.toString(),
                              userReward[i].sector?.icono ??
                                  "https://persing.s3.amazonaws.com/sector/GLcaCpaIr5Pd3YS.png",
                              context,
                              userReward[i].sector?.id ?? ""),
                        ),
                        onRefresh: _onRefresh);

                    //return Column(children: reward);
                  } else {
                    return Container();
                  }
                })
          ],
        ),
      )),
    );
  }

  Widget _buildEarningsResume() {
    return StreamBuilder(
      stream: _userStream.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final name = snapshot.data!["nombre"];
          final apellido = snapshot.data!["apellido"];
          dynamic earnings = (snapshot.data!["creditos"]);
          return Card(
              elevation: 5,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 85,
                        width: 50.0,
                        child: CircleAvatar(
                          backgroundColor: Color(0xFFFFF1D5),
                          child: Image.asset(
                            "assets/images/ganancias/ilustracion-creditos.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 10, right: 10, bottom: 10),
                        constraints: BoxConstraints(maxHeight: double.infinity),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name + " " + apellido,
                                style: TextStyle(
                                    color: Color(0xFF1C1C1C), fontSize: 20)),
                            Wrap(
                              children: [
                                Text(
                                  'Total de créditos ganados',
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Color(0xFF707070), fontSize: 14),
                                )
                              ],
                            ),
                            Wrap(
                              children: [
                                Text(
                                  "${formatter.format(earnings)}",
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Color(0xFF3B3B3B), fontSize: 16),
                                )
                              ],
                            ),
                            Wrap(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => HowWinWithPersing(),
                                    ),
                                  ),
                                  child: Text(
                                    '¿Cómo ganas con Persing?',
                                    softWrap: true,
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                  )
                ],
              ));
        } else {
          return Card(
            child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
                    backgroundColor: Colors.white,
                  ),
                )),
          );
        }
      },
    );
  }

  Widget _buildEarningsCard(
    String type,
    dynamic credits,
    String rank,
    String imgRoute,
    BuildContext context,
    String sector,
  ) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  height: 85,
                  width: 50.0,
                  child: CircleAvatar(
                    backgroundColor: Color(0xFFFFF1D5),
                    child: FadeInImage(
                      placeholder: CachedNetworkImageProvider(
                        'https://www.icegif.com/wp-content/uploads/loading-icegif-1.gif',
                      ),
                      image: CachedNetworkImageProvider(imgRoute),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(top: 10, right: 10, bottom: 10),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(type,
                          style: TextStyle(color: primaryColor, fontSize: 16)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            children: [
                              Text(
                                'Créditos',
                                softWrap: true,
                                style: TextStyle(
                                    color: Color(0xFF707070), fontSize: 14),
                              )
                            ],
                          ),
                          Text(
                            "${formatter.format(credits)}",
                            style: TextStyle(
                                color: Color(0xFF3B3B3B), fontSize: 16),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            children: [
                              Text(
                                'Ranking',
                                softWrap: true,
                                style: TextStyle(
                                    color: Color(0xFF707070), fontSize: 14),
                              )
                            ],
                          ),
                          Text(
                            "$rank",
                            style: TextStyle(
                                color: Color(0xFF3B3B3B), fontSize: 14),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SeeProductosScreen(
                                sectorId: sector,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Ver productos',
                          softWrap: true,
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )),
            )
          ],
        ));
  }
}
