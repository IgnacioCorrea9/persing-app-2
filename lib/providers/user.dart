import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:persing/core/config.dart';
import 'package:persing/core/storage/token_storage.dart';
import 'package:persing/screens/profile/models/profile_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User with ChangeNotifier {
  late Map<String, dynamic> _user;
  late String _token;

  Map<String, String> get headers =>
      {"Authorization": _token, 'Content-Type': 'application/json'};

  final _localURL = 'https://develop-persing.imagineapps.co/api/user/';

  Map<String, dynamic> get user {
    return _user;
  }

  Future<ProfileDataModel> fetchUser() async {
    final prefs = await SharedPreferences.getInstance();
    _token = await TokenStorage.get().gett();
    final userId = prefs.getString("userId");
    final response = await http.get(
        Uri.parse(Config.localTesting
            ? Config.userUrl + '$userId'
            : '$_localURL$userId'),
        headers: headers);

    final decoded = json.decode(response.body) as Map<String, dynamic>;
    if (response.statusCode != 200) {
      throw FlutterError(decoded["error"]);
    }
    _user = decoded["data"];
    final jsonResponse = json.decode(response.body);
    final services = jsonResponse;
    final servicesToReturn = ProfileDataModel.fromJson(services);
    notifyListeners();
    return servicesToReturn;
  }

  Future<void> editUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    _token = await TokenStorage.get().gett();
    final userId = prefs.getString("userId");
    final encoded = json.encode(user);
    final response = await http.put(
        Uri.parse(Config.localTesting
            ? Config.userUrl + '$userId'
            : '$_localURL$userId'),
        body: encoded,
        headers: headers);
    final decoded = json.decode(response.body);
    if (response.statusCode != 200) {
      throw FlutterError(decoded["error"]);
    }
    _user = decoded;
    prefs.setString("interests", jsonEncode(decoded["intereses"]));
    prefs.setString("filters", jsonEncode(decoded["intereses"]));
    notifyListeners();
  }

  Future<void> changePassword(Map<String, dynamic> passwords) async {
    final prefs = await SharedPreferences.getInstance();
    _token = await TokenStorage.get().gett();
    final userId = prefs.getString("userId");
    final encoded = json.encode(passwords);
    final response = await http.put(
      Uri.parse(
        (Config.localTesting ? Config.userUrl : _localURL) + 'password/$userId',
      ),
      body: encoded,
      headers: headers,
    );
    final decoded = json.decode(response.body);
    if (response.statusCode != 200) {
      throw FlutterError(decoded["error"]);
    }
  }
}
