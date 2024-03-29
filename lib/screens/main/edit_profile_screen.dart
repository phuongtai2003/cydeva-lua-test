import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lua_app/controllers/profile_controller.dart';
import 'package:lua_app/enums.dart';
import 'package:lua_app/global_colors.dart';
import 'package:lua_app/widgets/custom_button.dart';
import 'package:lua_app/widgets/custom_text_form_field.dart';

class EditProfileScreen extends GetView<ProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext cntext) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(
          Icons.chevron_left,
          color: Colors.black,
          size: 24,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      centerTitle: true,
      title: Text(
        'personal_information'.tr,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext cntext) {
    return SafeArea(
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Stack(
                            children: [
                              Obx(
                                () {
                                  if (controller.user.value != null) {
                                    if (controller.pickedImage.value != null) {
                                      return CircleAvatar(
                                        backgroundImage: FileImage(
                                            controller.pickedImage.value!),
                                        radius: 60,
                                      );
                                    }
                                    return CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          controller.user.value!.avatar),
                                      radius: 60,
                                    );
                                  } else {
                                    return const CircleAvatar(
                                      backgroundImage: AssetImage(
                                        'assets/images/avatar.png',
                                      ),
                                      radius: 60,
                                    );
                                  }
                                },
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    controller.pickImage();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: GlobalColors.greyColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        ..._buildTextFields(cntext),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => controller.isLoading.value
                  ? Container(
                      color: Colors.black.withOpacity(0.1),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTextFields(BuildContext cntext) {
    return [
      Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 18).copyWith(bottom: 32),
        child: CustomTextFormField(
          controller: controller.nameController,
          labelText: 'name'.tr,
        ),
      ),
      Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 18).copyWith(bottom: 32),
        child: CustomTextFormField(
          controller: controller.genderController,
          labelText: 'gender'.tr,
          readOnly: true,
          suffixIcon: const Icon(
            Icons.keyboard_arrow_down,
            size: 24,
          ),
          onTap: controller.enablePickGender,
        ),
      ),
      Obx(
        () => Visibility(
          visible: !controller.isShowGenderDropdown.value,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18).copyWith(bottom: 32),
            child: CustomTextFormField(
              controller: controller.phoneNumController,
              labelText: 'phone_number'.tr,
              isOnlyNumber: true,
            ),
          ),
        ),
      ),
      Obx(
        () => Visibility(
          visible: !controller.isShowGenderDropdown.value,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18).copyWith(bottom: 32),
            child: CustomTextFormField(
              controller: controller.addressController,
              labelText: 'address'.tr,
            ),
          ),
        ),
      ),
      Obx(
        () => Visibility(
          visible: controller.isShowGenderDropdown.value,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18).copyWith(bottom: 18),
            child: _buildGenderDropdown(),
          ),
        ),
      ),
      Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 18).copyWith(bottom: 32),
        child: CustomTextFormField(
          controller: controller.emailController,
          labelText: 'Email',
        ),
      ),
      const SizedBox(height: 12),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: CustomButton(
          buttonColor: GlobalColors.primaryColor,
          onTap: () {
            controller.updateInformation();
          },
          text: 'confirm'.tr,
          textColor: Colors.white,
        ),
      ),
      const SizedBox(height: 12),
    ];
  }

  Widget _buildGenderDropdown() {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: GlobalColors.greyColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                controller.selectGender(Gender.male);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: controller.selectedGender.value == Gender.male
                      ? GlobalColors.greyColor
                      : Colors.white,
                ),
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text(
                  'male'.tr,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const Divider(
              height: 0,
              thickness: 1,
              color: GlobalColors.greyColor,
            ),
            InkWell(
              onTap: () {
                controller.selectGender(Gender.female);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: controller.selectedGender.value == Gender.female
                      ? GlobalColors.greyColor
                      : Colors.white,
                ),
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text(
                  'female'.tr,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const Divider(
              height: 0,
              thickness: 1,
              color: GlobalColors.greyColor,
            ),
            InkWell(
              onTap: () {
                controller.selectGender(Gender.unknown);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: controller.selectedGender.value == Gender.unknown
                      ? GlobalColors.greyColor
                      : Colors.white,
                ),
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text(
                  'unknown'.tr,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
