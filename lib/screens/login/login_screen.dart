import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lua_app/controllers/login_controller.dart';
import 'package:lua_app/enums.dart';
import 'package:lua_app/global_colors.dart';
import 'package:lua_app/route_names.dart';
import 'package:lua_app/widgets/custom_button.dart';
import 'package:lua_app/widgets/social_button.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  void _openChooseLanguageBottomSheet() async {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              12,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'choose_language'.tr,
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/vie.svg',
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'vietnamese'.tr,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    Obx(
                      () => Radio<LanguageKey>(
                        value: LanguageKey.vi,
                        groupValue: controller.selectedLanguage.value,
                        onChanged: (value) {
                          controller.changeLanguage(value!);
                        },
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 16,
                  thickness: 0.5,
                  color: GlobalColors.greyColor,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/uk.svg',
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'english'.tr,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    Obx(
                      () => Radio<LanguageKey>(
                        value: LanguageKey.en,
                        groupValue: controller.selectedLanguage.value,
                        onChanged: (value) {
                          controller.changeLanguage(value!);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                CustomButton(
                  onTap: () {
                    Get.back();
                  },
                  text: 'confirm'.tr,
                  buttonColor: GlobalColors.primaryColor,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext cntext) {
    return SafeArea(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 1],
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 44,
                ),
                _buildLanguageButton(cntext),
                ..._buildIntroText(cntext),
                const Spacer(),
                ..._buildSocialLoginButtons(cntext),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageButton(BuildContext cntext) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: _openChooseLanguageBottomSheet,
          child: Obx(
            () => SvgPicture.asset(
              controller.selectedLanguage.value == LanguageKey.vi
                  ? 'assets/images/vie.svg'
                  : 'assets/images/uk.svg',
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildIntroText(BuildContext cntext) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Text(
          'welcome_text'.tr,
          style: GoogleFonts.robotoSerif(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
      const SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Text(
          'Sed vel turpis adipiscing penatibus orci neque. Erat sed fermentum ipsum vel quis quam. Nunc etiam dui tortor, non in aliquam lacinia tempor.',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildSocialLoginButtons(BuildContext cntext) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: SocialButton(
          onTap: () {
            Get.offAllNamed(RouteNames.pickTopic);
          },
          text: 'sign_in_with_apple'.tr,
          buttonColor: Colors.white,
          prefixIcon: SvgPicture.asset(
            'assets/images/apple.svg',
          ),
        ),
      ),
      const SizedBox(height: 12),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: SocialButton(
          onTap: () {
            controller.signInWithGoogle();
          },
          text: 'sign_in_with_google'.tr,
          buttonColor: Colors.white,
          prefixIcon: SvgPicture.asset(
            'assets/images/google.svg',
          ),
        ),
      ),
      const SizedBox(height: 12),
    ];
  }
}
