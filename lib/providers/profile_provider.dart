import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:persing/core/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ProfileProvider with ChangeNotifier {
  late String _token;
  late String _userId;
  Map<String, String> get headers =>
      {"Authorization": _token, 'Content-Type': 'application/json'};

  TextEditingController _reviewTextController = TextEditingController();
  TextEditingController get reviewTextController => _reviewTextController;
  set changeReviewTextControllerValue(String value) {
    _reviewTextController.text = value;
    notifyListeners();
  }

  double _rating = 0;
  double get rating => _rating;
  set rating(double value) {
    _rating = value;
    notifyListeners();
  }

  Future<bool> verifyFeedbackForm(BuildContext ctx) async {
    try {
      if (_rating == 0) {
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text(
            "Por favor ingresa una calificación",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
        return false;
      } else {
        if (_reviewTextController.text.isEmpty) {
          ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
            content: Text(
              "Por favor ingresa un comentario",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ));
          return false;
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> postFeedback(double rating, String comment) async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token')!;
    _userId = prefs.getString('userId')!;

    final data = json
        .encode({"usuario": _userId, "comentario": comment, "rating": rating});

    final resp = await http.post(
        Uri.parse(
            Config.localTesting ? Config.localFeedbackUrl : Config.feedbackUrl),
        body: data,
        headers: headers);
    final decoded = json.decode(resp.body);
    reviewTextController.clear();
    rating = 0;
    if (resp.statusCode != 201) {
      throw FlutterError(decoded["error"]);
    }
  }
}
