import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/providers/profile_provider.dart';
import 'package:provider/provider.dart';

openReviewDialog(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  return showDialog(
      context: context,
      builder: (context) {
        final profileProvider = Provider.of<ProfileProvider>(context);
        return AlertDialog(
            insetPadding: EdgeInsets.all(10),
            content: Form(
              key: _formKey,
              child: Container(
                  width: size.width * 0.8,
                  height: size.height * 0.5,
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Queremos saber más sobre tu experiencia con Persing",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: size.height * 0.013),
                        Text(
                          "¡Califícanos!",
                          style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: size.height * 0.013),
                        RatingBar.builder(
                          glow: false,
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Color(0xffFF0094),
                          ),
                          onRatingUpdate: (rating) {
                            profileProvider.rating = rating;
                          },
                        ),
                        SizedBox(height: size.height * 0.022),
                        Text("¿Tienes algún comentario para nosotros?",
                            style:
                                TextStyle(fontSize: 16, color: primaryColor)),
                        SizedBox(height: size.height * 0.013),
                        Material(
                            elevation: 5,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            child: TextFormField(
                              validator: (value) => profileProvider
                                      .reviewTextController.text.isNotEmpty
                                  ? null
                                  : 'Por favor ingresa tu comentario',
                              maxLines: 3,
                              controller: profileProvider.reviewTextController,
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
                                contentPadding: EdgeInsets.all(12),
                              ),
                            )),
                        SizedBox(height: size.height * 0.013),
                        Container(
                          margin: EdgeInsets.only(top: 5),
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
                                  backgroundColor: Colors.white,
                                ),
                                child: Text(
                                  "Cancelar",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  final isValid =
                                      _formKey.currentState!.validate();
                                  if (isValid) {
                                    await profileProvider.postFeedback(
                                        profileProvider.rating,
                                        profileProvider
                                            .reviewTextController.text);
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        "¡Gracias por tus comentarios!",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.green,
                                    ));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffFF0094),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 9, left: 18, right: 19),
                                ),
                                child: Text("Enviar",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ));
      });
}
