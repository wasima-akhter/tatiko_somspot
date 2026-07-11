import 'package:flutter/material.dart';

import '../../../../utils/color/app_colors.dart';

class BackToTasksButton extends StatelessWidget {
  const BackToTasksButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),

      child: SizedBox(
        width: double.infinity,

        height: 46,

        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,

            elevation: 0,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          onPressed: () {
            Navigator.pop(context);
          },

          child: const Text(
            "Back to Tasks",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
