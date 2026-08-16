import '../../../../share/export/screen_export.dart';
import '../../shared/response/offers_response.dart';
import 'offer_details_cover_section.dart';
import 'offer_details_info_section.dart';

class OfferDetailsPrimaryCard extends StatelessWidget {
  final OfferModel offer;

  const OfferDetailsPrimaryCard({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(16.r),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          OfferDetailsCoverSection(offer: offer),

          OfferDetailsInfoSection(offer: offer),
        ],
      ),
    );
  }
}
