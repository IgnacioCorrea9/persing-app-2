import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Widget used to show Labeled textFormFields on profileScreen
class LabeledTextFormField extends StatelessWidget {
  /// Constructor
  const LabeledTextFormField({
    super.key,
    required this.controller,
    this.enabled = true,
    this.hintText = '',
    this.inputFormatters = const [],
    this.labelText = '',
    required this.validator,
    this.keyboardType = TextInputType.text,
  });

  /// TextFormField controller
  final TextEditingController controller;

  /// Hint text to show on textfield
  final String hintText;

  /// Text to show above textfield
  final String labelText;

  /// TextField validator
  final String Function(String?)? validator;

  /// If textfield is enabled or not\
  final bool enabled;

  /// Text formatter for textField
  final List<TextInputFormatter> inputFormatters;

  /// KeyBoardType to use on textField
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 25,
          child: Text(
            labelText,
            textAlign: TextAlign.left,
          ),
        ),
        Material(
          elevation: 5,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            validator: validator,
            inputFormatters: inputFormatters,
            enabled: enabled,
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              focusedBorder: InputBorder.none,
              hintText: hintText,
              filled: true,
              fillColor: Colors.white,
              isDense: true,
              contentPadding: EdgeInsets.all(12),
            ),
          ),
        ),
      ],
    );
  }
}
