import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lua_app/controllers/select_topics_controller.dart';
import 'package:lua_app/global_colors.dart';
import 'package:lua_app/route_names.dart';
import 'package:lua_app/widgets/custom_button.dart';

class SelectTopicsScreen extends GetView<SelectTopicsController> {
  const SelectTopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext cntext) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18).copyWith(
                top: 18,
                bottom: 32,
              ),
              child: Text(
                "Chọn chủ đề bạn yêu thích",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            _buildTopics(cntext),
            const Spacer(),
            _buildBottomButtons(cntext),
          ],
        ),
      ),
    );
  }

  Widget _buildTopics(BuildContext cntext) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(
        () => Wrap(
          direction: Axis.horizontal,
          spacing: 16,
          runSpacing: 16,
          children: controller.topics.map(
            (topic) {
              final isSelected = controller.selectedTopics.contains(topic);
              return GestureDetector(
                onTap: () => controller.toggleTopic(topic),
                child: _buildTopicItem(
                  topicName: topic,
                  isSelected: isSelected,
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }

  Widget _buildTopicItem(
      {required String topicName, required bool isSelected}) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 0,
        maxWidth: double.infinity,
      ),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? GlobalColors.primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: GlobalColors.primaryColor,
          width: 1,
        ),
      ),
      child: Text(
        topicName,
        style: GoogleFonts.montserrat(
          color: isSelected ? Colors.white : GlobalColors.primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext cntext) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18).copyWith(bottom: 18),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              onTap: () {
                Get.offAllNamed(
                  RouteNames.main,
                );
              },
              text: 'skip'.tr,
              buttonColor: Colors.white,
              textColor: GlobalColors.primaryColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: CustomButton(
              onTap: () {
                Get.offAllNamed(
                  RouteNames.main,
                );
              },
              text: 'confirm'.tr,
              buttonColor: GlobalColors.primaryColor,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
