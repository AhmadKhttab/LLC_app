import 'package:flutter/material.dart';

class CustomTextField2 extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool readonly;
  final TextInputType keyboardType;
  final VoidCallback? ontap;
  const CustomTextField2({
    this.keyboardType = TextInputType.text,
    super.key,
    required this.labelText,
    required this.controller,
    this.validator,
    this.ontap,
    this.readonly = false,
  });

  @override
  State<CustomTextField2> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField2> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.ontap,
      readOnly: false,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.labelText,
      ),
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }
}
