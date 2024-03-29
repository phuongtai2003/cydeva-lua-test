import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lua_app/enums.dart';
import 'package:lua_app/models/response/login_response_data.dart';
import 'package:lua_app/route_names.dart';
import 'package:lua_app/service/auth_service.dart';
import 'package:lua_app/service/profile_service.dart';

class ProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker;
  final AuthService _authService;
  final ProfileService _profileService;
  final RxBool isLoading = false.obs;

  ProfileController(
    this._authService,
    this._imagePicker,
    this._profileService,
  );

  final Rxn<UserData> user = Rxn<UserData>();
  final Rxn<File> pickedImage = Rxn<File>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();
  final phoneNumController = TextEditingController();
  final addressController = TextEditingController();
  final RxBool isShowGenderDropdown = false.obs;
  final Rxn<Gender> selectedGender = Rxn<Gender>();

  void selectGender(Gender gender) {
    selectedGender.value = gender;
    switch (gender) {
      case Gender.male:
        genderController.text = 'male'.tr.capitalizeFirst ?? '';
        break;
      case Gender.female:
        genderController.text = 'female'.tr.capitalizeFirst ?? '';
        break;
      case Gender.unknown:
        genderController.text = 'unknown'.tr.capitalizeFirst ?? '';
        break;
      default:
        genderController.text = 'unknown'.tr.capitalizeFirst ?? '';
    }
    isShowGenderDropdown.value = false;
  }

  void updateUser(UserData newUser) {
    user(newUser);
    nameController.text = newUser.fullName;
    emailController.text = newUser.email;
    genderController.text = newUser.gender.capitalizeFirst ?? '';
    phoneNumController.text = newUser.phoneNumber;
    addressController.text = newUser.address;
    switch (newUser.gender) {
      case 'male':
        selectedGender.value = Gender.male;
        break;
      case 'female':
        selectedGender.value = Gender.female;
        break;
      case 'unknown':
        selectedGender.value = Gender.unknown;
        break;
      default:
        selectedGender.value = Gender.unknown;
    }
  }

  void updateInformation() async {
    if ((formKey.currentState?.validate() ?? false) &&
        phoneNumController.text.isNotEmpty &&
        addressController.text.isNotEmpty) {
      String gender = 'unknown';
      isLoading.value = true;
      switch (selectedGender.value) {
        case Gender.male:
          gender = 'male';
          break;
        case Gender.female:
          gender = 'female';
          break;
        default:
          gender = 'unknown';
      }
      try {
        final res = await _profileService.updateProfile(
          fullName: nameController.text,
          phoneNumber: phoneNumController.text,
          gender: gender,
          address: addressController.text,
          email: emailController.text,
          avatar: pickedImage.value,
        );
        if (res != null) {
          user(res.data);
          pickedImage(null);
          Get.snackbar(
            'success'.tr,
            'update_profile_success'.tr,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } catch (e) {
        Get.snackbar(
          'error'.tr,
          'update_profile_failed'.tr,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      isLoading.value = false;
    }
  }

  void enablePickGender() {
    isShowGenderDropdown.value = !isShowGenderDropdown.value;
  }

  void pickImage() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        pickedImage.value = File(
          pickedFile.path,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
      Get.offAllNamed(RouteNames.login);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    genderController.dispose();
    phoneNumController.dispose();
    addressController.dispose();
  }
}
