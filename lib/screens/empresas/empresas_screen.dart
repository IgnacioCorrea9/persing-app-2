import 'package:flutter/material.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/models/enterprises_model.dart';
import 'package:persing/repository/repository.dart';
import 'package:persing/screens/empresas/empresa_profile_screen.dart';
import 'package:persing/screens/empresas/empresa_section.dart';
import 'package:persing/widgets/appbar.dart';

class EmpresasScreen extends StatefulWidget {
  EmpresasScreen({Key? key}) : super(key: key);

  @override
  _EmpresasScreenState createState() => _EmpresasScreenState();
}

class _EmpresasScreenState extends State<EmpresasScreen> {
  Repository _httpService = Repository();

  _navigateEmpresaProfile(String id) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EmpresaProfileScreen(
              idEnterprise: id,
            )));
  }

  @override
  Widget build(BuildContext context) {
    Size preferredSize = Size.fromHeight(kToolbarHeight);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(0.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FutureBuilder(
            future: _httpService.getEmpresas(),
            builder: (BuildContext context,
                AsyncSnapshot<List<DataEnterprises>> snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                List<DataEnterprises> posts = snapshot.data!;
                return GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: List.generate(
                    posts.length,
                    (i) => GestureDetector(
                      onTap: () => _navigateEmpresaProfile(posts[i].id),
                      child: EmpresaSection(
                        logoUrl: posts[i].logo ?? '',
                        name: posts[i].nombre ?? 'Nombre vacío',
                        type: posts[i].descripcion ?? 'Tipo vacío',
                      ),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
                    backgroundColor: Colors.white,
                  ),
                );
              }
            },
          ),
        ),
      ),
      appBar: PreferredSize(
          child: _buildSearchAppbar(),
          preferredSize: Size(double.infinity, 50)),
    );
  }

  Widget _buildSearchAppbar() {
    return AppBarColor(
      title: Text(
        'Todas las empresas',
        style: TextStyle(fontSize: 14),
      ),
      onPressed: () {},
    );
  }
}
