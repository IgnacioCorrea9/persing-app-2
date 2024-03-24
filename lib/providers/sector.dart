import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:persing/core/config.dart';
import 'package:persing/core/storage/token_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Sector with ChangeNotifier {
  late List<Map<String, dynamic>> _sectores;
  late String _token;

  Map<String, String> get headers =>
      {"Authorization": _token, 'Content-Type': 'application/json'};

  final _localURL = 'https://develop-persing.imagineapps.co/api/sector/';

  List<Map<String, dynamic>> get sectores {
    return _sectores;
  }

  Future<List<Map<String, dynamic>>> fetchSectores() async {
    _token = await TokenStorage.get().gett();
    final response = await http.get(
        Uri.parse(Config.localTesting ? Config.sectorUrl : _localURL),
        headers: headers);
    final decoded = json.decode(response.body);
    if (response.statusCode != 200) {
      throw FlutterError(decoded["error"]);
    }

    List<Map<String, dynamic>> list = <Map<String, dynamic>>[];
    if (decoded != null) {
      final asList = decoded["data"] as List;
      for (int i = 0; i < asList.length; i++) {
        list.add(asList[i] as Map<String, dynamic>);
      }
    }
    return list;
  }

  Future<void> saveFilters(List<String> newFilters) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _token = await TokenStorage.get().gett();
      await prefs.remove("filters");
      prefs.setString("filters", jsonEncode(newFilters));
    } catch (error) {
      throw FlutterError(error.toString());
    }
  }
}
