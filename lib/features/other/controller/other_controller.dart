import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/toast/toast_helper.dart';
import '../../../utils/app_strings/app_strings.dart';

class OtherController extends GetxController {
  static OtherController get to => Get.find();

  final formKey = GlobalKey<FormState>();

  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  final isSubmitting = false.obs;

  final List<FaqModel> faqs = const [
    FaqModel(
      question: "How do I claim a deal on SomSpot?",
      answer:
          "Go to any active offer on the Home or Saved screen, tap on the 'Claim' button. The coupon will be added to your My Claims list where you can click 'View' to present the QR code to the merchant to redeem.",
    ),
    FaqModel(
      question: "How long are deals valid?",
      answer:
          "Each deal has a specific expiry date indicated on its detail page and card. Make sure to redeem the deal before the timer or date runs out.",
    ),
    FaqModel(
      question: "Is SomSpot free to use?",
      answer:
          "Yes, SomSpot is 100% free for customers to discover nearby businesses, browse promotional discounts, and claim deals.",
    ),
    FaqModel(
      question: "Can I cancel a claimed deal?",
      answer:
          "Claimed deals will automatically expire if they are not used within their validity period. There is no need to manually cancel or remove them.",
    ),
  ];

  Future<void> submitMessage() async {
    if (!formKey.currentState!.validate()) return;

    isSubmitting.value = true;

    await Future.delayed(const Duration(seconds: 1));

    subjectController.clear();
    messageController.clear();

    isSubmitting.value = false;

    AppToast.success(message: AppStrings.messageSubmitted.tr);
  }

  @override
  void onClose() {
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }

  //
  // Rating app -->
  double rating = 3;

  String get ratingText {
    if (rating <= 1) return "Poor";
    if (rating <= 2) return "Fair";
    if (rating <= 3) return "Okay";
    if (rating <= 4) return "Good";
    return "Excellent";
  }

  void updateRating(double value) {
    rating = value;
    update();
  }
}

class FaqModel {
  final String question;
  final String answer;

  const FaqModel({required this.question, required this.answer});
}
