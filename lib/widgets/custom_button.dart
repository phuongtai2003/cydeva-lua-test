import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lua_app/global_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.buttonColor,
    this.textColor = Colors.black,
  });
  final VoidCallback onTap;
  final String text;
  final Color buttonColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: double.infinity,
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            side:
                const BorderSide(color: GlobalColors.primaryColor, width: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(
            16,
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.montserrat(
            color: textColor,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
