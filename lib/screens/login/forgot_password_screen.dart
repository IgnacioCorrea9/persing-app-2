// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/providers/auth.dart';
import 'package:persing/widgets/appbar.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  void sendResetEmail(BuildContext ctx) async {
    try {
      final response = await Provider.of<Auth>(ctx, listen: false)
          .recoverPassword(_emailController.text);
      if (response) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Se ha enviado la nueva contraseña a tu correo electrónico.",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ));
      }
    } catch (error) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(
          "Error al recuperar la contraseña",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
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
            onPressed: () {},
          )),
      body: Builder(
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Escribe tu correo para cambiar contraseña',
                    style: TextStyle(fontSize: 14)),
                SizedBox(height: 10),
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                  ),
                ),
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  elevation: 5,
                  child: TextFormField(
                      controller: _emailController,
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                        hintText: "Escribe aquí",
                        filled: true,
                        fillColor: Colors.white,
                        isDense: true,
                        contentPadding: EdgeInsets.all(12),
                      )),
                ),
                SizedBox(height: 20),
                ButtonTheme(
                    minWidth: size.width,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Color(0xFFFF0094),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      onPressed: () {
                        sendResetEmail(ctx);
                      },
                      child: Text(
                        "Recuperar",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
