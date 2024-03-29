import 'package:get/get.dart';

class SelectTopicsController extends GetxController {
  final List<String> topics = [
    'Vinyasa',
    'Hatha',
    'Kids Yoga',
    'Restorative',
    'Meditation',
    'Prenatal/Postnatal',
    'Core',
    'HIIT',
    'Astanga',
    'Singing Bowl Therapy',
    'Dance',
    'Sculpt',
    'Pilates',
    'Strength',
  ];

  final List<String> selectedTopics = <String>[].obs;

  void toggleTopic(String topic) {
    if (selectedTopics.contains(topic)) {
      selectedTopics.remove(topic);
    } else {
      selectedTopics.add(topic);
    }
  }
}
