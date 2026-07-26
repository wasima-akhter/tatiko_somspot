// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:health_tracker_app/share/widgets/button/custom_button.dart';
// import 'package:health_tracker_app/utils/app_strings/app_strings.dart';
// import 'package:health_tracker_app/utils/color/app_colors.dart';
// import 'package:health_tracker_app/utils/extension/base_extension.dart';
// import 'package:pinput/pinput.dart';
//
// class VerifyOtpScreen extends StatefulWidget {
//   const VerifyOtpScreen({super.key});
//
//   @override
//   State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
// }
//
// class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
//   final _pinController = TextEditingController();
//
//   @override
//   void dispose() {
//     _pinController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Determine screen height/width if needed, or just use spacing
//     final defaultPinTheme = PinTheme(
//       width: 56,
//       height: 60,
//       textStyle: context.titleLarge.copyWith(
//         fontWeight: FontWeight.bold,
//         color: AppColors.blackMainTextColor,
//       ),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         border: Border.all(color: AppColors.linesDarkColor),
//         borderRadius: BorderRadius.circular(12),
//       ),
//     );
//
//     final focusedPinTheme = defaultPinTheme.copyDecorationWith(
//       border: Border.all(color: AppColors.primaryColor),
//     );
//
//     return ScaffoldWrapper(
//       backgroundColor: AppColors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Back Button
//               GestureDetector(
//                 onTap: () => Navigator.pop(context),
//                 child: Container(
//                   width: 48,
//                   height: 48,
//                   decoration: const BoxDecoration(
//                     color: AppColors.primaryColor,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.arrow_back_ios_new,
//                     color: AppColors.white,
//                     size: 20,
//                   ),
//                 ),
//               ),
//               const Gap(32),
//
//               // Title
//               Text(
//                 AppStrings.enterYour6DigitCode.tr,
//                 style: context.headlineMedium.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.blackMainTextColor,
//                 ),
//               ),
//               const Gap(8),
//
//               // Subtitle
//               Text(
//                 AppStrings.enterOtpSubtitle.tr,
//                 style: context.bodyMedium.copyWith(
//                   color: AppColors.grayTextSecondaryColor,
//                 ),
//               ),
//               const Gap(32),
//
//               // OTP Fields
//               Center(
//                 child: Pinput(
//                   length: 6,
//                   controller: _pinController,
//                   defaultPinTheme: defaultPinTheme,
//                   focusedPinTheme: focusedPinTheme,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   onCompleted: (pin) {
//                     // Handle PIN completion
//                   },
//                 ),
//               ),
//               const Gap(32),
//
//               // Continue Button
//               CustomButton(
//                 text: AppStrings.continueText.tr,
//                 onTap: () {
//                   // Handle Validate OTP
//                 },
//               ),
//               const Gap(24),
//
//               // Resend OTP
//               Center(
//                 child: RichText(
//                   text: TextSpan(
//                     text: "${AppStrings.haventReceivedOtp.tr} ",
//                     style: context.bodyMedium.copyWith(
//                       color: AppColors.blackMainTextColor,
//                     ),
//                     children: [
//                       TextSpan(
//                         text: AppStrings.resendOtp.tr,
//                         style: context.bodyMedium.copyWith(
//                           color: AppColors.primaryColor,
//                           fontWeight: FontWeight.w600,
//                         ),
//                         // Recognizer can be added here
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
