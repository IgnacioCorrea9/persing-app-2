import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:persing/core/config.dart';
import 'package:persing/core/storage/token_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  static Auth get(
    BuildContext context, {
    bool listen = false,
  }) {
    return Provider.of<Auth>(
      context,
      listen: listen,
    );
  }

  late String _token;
  late String _userId;
  late String error;

  void updateUserInfo(String userId, String token) {
    _userId = userId;
    _token = token;
    notifyListeners();
  }

  void clearUserInfo() {
    _userId = "";
    _token = "";
    notifyListeners();
  }

  /// Local url
  final _localURL = 'https://develop-persing.imagineapps.co/users';

  /// Headers
  Map<String, String> get headers => {
        "Content-Type": "application/json",
      };

  /// Getter for is authenticated
  bool get isAuth {
    return _token.isNotEmpty;
  }

  /// Token getter
  String get token {
    return _token;
  }

  String get userId {
    return _userId;
  }

  setUserId(String value) {
    _userId = value;
    notifyListeners();
  }

  /// Signs up the user
  /// Receives the user map
  /// Returns void
  Future<Map<String, dynamic>> signUp(Map<String, dynamic> user) async {
    var encoded = json.encode(user);
    final response = await http.post(
        Uri.parse(Config.localTesting
            ? Config.usersUrl + '/register'
            : _localURL + '/register'),
        body: encoded,
        headers: headers);
    final decoded = json.decode(response.body) as Map<String, dynamic>;
    if (response.statusCode != 201) {
      throw FlutterError(decoded["error"]);
    }
    final registered = decoded["user"] as Map<String, dynamic>;
    return registered;
  }

  /// Logs in the user in the app and sets token and information in storage.
  /// Receives email and password
  Future<void> logIn(String email, String password) async {
    Map<String, String> data = {"email": email, "password": password};
    var encoded = json.encode(data);
    final response = await http.post(
        Uri.parse(Config.localTesting
            ? Config.usersUrl + '/authenticate'
            : _localURL + '/authenticate'),
        body: encoded,
        headers: headers);
    final decoded = json.decode(response.body);
    final prefs = await SharedPreferences.getInstance();
    if (response.statusCode != 200) {
      error = decoded["error"];
      prefs.setString("token", '');
      throw FlutterError(
        "Credenciales inválidas",
      );
    }
    if (response.statusCode == 200) {
      final userType = decoded["user"]["tipo"];
      if (userType != "consumidor") {
        throw FlutterError("No pueden iniciar sesión en esta app");
      } else {
        prefs.setString("token", decoded["token"]);
        updateUserInfo(decoded["token"], decoded["user"]["_id"]);
        prefs.setString("token", _token);
        prefs.setString("userId", _userId);
        prefs.setString("interests", jsonEncode(decoded["user"]["intereses"]));
        prefs.setString("filters", jsonEncode(decoded["user"]["intereses"]));
        notifyListeners();
      }
    }
  }

  Future<List<String>> getActiveInterests() async {
    final prefs = await SharedPreferences.getInstance();
    final extracted =
        jsonDecode(prefs.getString("interests")!) as List<dynamic>;
    List<String> list = <String>[];
    extracted.forEach((element) {
      list.add(element.toString());
    });
    return list;
  }

  Future<List<String>> getActiveFilters() async {
    final prefs = await SharedPreferences.getInstance();
    final extracted = jsonDecode(prefs.getString("filters")!) as List<dynamic>;
    List<String> list = <String>[];
    extracted.forEach((element) {
      list.add(element.toString());
    });
    return list;
  }

  /// Tries auto login after the user closes the app and launches it again
  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("token") || !prefs.containsKey("userId")) {
      return false;
    }

    TokenStorage.get().setSharedPrefrence(prefs);

    updateUserInfo(await TokenStorage.get().gett(), prefs.getString("userId")!);
    notifyListeners();
    return true;
  }

  /// Logs out of the app and clears storage
  void logOut() async {
    clearUserInfo();
    final prefs = await SharedPreferences.getInstance();
    TokenStorage.get().clearPrefs();
    prefs.clear();
    notifyListeners();
  }

  Future<bool> recoverPassword(String email) async {
    try {
      Map<String, String> data = {"email": email};
      var encoded = json.encode(data);
      final response = await http
          .post(
              Uri.parse(Config.localTesting
                  ? Config.usersUrl + '/forgot-password'
                  : _localURL + '/forgot-password'),
              body: encoded,
              headers: headers)
          .timeout(Duration(seconds: 10));
      if (response.statusCode != 200) {
        throw FlutterError("El usuario no se ha encontrado.");
      }
      return true;
    } on TimeoutException {
      throw FlutterError(
          "El servidor tardó demasiado en responder, intentalo más tarde.");
    } catch (error) {
      throw FlutterError(error.toString());
    }
  }

  Future<bool> verifyEmail(String email) async {
    try {
      Map<String, String> data = {"email": email};
      var encoded = json.encode(data);
      final response = await http
          .post(
              Uri.parse(Config.localTesting
                  ? Config.usersUrl + '/verify-email'
                  : _localURL + '/verify-email'),
              body: encoded,
              headers: headers)
          .timeout(Duration(seconds: 10));
      final decoded = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw FlutterError(decoded["message"]);
      } else {
        if (!decoded["success"]) {
          throw FlutterError("El email ya está registrado");
        }
      }
      return true;
    } on TimeoutException {
      throw FlutterError(
          "El servidor tardó demasiado en responder, intentalo más tarde.");
    } catch (error) {
      throw FlutterError(error.toString());
    }
  }
}
