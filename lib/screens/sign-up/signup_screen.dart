// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/providers/auth.dart';
import 'package:persing/providers/sector.dart';
import 'package:persing/screens/index/index_screen.dart';
import 'package:persing/screens/sign-up/agreements_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _hidden = true;
  int _activeStep = 0;
  late String _estrato;
  late String _nivelEducativo;
  late bool _hasPets;
  late bool _hasKids;
  late String _gender;
  bool _loading = false;
  late String profesion;
  late String estadoCivil;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // List of options
  List<String> genreList = [
    'Masculino',
    'Femenino',
    'Otro',
    'Prefiero no decir'
  ];
  List<String> stratumList = ['1', '2', '3', '4', '5', '6', 'Rural'];
  List<String> sonsList = ['Si', 'No'];
  List<String> maritalStatusList = [
    'Soltero',
    'Casado',
    'Divorciado',
    'Unión libre',
    'Viudo'
  ];

  List<String> educationlevelList = [
    'Ninguno',
    'Primaria',
    'Bachillerato',
    'Título universitario',
    'Título técnico',
    'Especialización',
    'Maestría / MBA',
    'Doctorado',
  ];
  List<String> workStatusList = [
    'Empleado',
    'Desempleado',
    'Independiente',
    'Líder de hogar'
  ];

  // sectores
  late Future<List<Map<String, dynamic>>> sectores;

  // Field controllers
  final _nameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _havePetsController = TextEditingController();
  final _yearsController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _kidsController = TextEditingController();
  // ignore: unused_field
  final _jobController = TextEditingController();

  @override
  void didChangeDependencies() {
    sectores = mapSectores(Provider.of<Sector>(context).fetchSectores());
    super.didChangeDependencies();
  }

  Future<List<Map<String, dynamic>>> mapSectores(
      Future<List<Map<String, dynamic>>> sec) async {
    final secs = await sec;
    secs.forEach((element) {
      element["selected"] = false;
    });
    return secs;
  }

  /// Valida el formulario
  bool validateForm() => _formKey.currentState!.validate();

  void activeLoader() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("token") || prefs.containsKey("userId")) {
      await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => IndexScreen()),
        (Route<dynamic> route) => false,
      );
      setState(() {
        _loading = true;
      });
    }
  }

  void deactiveLoader() {
    setState(() {
      _loading = false;
    });
  }

  void _nextStep() {
    setState(() {
      _activeStep++;
    });
  }

  void _previousStep() {
    setState(() {
      if (_activeStep == 0) {
        Navigator.pop(context);
      } else {
        _activeStep--;
      }
    });
  }

  void _toggleVisibility() {
    setState(() {
      _hidden = !_hidden;
    });
  }

  // ignore: unused_element
  void _navigateToHome(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => IndexScreen()));
  }

  dynamic _getSelectedSectors() async {
    final sectors = await sectores;
    List<String> ids = [];
    sectors.forEach((e) {
      if (e["selected"]) {
        ids.add(e["_id"]);
      }
    });
    return ids;
  }

  Widget getTagObjects(List<Map<String, dynamic>> tags, Size size) {
    return Container(
      height: size.height * 0.49,
      width: size.width * 0.9,
      child: GridView.count(
          childAspectRatio: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          primary: false,
          crossAxisCount: 2,
          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 15),
          children: List.generate(tags.length, (index) {
            return GestureDetector(
              key: Key('id' + index.toString()),
              onTap: () {
                setState(
                    () => tags[index]["selected"] = !tags[index]["selected"]);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: tags[index]["selected"]
                      ? Border.all(width: 3, color: Color(0xFFFF0094))
                      : null,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        spreadRadius: 0.3,
                        blurRadius: 7,
                        offset: Offset(3, 5))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: size.width * 0.02),
                        height: 45,
                        width: 45,
                        child:
                            Image(image: NetworkImage(tags[index]["icono"]))),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 95),
                        child: Text(
                          tags[index]["nombre"],
                          maxLines: 2,
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            );
          })),
    );
  }

  Future<bool> verifyGender(BuildContext ctx) async {
    try {
      if (_gender == null) {
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text(
            "Por favor selecciona el género con el cuál te identificas",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
        return false;
      } else {
        return true;
      }
    } on FlutterError catch (error) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(
          error.message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
      return false;
    }
  }

  // ignore: missing_return
  Future<bool> verifyEmail(BuildContext ctx) async {
    try {
      if (_yearsController.text.isEmpty) {
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text(
            "Por favor ingresa tu edad",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
        return false;
      }

      if (!validateEmail(_emailController.text)) {
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text(
            "Ingresa un email válido",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
        return false;
      }

      if (_passwordController.text.isEmpty) {
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text(
            "Por favor ingresa tu contraseña",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
        return false;
      }

      final available = await Provider.of<Auth>(context, listen: false)
          .verifyEmail(_emailController.text);
      if (available) {
        return true;
      }
    } on FlutterError catch (error) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(
          error.message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
      return false;
    }

    throw Exception();
  }

  void onSubmitForm(BuildContext context) async {
    bool isValid = validateForm();
    if (!isValid) return;
    // activeLoader();
    Map<String, dynamic> obj = {
      "email": _emailController.text,
      "password": _passwordController.text,
      "nombre": _nameController.text.isEmpty ? '' : _nameController.text,
      "apellido":
          _lastnameController.text.isEmpty ? '' : _lastnameController.text,
      "age": _yearsController.text,
      "genero": _gender,
      "estrato": _estrato,
      "nivelEducativo": _nivelEducativo,
      "estadoCivil": estadoCivil,
      "hijos": _hasKids,
      "cantidadHijos":
          _kidsController.text != null && _kidsController.text.isNotEmpty
              ? int.parse(_kidsController.text)
              : 0,
      "profesion": profesion,
      "mascotas": _hasPets,
      "cantidadMascotas": _havePetsController.text != null &&
              _havePetsController.text.isNotEmpty
          ? int.parse(_havePetsController.text)
          : 0,
      "intereses": await _getSelectedSectors(),
      "tipo": "consumidor"
    };

    try {
      final registered =
          await Provider.of<Auth>(context, listen: false).signUp(obj);
      await Provider.of<Auth>(context, listen: false)
          .logIn(registered["email"], obj["password"])
          .whenComplete(() {
        showAlertDialogSign(
            () => activeLoader(),
            "¡Bienvenido!",
            'Estamos muy contentos de que ahora seas parte de esta familia',
            context,
            'Comenzar');
      });

      //here
    } catch (error) {
      showAlertDialogSign(Navigator.of(context).pop, "Error", error.toString(),
          context, 'Cerrar');
    } finally {
      deactiveLoader();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color pinkColor = Color(0xFFFF0094);
    final Color orangeColor = Color(0xFFFFA159);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xFFF7F7FF),
        appBar: AppBar(
          //
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Image.asset('assets/images/splash/logo-onboarding.png',
              width: 100),

          leading: GestureDetector(
            onTap: () {
              _previousStep();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          actions: [
            _activeStep == 1
                ? Padding(
                    padding: const EdgeInsets.only(
                        top: 17.5, right: 17.5, bottom: 17.5),
                    child: GestureDetector(
                        onTap: () {
                          _nextStep();
                        },
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w900),
                                children: [TextSpan(text: 'Saltar')]))))
                : Container()
          ],
        ),
        body: Builder(builder: (BuildContext ctx) {
          return _loading
              ? Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor)),
                )
              : Stack(children: [
                  _WhiteBarProgress(size: size),
                  _GradientBarProgress(
                      size: size,
                      activeStep: _activeStep,
                      pinkColor: pinkColor,
                      orangeColor: orangeColor),
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 24, left: 16, right: 16, bottom: 80),
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: ListView(
                            // height: MediaQuery.of(context).size.height,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Linear progress original

                              /*  Container(
                                    child: LinearProgressIndicator(
                                      backgroundColor: Colors.white,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xFFFF0094)),
                                      value: _activeStep == 0
                                          ? 0.33
                                          : _activeStep == 1
                                              ? 0.66
                                              : 1,
                                      minHeight: 15,
                                    ),
                                  ), */

                              Form(
                                key: _formKey,
                                child: Container(
                                    child: _activeStep == 0
                                        ? _firstForm()
                                        : _activeStep == 1
                                            ? _secondForm()
                                            : _thirdForm(size)),
                              )
                            ]),
                      )),
                  Positioned(
                      bottom: size.height * 0.01,
                      left: 0,
                      width: size.width,
                      child: Material(
                          elevation: 0,
                          child: Column(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(1, 240, 240, 240)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: ButtonTheme(
                                        minWidth: size.width,
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xFFFF0094),
                                            onPrimary: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          onPressed: () {
                                            if (_activeStep == 2) {
                                              onSubmitForm(context);
                                            } else if (_activeStep == 0) {
                                              verifyGender(ctx)
                                                  .then((value) => {
                                                        if (value)
                                                          {
                                                            verifyEmail(ctx)
                                                                .then(
                                                                    (value) => {
                                                                          if (value)
                                                                            {
                                                                              _nextStep()
                                                                            }
                                                                        })
                                                          }
                                                      });
                                            } else {
                                              _nextStep();
                                            }
                                          },
                                          child: Text(
                                            _activeStep == 2
                                                ? 'Registrarme'
                                                : "Siguiente",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                  )),
                              _activeStep == 2
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: size.width * 0.07,
                                              bottom: size.height * 0.08),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AgreementsScreen()));
                                            },
                                            child: RichText(
                                                textAlign: TextAlign.left,
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text:
                                                          'Al registrarte estás aceptando\n',
                                                      style: GoogleFonts.nunito(
                                                          textStyle: TextStyle(
                                                              color: Color(
                                                                  0xFF1F0681)))),
                                                  TextSpan(
                                                      text:
                                                          'Términos y condiciones',
                                                      style: GoogleFonts.nunito(
                                                          textStyle: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xFF1F0681)))),
                                                ])),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container()
                            ],
                          ))),
                ]);
        }));
  }

  Widget _firstForm() {
    String numberValidator(String value) {
      final n = num.tryParse(value);
      if (n == null) {
        return '"$value" is not a valid number';
      }
      return '';
    }

    return Column(
      children: [
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
            width: double.infinity,
            height: 25,
            child: Text(
              '¿Con qué género te identificas? *',
              textAlign: TextAlign.left,
            )),
        Material(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                  height: 30,
                  alignedDropdown: true,
                  child: DropdownButton(
                      value: _gender,
                      icon: Icon(Icons.arrow_drop_down_rounded),
                      iconSize: 40,
                      hint: Text('Selecciona'),
                      isExpanded: true,
                      items: genreList.map((String genre) {
                        return DropdownMenuItem<String>(
                          value: genre,
                          child: new Text(
                            genre,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _gender = value!;
                        });
                      }))),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
            width: double.infinity,
            height: 25,
            child: Text(
              '¿Cuál es tu edad? *',
              textAlign: TextAlign.left,
            )),
        Material(
          elevation: 5,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: TextFormField(
              controller: _yearsController,
              keyboardType: TextInputType.number,
              validator: (value) {
                return numberValidator(value ?? '');
              },
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                focusedBorder: InputBorder.none,
                hintText: "Escribe aquí",
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                contentPadding: EdgeInsets.all(12),
              )),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
            width: double.infinity,
            height: 25,
            child: Text(
              'Escribe un correo *',
              textAlign: TextAlign.left,
            )),
        Material(
          elevation: 5,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: TextFormField(
              controller: _emailController,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                focusedBorder: InputBorder.none,
                hintText: "Escribe aquí",
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                contentPadding: EdgeInsets.all(12),
              )),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
            width: double.infinity,
            height: 25,
            child: Text(
              'Crea tu contraseña *',
              textAlign: TextAlign.left,
            )),
        Material(
          elevation: 5,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.none,
              obscureText: _hidden ? true : false,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                focusedBorder: InputBorder.none,
                hintText: "Escribe aquí",
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                contentPadding: EdgeInsets.all(12),
                suffixIcon: IconButton(
                  icon: _hidden
                      ? Icon(Icons.visibility, color: primaryColor)
                      : Icon(Icons.visibility_off, color: primaryColor),
                  onPressed: _toggleVisibility,
                ),
              )),
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }

  Widget _secondForm() {
    String numberValidator(String value) {
      final n = num.tryParse(value);
      if (n == null) {
        return '"$value" is not a valid number';
      }
      return '';
    }

    return Column(
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
            width: double.infinity,
            height: 40,
            child: Text(
              'Puedes completar estos datos luego',
              textAlign: TextAlign.center,
            )),
        SizedBox(
            width: double.infinity,
            height: 40,
            child: Text(
              '¡Regístrate!',
              textAlign: TextAlign.center,
            )),
        SizedBox(
            width: double.infinity,
            height: 25,
            child: Text(
              '¿Cómo te llamas?',
              textAlign: TextAlign.left,
            )),
        Material(
          elevation: 5,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                focusedBorder: InputBorder.none,
                hintText: "Escribe aquí",
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                contentPadding: EdgeInsets.all(12),
              )),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
            width: double.infinity,
            height: 25,
            child: Text(
              '¿Cuáles son tus apellidos?',
              textAlign: TextAlign.left,
            )),
        Material(
          elevation: 5,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: TextFormField(
              controller: _lastnameController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                focusedBorder: InputBorder.none,
                hintText: "Escribe aquí",
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                contentPadding: EdgeInsets.all(12),
              )),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
            width: double.infinity,
            height: 25,
            child: Text(
              '¿Cuál es tu estrato?',
              textAlign: TextAlign.left,
            )),
        Material(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                      value: _estrato,
                      icon: Icon(Icons.arrow_drop_down_rounded),
                      iconSize: 40,
                      hint: Text('Selecciona'),
                      isExpanded: true,
                      items: stratumList.map((String stratum) {
                        return DropdownMenuItem<String>(
                          value: stratum,
                          child: new Text(
                            stratum,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _estrato = value!;
                        });
                      }))),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
            width: double.infinity,
            height: 25,
            child: Text(
              'Dinos tu nivel educativo',
              textAlign: TextAlign.left,
            )),
        Material(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                      value: _nivelEducativo,
                      icon: Icon(Icons.arrow_drop_down_rounded),
                      iconSize: 40,
                      hint: Text('Selecciona'),
                      isExpanded: true,
                      items: educationlevelList
                          .map((String educationLevel) =>
                              DropdownMenuItem<String>(
                                value: educationLevel,
                                child: new Text(
                                  educationLevel,
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _nivelEducativo = value!;
                        });
                      }))),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
            width: double.infinity,
            height: 25,
            child: Text(
              '¿Cuál es tu profesión?',
              textAlign: TextAlign.left,
            )),
        Material(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                  height: 30,
                  alignedDropdown: true,
                  child: DropdownButton(
                      value: profesion,
                      icon: Icon(Icons.arrow_drop_down_rounded),
                      iconSize: 40,
                      hint: Text('Selecciona'),
                      isExpanded: true,
                      items: workStatusList.map((String work) {
                        return DropdownMenuItem<String>(
                          value: work,
                          child: new Text(
                            work,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          profesion = value!;
                        });
                      }))),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
            width: double.infinity,
            height: 25,
            child: Text(
              '¿Cuál es tu estado civil?',
              textAlign: TextAlign.left,
            )),
        Material(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                  height: 30,
                  alignedDropdown: true,
                  child: DropdownButton(
                      value: estadoCivil,
                      icon: Icon(Icons.arrow_drop_down_rounded),
                      iconSize: 40,
                      hint: Text('Selecciona'),
                      isExpanded: true,
                      items: maritalStatusList.map((String maritalStatus) {
                        return DropdownMenuItem<String>(
                          value: maritalStatus,
                          child: new Text(
                            maritalStatus,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          estadoCivil = value!;
                        });
                      }))),
        ),
        SizedBox(height: 20.0),
        SizedBox(
            width: double.infinity,
            height: 25,
            child: Text(
              '¿Tienes hijos?',
              textAlign: TextAlign.left,
            )),
        Material(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                      value: _hasKids,
                      icon: Icon(Icons.arrow_drop_down_rounded),
                      iconSize: 40,
                      hint: Text('Selecciona'),
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(
                          child: Text("Sí"),
                          value: true,
                        ),
                        DropdownMenuItem(
                          child: Text("No"),
                          value: false,
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _hasKids = value!;
                          if (_hasKids == false) {
                            _kidsController.clear();
                          }
                        });
                      }))),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
            width: double.infinity,
            height: 25,
            child: Text(
              '¿Cuántos?',
              textAlign: TextAlign.left,
            )),
        Material(
          elevation: 5,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: TextFormField(
              enabled: _hasKids == true ? true : false,
              controller: _kidsController,
              validator: (value) {
                return numberValidator(value ?? '');
              },
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                focusedBorder: InputBorder.none,
                hintText: "Escribe aquí",
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                contentPadding: EdgeInsets.all(12),
              )),
        ),
        SizedBox(height: 20.0),
        SizedBox(
            width: double.infinity,
            height: 25,
            child: Text(
              '¿Tienes mascotas?',
              textAlign: TextAlign.left,
            )),
        Material(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                      value: _hasPets,
                      icon: Icon(Icons.arrow_drop_down_rounded),
                      iconSize: 40,
                      hint: Text('Selecciona'),
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(
                          child: Text('Si'),
                          value: true,
                        ),
                        DropdownMenuItem(
                          child: Text('No'),
                          value: false,
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _hasPets = value!;
                          if (_hasPets == false) {
                            _havePetsController.clear();
                          }
                          // _havePets = value;
                        });
                      }))),
        ),
        SizedBox(height: 20.0),
        SizedBox(
            width: double.infinity,
            height: 25,
            child: Text(
              '¿Cuántas?',
              textAlign: TextAlign.left,
            )),
        Material(
          elevation: 5,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: TextFormField(
              enabled: _hasPets == true ? true : false,
              controller: _havePetsController,
              validator: (value) {
                return numberValidator(value ?? '');
              },
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                focusedBorder: InputBorder.none,
                hintText: "Escribe aquí",
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                contentPadding: EdgeInsets.all(12),
              )),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  Widget _thirdForm(Size size) {
    return FutureBuilder(
      future: sectores,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    List<Map<String, dynamic>> selectedTags = snapshot.data;
                    selectedTags.forEach((e) {
                      e["selected"] = false;
                    });
                  });
                },
                child: SizedBox(
                    width: double.infinity,
                    height: 30,
                    child: Text('Deseleccionar todo',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: primaryColor),
                        ))),
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: Text('Selecciona todos tus intereses',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              color: Color(0xff1C1C1C), fontSize: 16)))),
              getTagObjects(snapshot.data, size),
            ],
          );
        }
        return Center(
          child: Text("No se han cargado sectores"),
        );
      },
    );
  }
}

class _GradientBarProgress extends StatelessWidget {
  const _GradientBarProgress({
    super.key,
    required this.size,
    required int activeStep,
    required this.pinkColor,
    required this.orangeColor,
  }) : _activeStep = activeStep;

  final Size size;
  final int _activeStep;
  final Color pinkColor;
  final Color orangeColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: size.height * 0.02, left: size.width * 0.05),
      child: Container(
        height: 13,
        width: _activeStep == 0
            ? size.width * 0.3
            : _activeStep == 1
                ? size.width * 0.6
                : size.width * 0.9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [pinkColor, orangeColor],
                stops: [
                  0.1,
                  1,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WhiteBarProgress extends StatelessWidget {
  const _WhiteBarProgress({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: size.height * 0.02, left: size.width * 0.05),
      child: Container(
        height: 12.5,
        width: size.width * 0.9,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 0.3,
              blurRadius: 7,
              offset: Offset(3, 5))
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
