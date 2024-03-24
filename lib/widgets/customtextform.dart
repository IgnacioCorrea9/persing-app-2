import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persing/core/colors.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    this.onChanged,
    this.validator,
    this.hint = '',
    this.label = '',
    this.isPassword = false,
    required this.prefixIcon,
    required this.suffixIcon,
    this.keyboardType,
    required this.controller,
    this.enable = true,
    this.readOnly = false,
    required this.maxLength,
    this.maxLines,
    required this.inputFormatters,
    this.capitalization,
    super.key,
  });

  final String hint;
  final String label;
  final bool isPassword;
  final String Function(String)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final TextEditingController controller;
  final bool enable;
  final bool readOnly;
  final int maxLength;
  final int? maxLines;
  final List<TextInputFormatter> inputFormatters;
  final TextCapitalization? capitalization;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: widget.capitalization ?? TextCapitalization.none,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enable,
      controller: widget.controller,
      obscureText: widget.isPassword && _obscureText,
      //validator: widget.validator ?? ()=> '',
      onChanged: widget.onChanged,
      readOnly: widget.readOnly,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines ?? 1,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFFFFFFF),
        hintText: widget.hint,
        labelText: widget.label,
        labelStyle: TextStyle(
          color: primaryColor,
          fontSize: 17,
        ),
        counterText: '',
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFDDDDDD), width: 2.5),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFFAFAFA), width: 2.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: BorderSide(
            color: const Color(0xFFDDDDDD).withOpacity(0.9),
            width: 2.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: const BorderSide(color: Color(0xFF54BDC8), width: 2.5),
        ),
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xFF143073),
                ),
                onPressed: () {
                  _obscureText = !_obscureText;
                  setState(() {});
                },
              )
            : widget.suffixIcon != null
                ? Icon(
                    widget.suffixIcon,
                    color: const Color(0xFF54BDC8),
                  )
                : null,
      ),
    );
  }
}
