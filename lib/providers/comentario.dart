import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:persing/core/config.dart';
import 'package:persing/core/storage/token_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Comentario with ChangeNotifier {
  late List<Map<String, dynamic>> _comentarios;
  late String _token;
  Map<String, String> get headers =>
      {"Authorization": _token, 'Content-Type': 'application/json'};

  final _localURL = 'https://develop-persing.imagineapps.co/api/comentario/';

  List<Map<String, dynamic>> get comentarios {
    return _comentarios;
  }

  Future<List<Map<String, dynamic>>> fetchComments(String postId) async {
    _token = await TokenStorage.get().gett();
    await TokenStorage.get().gett();

    final response = await http.get(
        Uri.parse(Config.localTesting
            ? Config.comentUrl + 'publicacion/$postId'
            : _localURL + 'publicacion/$postId'),
        headers: headers);
    final decoded = json.decode(response.body);
    if (response.statusCode != 200) {
      throw FlutterError(decoded["error"]);
    }
    List<Map<String, dynamic>> list = <Map<String, dynamic>>[];
    if (decoded != null) {
      final asList = decoded as List;
      for (int i = 0; i < asList.length; i++) {
        list.add(asList[i] as Map<String, dynamic>);
      }
    }
    return list;
  }

  Future<String> fetchScoreByUser(String userId) async {
    String ranking = '';
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token')!;
    final response = await http.get(
        Uri.parse(Config.localTesting
            ? '${Config.localApiUrl}api/recompensa/ranking/user/$userId'
            : '${Config.apiUrl}recompensa/ranking/user/$userId'),
        headers: headers);
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      notifyListeners();
      double score = (double.parse(decoded['totalScore'].toString()));
      if (score <= 3) {
        ranking = 'Novato';
      }
      if (score > 3 && score <= 5) {
        ranking = 'Aprendiz';
      }
      if (score > 5 && score <= 7) {
        ranking = 'Conocedor';
      }
      if (score > 7 && score <= 9) {
        ranking = 'Experto';
      }
      if (score > 9) {
        ranking = 'Maestro';
      }
    }
    return ranking;
  }

  Future<void> postComment(
      String postId, String comment, bool isDestacado) async {
    final prefs = await SharedPreferences.getInstance();
    _token = await TokenStorage.get().gett();
    final userId = prefs.getString("userId");
    final data = jsonEncode({
      "publicacion": postId,
      "usuario": userId,
      "comentario": comment,
      "isDestacado": isDestacado
    });
    final response = await http.post(
        Uri.parse(Config.localTesting ? Config.comentUrl : _localURL),
        body: data,
        headers: headers);
    final decoded = json.decode(response.body);
    if (response.statusCode != 201) {
      throw FlutterError(decoded["error"]);
    }
  }
}
