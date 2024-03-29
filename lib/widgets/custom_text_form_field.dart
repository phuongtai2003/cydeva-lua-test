import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lua_app/global_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
    this.isOnlyNumber = false,
  });
  final TextEditingController controller;
  final String labelText;
  final Icon? suffixIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool isOnlyNumber;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      keyboardType: isOnlyNumber ? TextInputType.number : TextInputType.text,
      controller: controller,
      onTap: onTap,
      style: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: GlobalColors.greyColor,
            width: 1,
          ),
        ),
        enabledBorder: readOnly
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: GlobalColors.greyColor,
                  width: 1,
                ),
              )
            : null,
        focusedBorder: readOnly
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: GlobalColors.greyColor,
                  width: 1,
                ),
              )
            : null,
        suffixIcon: suffixIcon,
        label: RichText(
          text: TextSpan(
            text: '$labelText ',
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 12,
            ),
            children: const <TextSpan>[
              TextSpan(
                text: '*',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        hintText:
            '${readOnly ? 'choose'.tr : 'enter'.tr} ${labelText.toLowerCase()}',
        hintStyle: GoogleFonts.montserrat(
          color: GlobalColors.greyColor,
          fontSize: 14,
        ),
      ),
      onTapOutside: (value) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '${readOnly ? 'choose'.tr : 'please_enter'.tr} ${labelText.toLowerCase()}';
        }
        else if(isOnlyNumber && value.length != 10){
          return 'please_enter_valid_phone_number'.tr;
        }
        return null;
      },
    );
  }
}
