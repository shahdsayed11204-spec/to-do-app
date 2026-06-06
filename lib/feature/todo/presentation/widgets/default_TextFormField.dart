import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onSubmit;
  final Function(String)? onChanged;
  final GestureTapCallback? onTap;
  final TextInputType type;
  final String label;
  final IconData prefix;
  final IconData? suffix;
  final bool isPassword;
  final String? Function(String?) validator;
  final VoidCallback? suffixPress;
  final bool isClickable;
  final OutlineInputBorder? border;
  final InputDecoration? decoration;

  const DefaultTextFormField({
    super.key,
    required this.controller,
    this.onSubmit,
    this.onChanged,
    this.onTap,
    required this.type,
    required this.label,
    required this.prefix,
    this.suffix,
    this.isPassword = false,
    required this.validator,
    this.suffixPress,
    this.isClickable = true,
    this.border,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: controller,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      onTap: onTap,
      enabled: isClickable,
      validator: validator,
      keyboardType: type,
      decoration: decoration ??
          InputDecoration(
            labelText: label,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            prefixIcon: Icon(prefix),
            suffixIcon: suffix != null
                ? IconButton(
              onPressed: suffixPress,
              icon: Icon(suffix),
            )
                : null,
          ),
    );
  }
}