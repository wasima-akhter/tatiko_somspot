import 'package:flutter/material.dart';
import 'package:som_spot/core/custom_assets/assets.gen.dart';

import 'top_content_card.dart';

class TopContentList extends StatelessWidget {
  TopContentList({super.key});

  final List<Map<String, String>> contents = [
    {
      "image": Assets.images.foodimge.path,
      "title": "Best Pizza in Mogadishu! 🍕 Buy 1 Get 1 Free through SomSpot",
      "views": "12.5K",
      "likes": "845",
      "platform": "Instagram",
    },
    {
      "image": Assets.images.foodimge.path,
      "title": "You NEED to try this 🔥 Family platter is unreal",
      "views": "9.8K",
      "likes": "623",
      "platform": "Instagram",
    },
    {
      "image": Assets.images.foodimge.path,
      "title": "My honest review after eating here 3 times this week 😋",
      "views": "8.4K",
      "likes": "512",
      "platform": "Instagram",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(contents.length, (index) {
        final item = contents[index];

        return TopContentCard(
          image: item["image"]!,
          title: item["title"]!,
          views: item["views"]!,
          likes: item["likes"]!,
          platform: item["platform"]!,
        );
      }),
    );
  }
}
