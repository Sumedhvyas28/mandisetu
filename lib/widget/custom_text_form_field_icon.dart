import 'package:flutter/material.dart';

class CustomTextFormFieldWithIcon extends StatelessWidget {
  const CustomTextFormFieldWithIcon({super.key, required this.controller, required this.prefixIcon, required this.label});

  final TextEditingController controller;
  final IconData prefixIcon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none),
          enabledBorder: null,
          filled: true,
          fillColor: Colors.greenAccent.shade100.withOpacity(0.2),
          prefixIcon: Icon(prefixIcon),
          labelText: label,
          disabledBorder: InputBorder.none,
          labelStyle: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
