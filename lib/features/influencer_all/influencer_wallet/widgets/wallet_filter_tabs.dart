import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletFilterTabs extends StatefulWidget {
  const WalletFilterTabs({super.key});

  @override
  State<WalletFilterTabs> createState() => _WalletFilterTabsState();
}

class _WalletFilterTabsState extends State<WalletFilterTabs> {
  int selected = 1;

  final tabs = ["7D", "30D", "All"];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      decoration: BoxDecoration(
        color: const Color(0xffEFEFEF),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = selected == index;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selected = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? const Color(0xff4EA9FF)
                        : Colors.grey.shade700,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
