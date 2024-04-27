import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.hint,
      this.onChanged,
      this.obscureText = false,
      this.icon,
      this.keyboardType = TextInputType.text,
      this.contentPadding,
      this.controller,
      this.focusNode,
      this.onFieldSubmitted});
  String hint;
  Function(String)? onChanged;
  bool obscureText;
  IconData? icon;
  TextInputType keyboardType;
  EdgeInsetsGeometry? contentPadding;
  TextEditingController? controller;
  FocusNode? focusNode;
  Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      controller: controller,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'This Field is Required.';
        } else if (value!.length < 8) {
          return 'This Field Must be greater than 8 characters.';
        } else if (value.length > 50) {
          return 'length must be less than 50  Characters.';
        } else {
          return null;
        }
      },
      onChanged: onChanged,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        suffixIcon: Icon(
          icon,
        ),
        contentPadding: const EdgeInsets.all(22),
        filled: true,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: .5),
          borderRadius: BorderRadius.circular(5000),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: .5),
          borderRadius: BorderRadius.circular(5000),
        ),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: .5),
            borderRadius: BorderRadius.circular(50)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: .5),
          borderRadius: BorderRadius.circular(5000),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: .5),
          borderRadius: BorderRadius.circular(5000),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: .5),
          borderRadius: BorderRadius.circular(5000),
        ),
        hintText: hint,
      ),
      keyboardType: keyboardType,
    );
  }
}
