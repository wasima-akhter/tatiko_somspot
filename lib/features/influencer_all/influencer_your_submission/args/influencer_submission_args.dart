import '../widgets/verification_banner.dart';

class InfluencerSubmissionArgs {
  final String applicationId;
  final SubmissionStatus status;

  const InfluencerSubmissionArgs({
    required this.applicationId,
    required this.status,
  });
}
