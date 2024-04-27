import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PasswordFelid extends StatefulWidget {
  PasswordFelid({super.key, this.onChanged, required this.controller});
  Function(String)? onChanged;
  TextEditingController controller;
  @override
  State<PasswordFelid> createState() => _PasswordFelidState();
}

class _PasswordFelidState extends State<PasswordFelid> {
  bool? obscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'This Field is Required.';
        } else if (value!.length < 8) {
          return 'This Field Must be greater than 8 characters.';
        } else if (value.length > 50) {
          return 'length must be less than 50  Characters.';
        }
        return null;
      },
      onChanged: widget.onChanged,
      obscureText: obscure!,
      controller: widget.controller,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(22),
        filled: true,
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
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: .5),
          borderRadius: BorderRadius.circular(5000),
        ),
        hintText: 'Enter your Password',
        suffixIcon: IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onPressed: () {
              setState(() {
                obscure = !obscure!;
              });
            },
            icon: ((!obscure!)
                ? const Icon(
                    Icons.visibility,
                  )
                : const Icon(
                    Icons.visibility_off,
                  ))),
      ),
    );
  }
}
