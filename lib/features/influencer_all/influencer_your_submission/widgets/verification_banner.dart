import '../../../../share/export/screen_export.dart';

enum SubmissionStatus { verified, pendingReview }

class VerificationBanner extends StatelessWidget {
  const VerificationBanner({super.key, required this.status});

  final SubmissionStatus status;

  @override
  Widget build(BuildContext context) {
    final isVerified = status == SubmissionStatus.verified;

    final backgroundColor = isVerified
        ? Colors.green.shade50
        : Colors.orange.shade50;

    final iconColor = isVerified ? Colors.green : Colors.orange;

    final title = isVerified
        ? AppStrings.publishedAndVerified.tr
        : AppStrings.pendingReview.tr;
    final subtitle = isVerified
        ? AppStrings.contentIsLiveEarned.trParams({"amount": "125.00"})
        : AppStrings.contentSubmittedWaitingApproval.tr;

    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),

            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),

            child: Icon(
              isVerified ? Icons.check : Icons.access_time_rounded,
              color: iconColor,
              size: 16,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: context.bodyMedium.copyWith(
                    color: iconColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                Text(subtitle, style: context.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
