import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final IconData? icon;

  const TextFieldInput({
    super.key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        controller: textEditingController,
        obscureText: isPass,
        decoration: InputDecoration(
          hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
            prefixIcon: Icon(
              icon,
              color: Colors.grey
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20
            ),
            border: InputBorder.none,
            filled: true,
            fillColor: Color(0xFFedf0f8),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  width: 2,
                  color: Colors.blue
              ),
            ),
        ),
      ),
    );
  }
}
