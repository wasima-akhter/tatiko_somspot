import 'package:flutter/material.dart';

import 'pending_content_card.dart';
import 'pending_post_link_card.dart';
import 'review_switcher.dart';

class ReviewTab extends StatefulWidget {
  const ReviewTab({super.key});

  @override
  State<ReviewTab> createState() => _ReviewTabState();
}

class _ReviewTabState extends State<ReviewTab> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReviewSwitcher(
          selected: selected,
          onChanged: (i) {
            setState(() {
              selected = i;
            });
          },
        ),

        const SizedBox(height: 18),

        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 5,
            itemBuilder: (_, index) {
              if (selected == 0) {
                return const PendingContentCard();
              }

              return const PendingPostLinkCard();
            },
          ),
        ),
      ],
    );
  }
}
