import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lua_app/controllers/profile_controller.dart';
import 'package:lua_app/global_colors.dart';
import 'package:lua_app/route_names.dart';
import 'package:lua_app/widgets/profile_button.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext cntext) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ..._buildHeader(cntext),
            const SizedBox(
              height: 52,
            ),
            _buildProfileOptions(cntext),
            const SizedBox(
              height: 52,
            ),
            _buildDeleteAccountBtn(cntext),
            const SizedBox(
              height: 18,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildHeader(BuildContext cntext) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18).copyWith(
          top: 16,
          bottom: 8,
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Obx(
                () {
                  if (controller.user != null) {
                    if (controller.pickedImagePath != null) {
                      return SizedBox(
                        width: 60,
                        height: 60,
                        child: CircleAvatar(
                          backgroundImage: FileImage(
                            File(
                              controller.pickedImagePath!,
                            ),
                          ),
                          radius: 60,
                        ),
                      );
                    }
                    return SizedBox(
                      width: 60,
                      height: 60,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(controller.user!.avatar),
                        radius: 60,
                      ),
                    );
                  } else {
                    return const SizedBox(
                      height: 60,
                      width: 60,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                        radius: 60,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: GlobalColors.greyColor,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => Text(
                          controller.user?.fullName ?? '',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'newcomer'.tr,
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: ProfileButton(
          onPressed: () {
            Get.toNamed(
              RouteNames.editProfile,
            );
          },
          icon: const Icon(
            Icons.person_outline,
            size: 24,
          ),
          text: 'my_account'.tr,
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: _buildRegisterCoachBtn(cntext),
      ),
    ];
  }

  Widget _buildRegisterCoachBtn(BuildContext cntext) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Image.asset(
                  'assets/images/coach_register_button_img.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/register_coach_icon.svg',
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    'register_to_become_coach'.tr,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: GlobalColors.primaryColor,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.chevron_right,
                    color: GlobalColors.primaryColor,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOptions(BuildContext cntext) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            ProfileButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/images/dollar-sign.svg'),
              text: 'subscription_package'.tr,
            ),
            ProfileButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/images/language.svg'),
              text: 'language'.tr,
            ),
            ProfileButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/images/payment.svg'),
              text: 'payment'.tr,
            ),
            ProfileButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/images/question_mark.svg'),
              text: 'support_center'.tr,
            ),
            ProfileButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/images/privacy.svg'),
              text: 'privacy_and_security'.tr,
            ),
            ProfileButton(
              onPressed: () {
                controller.signOut();
              },
              hasBottomBorder: false,
              textColor: Colors.red,
              icon: SvgPicture.asset('assets/images/log-out.svg'),
              text: 'logout'.tr,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteAccountBtn(BuildContext cntext) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/trash.svg'),
              const SizedBox(
                width: 8,
              ),
              Text(
                'delete_account'.tr,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
