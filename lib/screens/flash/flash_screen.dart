import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lua_app/controllers/flash_controller.dart';
import 'package:lua_app/global_colors.dart';

class FlashScreen extends GetView<FlashController> {
  const FlashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.primaryColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/app_icon.png',
            ),
            const SizedBox(height: 38),
            const Text(
              'LUA',
              style: TextStyle(
                fontFamily: 'Nico Moji',
                color: Colors.white,
                fontSize: 80,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
