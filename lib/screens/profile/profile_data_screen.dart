// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/core/ui/widgets/labeled_textform.dart';
import 'package:persing/providers/auth.dart';
import 'package:persing/providers/user.dart';
import 'package:persing/screens/login/login_screen.dart';
import 'package:persing/widgets/custom_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import 'models/profile_data_model.dart';

class ProfileDataScreen extends StatefulWidget {
  ProfileDataScreen({Key? key}) : super(key: key);

  @override
  _ProfileDataScreenState createState() => _ProfileDataScreenState();
}

class _ProfileDataScreenState extends State<ProfileDataScreen> {
  String _gender = '';
  String _estrato = '';
  String _nivelEducativo = '';
  String profesion = '';
  String estadoCivil = '';
  String estadoCivilLast = '';
  String profesionLast = '';
  late ProfileDataModel profileDataModel;
  late bool _hasKids;
  late bool _hasPets;

  final _jobController = TextEditingController();
  final _kidsController = TextEditingController();
  final _havePetsController = TextEditingController();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

// List of options
  List<String> genreList = [
    'Masculino',
    'Femenino',
    'Otro',
    'Prefiero no decir'
  ];
  List<String> stratumList = ['', '1', '2', '3', '4', '5', '6', 'Rural'];
  List<String> sonsList = ['Si', 'No'];
  List<String> maritalStatusList = [
    '',
    'Soltero',
    'Casado',
    'Divorciado',
    'Unión libre',
    'Viudo'
  ];
  List<String> educationlevelList = [
    '',
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
    '',
    'Empleado',
    'Desempleado',
    'Independiente',
    'Líder de hogar'
  ];

  @override
  void initState() {
    super.initState();
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();

    setState(() {
      Provider.of<Auth>(context, listen: false).logOut();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false);
    });
  }

  _openChangePasswordDialog(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _passwordController = TextEditingController();
    final _oldPasswordController = TextEditingController();
    ValueNotifier<bool> _loading = ValueNotifier(false);
    ValueNotifier<bool> _showPassword = ValueNotifier(false);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(10),
          content: Container(
            width: size.width * 0.8,
            height: 230,
            child: Padding(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Contraseña anterior",
                      style: TextStyle(fontSize: 16, color: primaryColor)),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _oldPasswordController,
                      obscureText: true,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Campo obligatorio';
                        }
                        return null;
                      },
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
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Contraseña nueva",
                    style: TextStyle(
                      fontSize: 16,
                      color: primaryColor,
                    ),
                  ),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: ValueListenableBuilder(
                      valueListenable: _showPassword,
                      builder:
                          (BuildContext context, dynamic value, Widget? child) {
                        return TextFormField(
                          controller: _passwordController,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Campo obligatorio';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          obscureText: !value,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            suffix: InkWell(
                              onTap: () {
                                _showPassword.value = !_showPassword.value;
                              },
                              child: Icon(
                                value
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined,
                              ),
                            ),
                            focusedBorder: InputBorder.none,
                            hintText: "Escribe aquí",
                            filled: true,
                            fillColor: Colors.white,
                            isDense: true,
                            contentPadding: EdgeInsets.all(12),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            padding: EdgeInsets.only(
                                top: 10, bottom: 9, left: 18, right: 19),
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            "Cancelar",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: _loading,
                          builder: (BuildContext context, bool loading,
                              Widget? child) {
                            if (loading) {
                              return SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                              );
                            }
                            return ElevatedButton(
                              onPressed: () async {
                                if ((_oldPasswordController.text?.isNotEmpty ??
                                        false) &&
                                    (_passwordController.text?.isNotEmpty ??
                                        false) &&
                                    !loading) {
                                  _loading.value = true;
                                  try {
                                    await Provider.of<User>(context,
                                            listen: false)
                                        .changePassword(
                                      {
                                        'oldPassword':
                                            _oldPasswordController.text,
                                        'newPassword': _passwordController.text,
                                      },
                                    );
                                    Navigator.of(context).pop();
                                    showAlertDialog(
                                      "Éxito",
                                      "Contraseña actualizada",
                                      context,
                                      'Volver',
                                    );
                                  } on FlutterError catch (error) {
                                    showAlertDialog(
                                      "Error",
                                      error.message,
                                      context,
                                      'Cerrar',
                                    );
                                  }
                                  _loading.value = false;
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 9, left: 18, right: 19),
                              ),
                              child: Text("Cambiar",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void saveChanges() {
    Map<String, dynamic> newData = {};

    if (_nameController.text != null &&
        _nameController.text != "" &&
        _nameController.text != profileDataModel.data.nombre) {
      newData["nombre"] = _nameController.text;
    }
    if (_lastNameController.text != null &&
        _lastNameController.text != "" &&
        _lastNameController.text != profileDataModel.data.apellido) {
      newData["apellido"] = _lastNameController.text;
    }
    if (_emailController.text != null &&
        _emailController.text != "" &&
        _emailController.text != profileDataModel.data.email) {
      newData["email"] = _emailController.text;
    }

    if (_gender != null && _gender != "") {
      newData["genero"] = _gender;
    }
    if (_estrato != null && _estrato != '-1') {
      newData["estrato"] = _estrato;
    }
    if (estadoCivil != null && estadoCivil != "") {
      newData["estadoCivil"] = estadoCivil;
    }
    if (_hasKids != null) {
      newData["hijos"] = _hasKids;
    }
    if (_hasKids == false) {
      newData["cantidadHijos"] = 0;
    } else {
      newData["cantidadHijos"] = _kidsController.text;
    }
    if (_jobController.text != null && _jobController.text != "") {
      newData["profesion"] = _jobController.text;
    }

    if (_hasPets != null) {
      newData["mascotas"] = _hasPets;
    }

    if (_hasPets == false) {
      newData["cantidadMascotas"] = 0;
    } else {
      newData["cantidadMascotas"] = _havePetsController.text;
    }
    if (_nivelEducativo != null && _nivelEducativo != "") {
      newData["nivelEducativo"] = _nivelEducativo;
    }

    try {
      Provider.of<User>(context, listen: false).editUser(newData);
      showAlertDialog("Éxito", "El usuario ha sido editado", context, 'Volver');
    } on FlutterError catch (error) {
      showAlertDialog("Error", error.message, context, 'Cerrar');
    } finally {
      setState(() {});
    }
  }

  String numberValidator(String value) {
    if (value == null) {
      return "";
    }
    final n = num.tryParse(value);
    if (n == null) {
      return '"$value" is not a valid number';
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10.3),
        child: FutureBuilder(
          future: Provider.of<User>(context).fetchUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              profileDataModel = snapshot.data!;
              if (profileDataModel != null) {
                if (_gender == null || _gender == '') {
                  _gender = profileDataModel?.data?.genero ?? '';
                }
                if (_estrato == null || _estrato == '') {
                  _estrato = profileDataModel?.data?.estrato?.toString() ?? '';
                }
                if (estadoCivil == null || estadoCivil == '') {
                  estadoCivil = profileDataModel?.data?.estadoCivil ?? '';
                }
                if (_nivelEducativo == null || _nivelEducativo == '') {
                  _nivelEducativo =
                      profileDataModel?.data?.nivelEducativo ?? '';
                }

                if (_hasKids == null) {
                  _hasKids = profileDataModel.data.hijos;
                  if (profileDataModel.data.hijos != null) {
                    _kidsController.text =
                        profileDataModel.data.cantidadHijos.toString();
                  } else {
                    _kidsController.clear();
                  }
                }

                if (_hasPets == null) {
                  _hasPets = profileDataModel.data.mascotas;
                  if (profileDataModel.data.mascotas != null) {
                    if (profileDataModel.data.mascotas) {
                      _havePetsController.text =
                          profileDataModel.data.cantidadMascotas.toString();
                    } else {
                      _havePetsController.clear();
                    }
                  } else {
                    profileDataModel.data.mascotas = false;
                  }
                }
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildEarningsResume(
                    profileDataModel.data.nombre,
                    profileDataModel.data.apellido,
                    profileDataModel.data.creditos,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    child: InkWell(
                      child: Text('Cambiar contraseña',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor)),
                      onTap: () {
                        _openChangePasswordDialog(context);
                      },
                    ),
                  ),
                  _namesEmailSection(),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Mejora tu perfil completando los datos que no se diligenciaron en el formulario de registro",
                    softWrap: true,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 25,
                      child: Text(
                        '¿Con qué género te identificas?',
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
                                value: _estrato.toString(),
                                icon: Icon(Icons.arrow_drop_down_rounded),
                                iconSize: 40,
                                hint: Text('Selecciona'),
                                isExpanded: true,
                                items: stratumList.map((String stratum) {
                                  return DropdownMenuItem<String>(
                                    value: stratum.toString(),
                                    child: new Text(
                                      stratum.toString(),
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
                            setState(
                              () {
                                _nivelEducativo = value!;
                              },
                            );
                          },
                        ),
                      ),
                    ),
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
                            setState(
                              () {
                                estadoCivil = value!;
                              },
                            );
                          },
                        ),
                      ),
                    ),
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
                            setState(
                              () {
                                _hasKids = value!;
                                if (_hasKids == false) {
                                  _kidsController.clear();
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  LabeledTextFormField(
                    labelText: '¿Cuántos?',
                    hintText: "Escribe aquí",
                    controller: _kidsController,
                    enabled: _hasKids == true ? true : false,
                    validator: (value) {
                      return numberValidator(value ?? "");
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
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
                            });
                            if (_hasPets == false) {
                              _havePetsController.clear();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  LabeledTextFormField(
                    labelText: '¿Cuántas?',
                    hintText: "Escribe aquí",
                    controller: _havePetsController,
                    enabled: _hasPets == true ? true : false,
                    validator: (value) {
                      return numberValidator(value ?? "");
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(
                              CustomIcons.off,
                              size: 17,
                              color: primaryColor,
                            ),
                          ),
                          InkWell(
                            child: Text(
                              "Cerrar sesión",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              logout();
                            },
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Color(0xFFFF0094), shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                        ),
                        child: Text("Guardar",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          saveChanges();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 61.8,
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                backgroundColor: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }

  Column _namesEmailSection() {
    return Column(
      children: [
        LabeledTextFormField(
          controller: _nameController,
          hintText: profileDataModel.data.nombre,
          labelText: ' • Nombre',
          validator: (value) {
            return value!;
          },
          keyboardType: TextInputType.name,
        ),
        SizedBox(
          height: 10,
        ),
        LabeledTextFormField(
          controller: _lastNameController,
          hintText: profileDataModel.data.apellido,
          labelText: ' • Apellido',
          validator: (value) {
            return value!;
          },
          keyboardType: TextInputType.name,
        ),
        SizedBox(
          height: 10,
        ),
        LabeledTextFormField(
          controller: _emailController,
          hintText: profileDataModel.data.email,
          labelText: ' • Correo',
          validator: (value) {
            return value!;
          },
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  Widget _buildEarningsResume(String name, String apellido, dynamic earnings) {
    return Card(
        elevation: 5,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  height: 85,
                  width: 50.0,
                  child: CircleAvatar(
                    backgroundColor: Color(0xFFFFF1D5),
                    child: Image.asset(
                      "assets/images/ganancias/ilustracion-creditos.png",
                    ),
                  ),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 10, right: 10, bottom: 10),
                constraints: BoxConstraints(maxHeight: double.infinity),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name + " " + apellido,
                        style:
                            TextStyle(color: Color(0xFF1C1C1C), fontSize: 20)),
                    Wrap(
                      children: [
                        Text(
                          'Total de créditos ganados',
                          softWrap: true,
                          style:
                              TextStyle(color: Color(0xFF707070), fontSize: 14),
                        )
                      ],
                    ),
                    Wrap(
                      children: [
                        Text(
                          "${formatter.format(earnings)}",
                          softWrap: true,
                          style:
                              TextStyle(color: Color(0xFF3B3B3B), fontSize: 16),
                        )
                      ],
                    ),
                  ],
                ))
          ],
        ));
  }
}
