import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:persing/core/config.dart';
import 'package:persing/core/storage/token_storage.dart';
import 'package:persing/models/publicaciones_saved_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Publicacion with ChangeNotifier {
  late List<Map<String, dynamic>> _publicaciones;
  late String _token;

  Map<String, String> get headers =>
      {"Authorization": _token, 'Content-Type': 'application/json'};

  final _localURL = 'https://develop-persing.imagineapps.co/api/publicacion/';
  final _localURLDestacados =
      'https://develop-persing.imagineapps.co/api/destacado/';
  // final _localURL = 'https://develop-persing.imagineapps.co/api/publicacion/';

  List<Map<String, dynamic>> get publicaciones {
    return _publicaciones;
  }

  int _maxPosts = 10;
  int get maxPosts => _maxPosts;
  set maxPosts(int value) {
    _maxPosts = value;
    notifyListeners();
  }

  var _count = 0;
  int get getCounter {
    return _count;
  }

  Future<List<Map<String, dynamic>>> fetchPosts(String search) async {
    final prefs = await SharedPreferences.getInstance();
    _token = await TokenStorage.get().gett();
    final userId = prefs.getString("userId");
    var response;
    if (search == "") {
      response = await http.get(
          Uri.parse(Config.localTesting
              ? Config.postUrl + 'user/$userId'
              : _localURL + 'user/$userId'),
          headers: headers);
    } else {
      response = await http.get(
          Uri.parse(Config.localTesting
              ? Config.postUrl + 'user/$userId?search=$search'
              : _localURL + 'user/$userId?search=$search'),
          headers: headers);
    }
    final decoded = json.decode(response.body);
    if (response.statusCode != 200) {
      throw FlutterError(decoded["error"]);
    }
    final asList = decoded;
    List<Map<String, dynamic>> list = <Map<String, dynamic>>[];
    for (int i = 0; i < asList.length; i++) {
      list.add(asList[i] as Map<String, dynamic>);
    }
    return list;
  }

  Future<List<Map<String, dynamic>>> fetchHighlightedPosts(
      String search) async {
    final prefs = await SharedPreferences.getInstance();
    _token = await TokenStorage.get().gett();
    final userId = prefs.getString("userId");
    var response;
    if (search == "") {
      response = await http.get(
          Uri.parse(Config.localTesting
              ? Config.postUrl + 'destacadas/user/$userId'
              : _localURL + 'destacadas/user/$userId'),
          headers: headers);
    } else {
      response = await http.get(
          Uri.parse(Config.localTesting
              ? Config.postUrl + 'destacadas/user/$userId?search=$search'
              : _localURL + 'destacadas/user/$userId?search=$search'),
          headers: headers);
    }
    final decoded = json.decode(response.body);
    if (response.statusCode != 200) {
      throw FlutterError(decoded["error"]);
    }
    final asList = decoded as List;
    List<Map<String, dynamic>> list = <Map<String, dynamic>>[];
    for (int i = 0; i < asList.length; i++) {
      list.add(asList[i] as Map<String, dynamic>);
    }
    return list;
  }

  Future<List<PublicacionesSavedData>> fetchSavedPost() async {
    final prefs = await SharedPreferences.getInstance();
    _token = await TokenStorage.get().gett();
    final userId = prefs.getString("userId");
    http.Response res = await http.get(
        Uri.parse(Config.localTesting
            ? Config.postUrl + 'guardado/$userId'
            : _localURL + 'guardado/$userId'),
        headers: headers);
    if (res.statusCode == 200) {
      final jsonResponse = jsonDecode(res.body);
      PublicacionesSavedModel publicacionesSaved =
          new PublicacionesSavedModel.fromJson(jsonResponse);
      return publicacionesSaved.data;
    } else {
      throw "Error al cargar las empresas";
    }
  }

  Future<void> toggleLikeDestacados() async {
    final prefs = await SharedPreferences.getInstance();
    _token = await TokenStorage.get().gett();
    final userId = prefs.getString("userId");
    final response = await http.get(
        Uri.parse(Config.localTesting
            ? Config.rewardPostUrl + '$userId'
            : 'https://develop-persing.imagineapps.co/api/recompensa/user/$userId'),
        headers: headers);
    try {
      final decoded = json.decode(response.body);
      if (response.statusCode != 200) {
        throw FlutterError(decoded["error"]);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> toggleLikeDestacado(
      String postId, String type, bool seccion) async {
    final prefs = await SharedPreferences.getInstance();
    _token = await TokenStorage.get().gett();
    final userId = prefs.getString("userId");
    final data = {"user": userId, "type": type};
    final response = await http.put(
        Uri.parse(seccion
            ? Config.localTesting
                ? Config.postDestacadoUrl + 'toggle-like/$postId'
                : _localURLDestacados + 'toggle-like/$postId'
            : Config.localTesting
                ? Config.postUrl + 'toggle-like/$postId'
                : _localURL + 'toggle-like/$postId'),
        body: jsonEncode(data),
        headers: headers);

    final decoded = json.decode(response.body);

    if (response.statusCode != 200) {
      throw FlutterError(decoded["error"]);
    }
  }

  Future<void> toggleLike(String postId, String type) async {
    final prefs = await SharedPreferences.getInstance();
    _token = await TokenStorage.get().gett();
    final userId = prefs.getString("userId");
    final data = {"user": userId, "type": type};
    final response = await http.put(
        Uri.parse(Config.localTesting
            ? Config.postUrl + 'toggle-like/$postId'
            : _localURL + 'toggle-like/$postId'),
        body: jsonEncode(data),
        headers: headers);

    final decoded = json.decode(response.body);

    if (response.statusCode != 200) {
      throw FlutterError(decoded["error"]);
    }
  }

  Future<void> addView(String postId) async {
    _token = await TokenStorage.get().gett();
    final response = await http.put(
        Uri.parse(Config.localTesting
            ? Config.postUrl + 'add-view/$postId'
            : _localURL + 'add-view/$postId'),
        headers: headers);

    final decoded = json.decode(response.body);

    updateCpm(postId);

    if (response.statusCode != 200) {
      throw FlutterError(decoded["error"]);
    }
  }

  Future<void> addInteraction(String postId) async {
    _token = await TokenStorage.get().gett();
    final response = await http.put(
        Uri.parse(Config.localTesting
            ? Config.postUrl + 'interaction/$postId'
            : _localURL + 'interaction/$postId'),
        headers: headers);

    final decoded = json.decode(response.body);

    if (response.statusCode != 200) {
      throw FlutterError(decoded["error"]);
    }
  }

  Future<void> adClicked(String postId) async {
    _token = await TokenStorage.get().gett();
    final response = await http.put(
        Uri.parse(Config.localTesting
            ? Config.postUrl + 'ad-clicked/$postId'
            : _localURL + 'ad-clicked/$postId'),
        headers: headers);

    final decoded = json.decode(response.body);

    updateCtr(postId);
    updateCpc(postId);

    if (response.statusCode != 200) {
      throw FlutterError(decoded["error"]);
    }
  }

  Future<void> ignoredPost(String postId) async {
    _token = await TokenStorage.get().gett();
    final response = await http.put(
        Uri.parse(Config.localTesting
            ? Config.postUrl + 'ignored/$postId'
            : _localURL + 'ignored/$postId'),
        headers: headers);

    final decoded = json.decode(response.body);

    if (response.statusCode != 200) {
      throw FlutterError(decoded["error"]);
    }
  }

  Future<void> updateEngagement(String postId) async {
    _token = await TokenStorage.get().gett();
    final response = await http.put(
        Uri.parse(Config.localTesting
            ? Config.postUrl + 'engagement/$postId'
            : _localURL + 'engagement/$postId'),
        headers: headers);

    final decoded = json.decode(response.body);

    if (response.statusCode != 200) {
      throw FlutterError(decoded["error"]);
    }
  }

  Future<void> updateCtr(String postId) async {
    _token = await TokenStorage.get().gett();
    final response = await http.put(
        Uri.parse(Config.localTesting
            ? Config.postUrl + 'ctr-calculation/$postId'
            : _localURL + 'ctr-calculation/$postId'),
        headers: headers);

    final decoded = json.decode(response.body);

    if (response.statusCode != 200) {
      throw FlutterError(decoded["error"]);
    }
  }

  Future<void> updateVtr(String postId) async {
    _token = await TokenStorage.get().gett();
    final response = await http.put(
        Uri.parse(Config.localTesting
            ? Config.postUrl + 'vtr-calculation/$postId'
            : _localURL + 'vtr-calculation/$postId'),
        headers: headers);

    final decoded = json.decode(response.body);

    if (response.statusCode != 200) {
      throw FlutterError(decoded["error"]);
    }
  }

  Future<void> updateCpm(String postId) async {
    _token = await TokenStorage.get().gett();
    final response = await http.put(
        Uri.parse(Config.localTesting
            ? Config.postUrl + 'cpm-calculation/$postId'
            : _localURL + 'cpm-calculation/$postId'),
        headers: headers);

    final decoded = json.decode(response.body);
    if (response.statusCode != 200) {
      throw FlutterError(decoded["error"]);
    }
  }

  Future<void> updateCpc(String postId) async {
    _token = await TokenStorage.get().gett();
    final response = await http.put(
        Uri.parse(Config.localTesting
            ? Config.postUrl + 'cpc-calculation/$postId'
            : _localURL + 'cpc-calculation/$postId'),
        headers: headers);

    final decoded = json.decode(response.body);

    if (response.statusCode != 200) {
      throw FlutterError(decoded["error"]);
    }
  }

  Future<void> toggleSave(String postId, String type) async {
    final prefs = await SharedPreferences.getInstance();
    _token = await TokenStorage.get().gett();
    final userId = prefs.getString("userId");

    final data = {"user": userId, "type": type};
    final response = await http.put(
        Uri.parse(Config.localTesting
            ? Config.postUrl + 'toggle-save/$postId'
            : '$_localURL' + 'toggle-save/$postId'),
        body: jsonEncode(data),
        headers: headers);
    final decoded = json.decode(response.body);
    if (response.statusCode != 200) {
      throw FlutterError(decoded["error"]);
    }
  }
}
