import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:persing/core/config.dart';
import 'package:persing/core/storage/token_storage.dart';
import 'package:persing/models/enterprises/enterprises_by_id_model.dart';
import 'package:persing/models/enterprises_model.dart';
import 'package:persing/models/featured_screen/featured_model.dart';
import 'package:persing/models/featured_screen/featured_section_model.dart';
import 'package:persing/models/featured_screen/news_publications_model.dart';
import 'package:persing/models/home_publicacion_model.dart';
import 'package:persing/models/know_more/know_more_discounts_model.dart';
import 'package:persing/models/publicaciones_destacadas_model.dart';
import 'package:persing/models/publicaciones_model.dart';
import 'package:persing/models/publicaciones_sector_model.dart';
import 'package:persing/models/recompensa_home_model.dart';
import 'package:persing/models/sector_by_id_model.dart';
import 'package:persing/models/sector_model.dart';

class Repository with ChangeNotifier {
  late String _token;

  Map<String, String> get headers =>
      {"Authorization": _token, 'Content-Type': 'application/json'};

  final String constLocalHost = 'https://develop-persing.imagineapps.co/';
  final String _urlEnteprises =
      "https://develop-persing.imagineapps.co/api/empresa/";
  final String _urlPublicaciones =
      "https://develop-persing.imagineapps.co/api/publicacion/";
  final String _urlPublicacionesBySector =
      'https://develop-persing.imagineapps.co/api/publicacion/sector/';
  final String _urlSector =
      'https://develop-persing.imagineapps.co/api/sector/';
  final String _urlProductoById =
      'https://develop-persing.imagineapps.co/api/producto/sector/';
  final String _urlProductoIntereses =
      'https://develop-persing.imagineapps.co/api/compra-producto/';
  // ignore: unused_field
  final String _urlPublicacionesUsuario =
      'https://develop-persing.imagineapps.co/api/publicacion/user/';
  final String _urlRecompensaHome =
      'https://develop-persing.imagineapps.co/api/recompensa/user/';
  final String _urlEmpresaById =
      'https://develop-persing.imagineapps.co/api/publicacion/empresa/';
  late String userId;

  Future<List<DataEnterprises>> getEmpresas() async {
    _token = await TokenStorage.get().gett();
    Response res = await get(
        Uri.parse(Config.localTesting ? Config.enterpriseUrl : _urlEnteprises),
        headers: headers);
    if (res.statusCode == 200) {
      final jsonResponse = jsonDecode(res.body);
      EnterprisesModel enterprisesModel =
          new EnterprisesModel.fromJson(jsonResponse);
      return enterprisesModel.data;
    } else {
      throw "Error al cargar las empresas";
    }
  }

  Future<List<RecompensaHomeData>> getRecompensaHome(String userId) async {
    _token = await TokenStorage.get().gett();
    Response res = await get(
        Uri.parse(Config.localTesting
            ? Config.rewardPostUrl + userId
            : _urlRecompensaHome + userId),
        headers: headers);
    if (res.statusCode == 200) {
      final jsonResponse = jsonDecode(res.body);
      RecompensaHomeModel recompensaHomeModel =
          new RecompensaHomeModel.fromJson(jsonResponse);
      return recompensaHomeModel.data;
    } else {
      throw "Error al cargar las recompensas";
    }
  }

  Future<List<SectorData>> getSector() async {
    _token = await TokenStorage.get().gett();
    Response response = await get(
        Uri.parse(Config.localTesting ? Config.sectorUrl : _urlSector),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      SectorModel enterprisesModel = new SectorModel.fromJson(jsonResponse);
      return enterprisesModel.data;
    } else {
      throw "Error al cargar las empresas";
    }
  }

  Future<List<SectorByIdData>> getSectorId(String sectorId) async {
    _token = await TokenStorage.get().gett();
    Response response = await get(
        Uri.parse(Config.localTesting
            ? Config.sectorProductUrl + sectorId
            : _urlProductoById + sectorId),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      SectorByIdModel sectorById = new SectorByIdModel.fromJson(jsonResponse);
      return sectorById.data;
    } else {
      throw "Error al cargar las empresas";
    }
  }

  Future<String> getProductoIntereses(
      String idProducto, String idUsuario) async {
    _token = await TokenStorage.get().gett();
    Map<String, String> body = {"producto": idProducto, "usuario": idUsuario};
    Response response = await post(
        Uri.parse(Config.localTesting
            ? Config.productoIntUrl
            : _urlProductoIntereses),
        body: jsonEncode(body),
        headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      //  SectorModel enterprisesModel = new SectorModel.fromJson(jsonResponse);
      return response.body;
    } else {
      throw "Error al cargar las empresas";
    }
  }

  Future<List<PublicacionesDestacadasData>> getPublicacionesDestacadas() async {
    _token = await TokenStorage.get().gett();
    Response response = await get(
        Uri.parse(Config.localTesting
            ? Config.postDestacadoUrl
            : 'https://develop-persing.imagineapps.co/api/destacado'),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      PublicacionesDestacadasModel publicacionesModel =
          new PublicacionesDestacadasModel.fromJson(jsonResponse);
      return publicacionesModel.data;
    } else {
      throw "Error al cargar las publicaciones";
    }
  }

  Future<List<FeaturedModelData>> getSeccions() async {
    _token = await TokenStorage.get().gett();
    Response response = await get(
        Uri.parse(Config.localTesting
            ? Config.seccionUrl
            : 'https://develop-persing.imagineapps.co/api/seccion'),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      FeaturedModel featuredModel = new FeaturedModel.fromJson(jsonResponse);
      return featuredModel.data;
    } else {
      throw "Error al cargar las secciones";
    }
  }

  Future<List<FeaturedSectionModelData>> getDetailsSeccions(
      String sectionId, String userId) async {
    _token = await TokenStorage.get().gett();
    Response response = await get(
        Uri.parse(Config.localTesting
            ? Config.postDestacadoUrl + 'seccion/$sectionId/usuario/$userId'
            : 'https://develop-persing.imagineapps.co/api/destacado/seccion/$sectionId/usuario/$userId'),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      FeaturedSectionModel featuredSectionModel =
          new FeaturedSectionModel.fromJson(jsonResponse);
      return featuredSectionModel.data;
    } else {
      throw "Error al cargar las secciones";
    }
  }

  Future<List<KnowMoreDiscountsModelData>> knowMoreDiscounts() async {
    _token = await TokenStorage.get().gett();
    Response response = await get(
        Uri.parse(Config.localTesting
            ? Config.discoProductUrl
            : 'https://develop-persing.imagineapps.co/api/producto-descuento'),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      KnowMoreDiscountsModel knowMoreDiscountsModel =
          new KnowMoreDiscountsModel.fromJson(jsonResponse);
      return knowMoreDiscountsModel.data;
    } else {
      throw "Error al cargar las secciones";
    }
  }

  Future<List<NewsPublicationsModelData>> getNewsPublications(
      String userId) async {
    _token = await TokenStorage.get().gett();
    Response response = await get(
        Uri.parse(Config.localTesting
            ? Config.localApiUrl + 'api/publicacion-nuevas/user/$userId'
            : 'https://develop-persing.imagineapps.co/api/publicacion-nuevas/user/$userId'),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      NewsPublicationsModel newsPublicationsModel =
          new NewsPublicationsModel.fromJson(jsonResponse);
      return newsPublicationsModel.data;
    } else {
      throw "Error al cargar las secciones";
    }
  }

  Future<List<HomePublicacionesData>> getPublicacionesByUser(
      String idUsuario) async {
    _token = await TokenStorage.get().gett();

    Response response = await get(
        Uri.parse(Config.localTesting
            ? Config.userPostUrl + '$idUsuario'
            : 'https://develop-persing.imagineapps.co/api/publicacion/user/$idUsuario'),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      HomePublicacionesModel publicacionesModel =
          new HomePublicacionesModel.fromJson(jsonResponse);
      return publicacionesModel.data;
    } else {
      throw "Error al cargar las publicaciones";
    }
  }

  Future<List<HomePublicacionesData>> getPublicacionesFilter(
      String idUsuario, List<String> sectores) async {
    _token = await TokenStorage.get().gett();
    Response response = await get(
        Uri(
          scheme: Config.localTesting ? 'http' : 'https',
          host: Config.localTesting
              ? Platform.isAndroid
                  ? '192.168.1.12:8081'
                  : 'localhost:8081'
              : 'persing.herokuapp.com',
          path: '/api/publicacion/user/$idUsuario',
          queryParameters: {
            'intereses': [sectores.toString()],
          },
        ),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      HomePublicacionesModel publicacionesModel =
          new HomePublicacionesModel.fromJson(jsonResponse);
      return publicacionesModel.data;
    } else {
      throw "Error al cargar las publicaciones";
    }
  }

  Future<List<EnterprisesByIdModelData>> getEmpresaById(
      String empresaId, String userId) async {
    _token = await TokenStorage.get().gett();
    Response response = await get(
        Uri.parse(Config.localTesting
            ? Config.postEnterpriUrl + '$empresaId/usuario/$userId'
            : _urlEmpresaById + '$empresaId/usuario/$userId'),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      EnterprisesByIdModel enterprisesByIdModel =
          new EnterprisesByIdModel.fromJson(jsonResponse);
      return enterprisesByIdModel.data!;
    } else {
      throw "Error al cargar las empresas por id";
    }
  }

  Future<List<PublicacionesBySectorData>> getPublicacionBySector(
      String sectorId, String userId) async {
    _token = await TokenStorage.get().gett();
    Response response = await get(
        Uri.parse(Config.localTesting
            ? Config.sectorPostUrl + sectorId + '/$userId'
            : _urlPublicacionesBySector + sectorId + '/$userId'),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      PublicacionesBySectorModel sectorModel =
          new PublicacionesBySectorModel.fromJson(jsonResponse);
      return sectorModel.data;
    } else {
      throw "Error al cargar las publicaciones por sector";
    }
  }

  Future<List<PublicacionesData>> getPublicaciones() async {
    _token = await TokenStorage.get().gett();
    Response response = await get(
        Uri.parse(Config.localTesting ? Config.postUrl : _urlPublicaciones),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      PublicacionesModel publicacionesModel =
          new PublicacionesModel.fromJson(jsonResponse);
      return publicacionesModel.data;
    } else {
      throw "Error al cargar las publicaciones";
    }
  }

  Future<List<PublicacionesData>> fetchHighlightedPosts() async {
    _token = await TokenStorage.get().gett();
    Response response = await get(
        Uri.parse(Config.localTesting ? Config.postUrl : _urlPublicaciones),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      PublicacionesModel publicacionesModel =
          new PublicacionesModel.fromJson(jsonResponse);
      return publicacionesModel.data;
    } else {
      throw "Error al cargar las publicaciones";
    }
  }
}
