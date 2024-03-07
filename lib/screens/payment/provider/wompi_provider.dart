import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uuid/uuid.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WompiProvider with ChangeNotifier {
  late WebViewController webController;

  bool _succeed = false;
  bool get succeed => _succeed;
  set succeed(bool value) {
    _succeed = value;
    notifyListeners();
  }

  Future<String> getTransactionId(String response) async {
    final String transactionId = response.replaceAll(
        'https://transaction-redirect.wompi.co/check?id=', '');
    print(transactionId);
    return transactionId;
  }

  void loadHtml(
    String total, {
    required String reference,
  }) async {
    reference ??= Uuid().v4();
    final key = dotenv.env['WOMPI_PROD_KEY'];

    final String html = """
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style type="text/css">
      .body {
        background-color: transparent;
      }
      .parent {
        margin-top: 300px;
        background-color: transparent;
        display: flex;
        align-items: center;
        justify-content: center;
      }
    </style>
  </head>
  <body>
    <div class="parent">
      <form>
        <script
          src="https://checkout.wompi.co/widget.js"
          data-render="button"
          data-public-key="$key"
          data-currency="COP"
          data-amount-in-cents="$total"
          data-reference= "$reference",
        ></script>
      </form>
    </div>
  </body>
</html>
""";

    final String url = Uri.dataFromString(html,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString();

    webController.loadRequest(Uri.parse(url));
  }
}
