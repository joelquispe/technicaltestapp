import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final TextInputType keyboardType;
  final void Function(String)? onSubmitted;
  const CustomTextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    required this.keyboardType,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller, // Observa el contenido del controlador
      builder: (context, value, child) {
        return TextField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            label: Text(label),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            suffixIcon: value.text.isNotEmpty // Muestra el ícono solo si el campo no está vacío
                ? IconButton(
                    icon: const Icon(Icons.close_rounded,size: 20,), // Ícono de limpieza
                    onPressed: () {
                      controller.clear(); // Limpia el contenido del TextField
                    },
                  )
                : null, // No muestra nada si el campo está vacío
          ),
          onSubmitted: (value) {
            onSubmitted?.call(value);
          },
        );
      },
    );
  }
}
