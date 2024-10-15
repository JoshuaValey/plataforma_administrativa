import 'package:flutter/material.dart';

class GreenButton extends StatelessWidget {

  
  final String label;
  final VoidCallback onPressed;

  const GreenButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext   context) {

final colors = Theme.of(context).colorScheme;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
