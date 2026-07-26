import 'package:get/get.dart';

class MerchantPricingController extends GetxController {
  static MerchantPricingController get to => Get.find();
  final packages = [
    PricingModel(
      title: "20 Seconds Video",
      subtitle: "Short Video • 20s",
      description: "A little more room to show the offer in action.",
      price: "\$5",
    ),

    PricingModel(
      title: "30 Seconds Video",
      subtitle: "Standard Video • 30s",
      description: "The most popular format for local campaigns.",
      price: "\$7",
    ),

    PricingModel(
      title: "45 Seconds Video",
      subtitle: "Extended Video • 45s",
      description: "Great for storytelling and product walkthroughs.",
      price: "\$10",
    ),

    PricingModel(
      title: "60 Seconds Video",
      subtitle: "Long Video • 60s",
      description: "Full narrative, maximum detail and reach.",
      price: "\$15",
    ),
  ];
}

class PricingModel {
  final String title;
  final String subtitle;
  final String description;
  final String price;

  PricingModel({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.price,
  });
}
