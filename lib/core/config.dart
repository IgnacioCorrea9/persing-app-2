import 'dart:io';

class Config {
  static bool localTesting = false;

  static String apiUrl = 'https://develop-persing.imagineapps.co/api/';

  static const String wompiUrl = 'https://sandbox.wompi.co/v1';
  // static const String wompiUrl = 'https://production.wompi.co/v1';

  static const String baseUrl = '$wompiUrl/transactions/';

  static String localApiUrl = 'http://192.168.1.11:8081/';

  static String get api{
    return localTesting?'${localApiUrl}api/':apiUrl;
  }

  static String socketUrl = Platform.isAndroid
      ? 'http://192.168.1.7:8081/'
      : 'http://localhost:8081/';

  static String enterpriseUrl = Platform.isAndroid
      ? 'http://192.168.18.12:8081/api/empresa/'
      : 'http://localhost:8081/api/empresa/';
  static String postEnterpriUrl = Platform.isAndroid
      ? 'http://192.168.18.12:8081/api/publicacion/empresa/'
      : 'http://localhost:8081/api/publicacion/empresa/';

  static String comentUrl = Platform.isAndroid
      ? 'http://192.168.18.12:8081/api/comentario/'
      : 'http://localhost:8081/api/comentario/';

  static String localFeedbackUrl = Platform.isAndroid
      ? 'http://192.168.18.12:8081/api/feedback/'
      : 'http://localhost:8081/api/feedback/';

  static String feedbackUrl =
      'https://develop-persing.imagineapps.co/api/feedback/';

  static String postUrl = Platform.isAndroid
      ? 'http://192.168.18.12:8081/api/publicacion/'
      : 'http://localhost:8081/api/publicacion/';
  static String userPostUrl = Platform.isAndroid
      ? 'http://192.168.18.12:8081/api/publicacion/user/'
      : 'http://localhost:8081/api/publicacion/user/';
  static String sectorPostUrl = Platform.isAndroid
      ? 'http://192.168.18.12:8081/api/publicacion/sector/'
      : 'http://localhost:8081/api/publicacion/sector/';
  static String seccionUrl = Platform.isAndroid
      ? 'http://192.168.18.12:8081/api/seccion/'
      : 'http://localhost:8081/api/seccion/';

  static String productoIntUrl = Platform.isAndroid
      ? 'http://192.168.18.12:8081/api/compra-producto/'
      : 'http://localhost:8081/api/compra-producto/';
  static String sectorProductUrl = Platform.isAndroid
      ? 'http://192.168.18.12:8081/api/producto/sector/'
      : 'http://localhost:8081/api/producto/sector/';
  static String discoProductUrl = Platform.isAndroid
      ? 'http://192.168.18.12:8081/api/producto-descuento'
      : 'http://localhost:8081/api/producto-descuento';

  static String postDestacadoUrl = Platform.isAndroid
      ? 'http://192.168.18.12:8081/api/destacado/'
      : 'http://localhost:8081/api/destacado/';
  static String rewardPostUrl = Platform.isAndroid
      ? 'http://192.168.18.12:8081/api/recompensa/user/'
      : 'http://localhost:8081/api/recompensa/user/';
  static String rewardUrl = Platform.isAndroid
      ? 'http://192.168.18.12:8081/api/recompensa/'
      : 'http://localhost:8081/api/recompensa/';
  static String sectorUrl = Platform.isAndroid
      ? 'http://192.168.18.12:8081/api/sector/'
      : 'http://localhost:8081/api/sector/';

  static String userUrl = Platform.isAndroid
      ? 'http://192.168.18.12:8081/api/user/'
      : 'http://localhost:8081/api/user/';
  static String usersUrl = Platform.isAndroid
      ? 'http://192.168.18.12:8081/users'
      : 'http://localhost:8081/users';
}
