import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/text_field/custom_text_field.dart';
import '../widgets/influencer_apply_account_card.dart';
import '../widgets/influencer_apply_campaign_card.dart';

class ApplyCampaignScreen extends StatefulWidget {
  const ApplyCampaignScreen({super.key});

  @override
  State<ApplyCampaignScreen> createState() => _ApplyCampaignScreenState();
}

class _ApplyCampaignScreenState extends State<ApplyCampaignScreen> {
  final TextEditingController _reasonController = TextEditingController();

  int selectedAccount = 0;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: AppColors.backgroundColorNew,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(12),

              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new, size: 20),
                  ),
                  const Gap(12),
                  Text(
                    "Apply for Campaign",
                    style: context.titleMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const Gap(24),

              const CampaignCard(),

              const Gap(24),

              Text(
                "Why are you a good fit?",
                style: context.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkTextColor,
                ),
              ),

              const Gap(10),

              CustomTextField(
                controller: _reasonController,
                hintText:
                    "Tell the merchant why your audience would love this offer...",
                maxLines: 5,
              ),

              const Gap(24),

              Text(
                "Select Accounts to Use",
                style: context.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkTextColor,
                ),
              ),

              const Gap(12),

              AccountTile(
                selected: selectedAccount == 0,
                onTap: () => setState(() => selectedAccount = 0),
                icon: Iconsax.video,
                iconColor: Colors.black,
                title: "TikTok (@ahmed_creates)",
                followers: "50K Followers",
              ),

              const Gap(12),

              AccountTile(
                selected: selectedAccount == 1,
                onTap: () => setState(() => selectedAccount = 1),
                icon: Iconsax.instagram,
                iconColor: Colors.pink,
                title: "Instagram (@ahmed_creates)",
                followers: "22K Followers",
              ),

              const Gap(30),

              CustomButton(text: "Submit Application", onTap: () {}),

              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
