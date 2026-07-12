import 'package:flutter/material.dart';

class HelpSupportOnlineStatus extends StatelessWidget {
  const HelpSupportOnlineStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: const Color(0xFFD9ECFF),
            border: Border.all(color: const Color(0xFF4DA3FF)),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Icon(
            Icons.mail_outline,
            size: 18,
            color: Color(0xFF4DA3FF),
          ),
        ),
        const SizedBox(width: 10),
        const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Email Us ",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF4A4A4A),
                ),
              ),
              TextSpan(
                text: "Online",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
