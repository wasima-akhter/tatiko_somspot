import 'package:som_spot/share/controller/screen_export.dart';

class CampaignSectionTitle extends StatelessWidget {
  final String title;

  const CampaignSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: context.titleMedium);
  }
}
