import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lua_app/controllers/main_controller.dart';
import 'package:lua_app/global_colors.dart';
import 'package:lua_app/screens/main/profile_screen.dart';

class MainBottomNavbar extends GetView<MainController> {
  const MainBottomNavbar({super.key});
  final List<Widget> _screens = const [
    ProfileScreen(),
    ProfileScreen(),
    ProfileScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return _screens[controller.currentNavIndex.value];
        },
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: controller.changeNavIndex,
          currentIndex: controller.currentNavIndex.value,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              label: 'home'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              label: 'exercise'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              label: 'articles'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline_outlined),
              label: 'account'.tr,
            ),
          ],
          backgroundColor: Colors.white,
          showUnselectedLabels: true,
          iconSize: 24,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedItemColor: GlobalColors.primaryColor,
          unselectedItemColor: GlobalColors.greyColor,
        ),
      ),
    );
  }
}
