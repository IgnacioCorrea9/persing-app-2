import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_credit_card/extension.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/core/storage/token_storage.dart';
=======
import 'package:google_fonts/google_fonts.dart';
import 'package:persing/core/colors.dart';
>>>>>>> main
import 'package:persing/providers/auth.dart';
import 'package:persing/screens/index/index_screen.dart';
import 'package:persing/screens/login/forgot_password_screen.dart';
import 'package:persing/screens/sign-up/signup_screen.dart';
import 'package:persing/widgets/appbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _hidden = true;
  bool _loading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void _toggleVisibility() {
    setState(() {
      _hidden = !_hidden;
    });
  }

  void _navigateToSignUp(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignupScreen()));
  }

  void _navigateForgotPassword(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
  }

  void activeLoader() async {
    final prefs = await SharedPreferences.getInstance();
<<<<<<< HEAD
    TokenStorage.get().setSharedPrefrence(prefs);
    if (prefs.getString("token").isNotNullAndNotEmpty ||
        prefs.getString("userId").isNotNullAndNotEmpty) {
=======
    if (prefs.containsKey("token") || prefs.containsKey("userId")) {
>>>>>>> main
      await Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => IndexScreen()));
      setState(() {});
    } else {
<<<<<<< HEAD
      showAlertDialog(context);
    }
  }

  showAlertDialog(BuildContext context) async {
=======
      await showAlertDialog(context);
    }
  }

  showAlertDialog(BuildContext context) {
>>>>>>> main
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Error",
        style: TextStyle(
          color: primaryColor,
        ),
      ),
      content: Text(Provider.of<Auth>(context, listen: false).error),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFFF0094),
          ),
          onPressed: Navigator.of(context).pop,
          child: Text("Cerrar", style: TextStyle(color: Colors.white)),
        )
      ],
    );

    // show the dialog
<<<<<<< HEAD
    await showDialog(
=======
    showDialog(
>>>>>>> main
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void deactiveLoader() {
    setState(() {
      _loading = false;
    });
  }

  void showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Error",
                  style: GoogleFonts.nunito(
                      textStyle: TextStyle(color: primaryColor))),
              content: Text(message),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF0094),
                  ),
                  onPressed: Navigator.of(ctx).pop,
                  child: Text("Cerrar", style: TextStyle(color: Colors.white)),
                )
              ],
            ));
  }

  /// Valida el formulario
  bool validateForm() => _formKey.currentState?.validate() ?? false;

  void onSubmitForm(context) async {
    bool isValid = validateForm();
    if (!isValid) return;

    if (!isValid) {
      showErrorDialog('Te faltan campos por diligenciar');
    } else {
      setState(() {
        Provider.of<Auth>(context, listen: false)
            .logIn(_emailController.text, _passwordController.text)
            .whenComplete(() => activeLoader());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 50),
          child: AppBarColor(
            leading: Text(""),
          ),
        ),
        body: _loading
            ? Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor)),
              )
            : Container(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Email',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.nunito(),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            child: TextFormField(
                                controller: _emailController,
                                textCapitalization: TextCapitalization.none,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Ingresa un email";
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
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
                                  contentPadding: EdgeInsets.all(15),
                                )),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Contraseña',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.nunito(),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            child: TextFormField(
                                controller: _passwordController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Ingresa una contraseña";
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.text,
                                obscureText: _hidden ? true : false,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
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
                                  contentPadding: EdgeInsets.all(15),
                                  suffixIcon: IconButton(
                                    icon: _hidden
                                        ? Icon(Icons.visibility,
                                            color: primaryColor)
                                        : Icon(Icons.visibility_off,
                                            color: primaryColor),
                                    onPressed: _toggleVisibility,
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(top: 5.0, bottom: 15.0),
                            child: InkWell(
                              child: Text(
                                'Olvidé la contraseña',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor),
                              ),
                              onTap: () {
                                _navigateForgotPassword(context);
                              },
                            ),
                          ),
                          StreamBuilder<bool>(
<<<<<<< HEAD
                            stream: null,
=======
>>>>>>> main
                            builder: (context, snapshot) => ButtonTheme(
                                minWidth: size.width,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFFF0094),
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  onPressed: () {
                                    onSubmitForm(context);
                                  },
                                  child: Text(
                                    "Ingresar",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
<<<<<<< HEAD
=======
                            stream: null,
>>>>>>> main
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: <Widget>[
                              RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'Poppins'),
                                      children: [
                                    TextSpan(text: '¿Aún no estás registrado?'),
                                    TextSpan(
                                        text: '  Regístrate',
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.w900),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            _navigateToSignUp(context);
                                          })
                                  ]))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
  }
}
