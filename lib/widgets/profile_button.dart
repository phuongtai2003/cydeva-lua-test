import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lua_app/global_colors.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.text,
    this.textColor = Colors.black,
  }) : super(key: key);
  final VoidCallback onPressed;
  final Widget icon;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: GlobalColors.greyColor,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            const SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: textColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
