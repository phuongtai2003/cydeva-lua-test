import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.buttonColor,
    this.textColor = Colors.black,
    required this.prefixIcon,
  });
  final VoidCallback onTap;
  final String text;
  final Color buttonColor;
  final Color textColor;
  final Widget prefixIcon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
      ),
      child: Row(
        children: [
          prefixIcon,
          const SizedBox(
            width: 16,
          ),
          Text(
            text,
            style: GoogleFonts.montserrat(
              color: textColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
