import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:persing/core/config.dart';
import 'package:persing/models/discountbysector_model.dart';
import 'package:persing/models/fetchRewardsByUser_model.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/know_more/know_more_discounts_model.dart';

class Recompensa with ChangeNotifier {

  static Recompensa get(
    BuildContext context, {
    bool listen = false,
  }) {
    return Provider.of<Recompensa>(
      context,
      listen: listen,
    );
  }
  late List<Map<String, dynamic>> _publicaciones;
  final List<DiscountBySector> discountBySector = [];

  late String _token;

  /// Persing score
  double persingScore = 0;

  Map<String, String> get headers =>
      {'Authorization': _token, 'Content-Type': 'application/json'};

  final _localURL = 'https://develop-persing.imagineapps.co/api/recompensa/';

  List<Map<String, dynamic>> get publicaciones {
    return _publicaciones;
  }

  /// Return a unique list of sectors
  List<DiscountBySector> uniqueSectors() {
    var idSet = <String>{};
    var distinct = <DiscountBySector>[];
    for (var d in discountBySector) {
      if (idSet.add(d.sector)) {
        distinct.add(d);
      }
    }
    return distinct;
  }

  /// return total discount
  int totalDiscount() {
    int totalDiscount = 0;
    uniqueSectors().forEach((element) {
      totalDiscount += element.totalDiscount;
    });
    return totalDiscount;
  }

  Future<List<FetchRewardsByUserData>> fetchRewardsByUser() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token')!;
    final userId = prefs.getString('userId');
    final response = await http.get(
        Uri.parse(Config.localTesting
            ? Config.rewardUrl + 'user/$userId'
            : _localURL + 'user/$userId'),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      FetchRewardsByUserModel fetchRewards =
          new FetchRewardsByUserModel.fromJson(jsonResponse);
      return fetchRewards.data;
    } else {
      throw 'Error al cargar los fetchRewardsByUser';
    }
  }

  Future<void> fetchScoreByUser() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token')!;
    final userId = prefs.getString('userId');
    final response = await http.get(
        Uri.parse(Config.localTesting
            ? '${Config.localApiUrl}api/recompensa/ranking/user/$userId'
            : '${Config.apiUrl}recompensa/ranking/user/$userId'),
        headers: headers);
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      notifyListeners();
      persingScore =
          (double.parse(decoded['totalScore'].toString())).toPrecision(1);
    }
  }

  Future<int> getCreditsByUserBySector(String sectorId) async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token')!;
    final userId = prefs.getString('userId');
    final response = await http.get(
      Uri.parse(Config.localTesting
          ? '${Config.localApiUrl}api/recompensa/creditos_sector/user/$sectorId/$userId'
          : '${Config.apiUrl}recompensa/creditos_sector/user/$sectorId/$userId'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      return decoded['creditos'];
    } else {
      return 0;
    }
  }

  Future<void> saveWatchedTime(
      String postId, String sectorId, double watchedTime) async {
    if (watchedTime > 0.0) {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('token')!;
      final userId = prefs.getString('userId');
      final data = {
        'usuario': userId,
        'sector': sectorId,
        'tiempo': watchedTime,
        'publication': postId
      };
      // ignore: unused_local_variable
      final result = await http.post(
          Uri.parse(Config.localTesting
              ? Config.rewardUrl + 'watch-time'
              : _localURL + 'watch-time'),
          body: jsonEncode(data),
          headers: headers);
      fetchScoreByUser();
    }
  }

  Future<void> recordInteraction(
      String postId, String sectorId, String interaction) async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token')!;
    final userId = prefs.getString('userId');
    final data = {
      'usuario': userId,
      'sector': sectorId,
      'interaccion': interaction,
      'publication': postId
    };
    // ignore: unused_local_variable
    final res = await http.post(
      Uri.parse(Config.localTesting
          ? Config.rewardUrl + 'interaction'
          : _localURL + 'interaction'),
      body: jsonEncode(data),
      headers: headers,
    );
    fetchScoreByUser();
  }

  Future<int> getDiscountBySector(List<KnowMoreDiscountsModelData> cart) async {
    int total = 0;
    discountBySector.clear();
    for (var i = 0; i < cart.length; i++) {
      if (!discountBySector
          .any((element) => element.sector == cart[i].sector.id)) {
        discountBySector.add(
          DiscountBySector(
            sector: cart[i].sector.nombre,
            totalDiscount: await getCreditsByUserBySector(cart[i].sector.id),
          ),
        );
      }
    }
    for (var i = 0; i < discountBySector.length; i++) {
      total = discountBySector[i].totalDiscount + total;
    }
    return total;
  }
}
