import '../../share/controller/screen_export.dart';

class SuccessScreenArgs {
  const SuccessScreenArgs({
    required this.title,
    required this.subtitle,
    this.buttonText,
    this.onButtonTap,
    this.autoNavigateAfter,
    this.onAutoNavigate,
  });

  final String title;
  final String subtitle;
  final String? buttonText;
  final VoidCallback? onButtonTap;
  final Duration? autoNavigateAfter;
  final VoidCallback? onAutoNavigate;
}

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({
    super.key,
    required this.title,
    required this.subtitle,
    this.buttonText,
    this.onButtonTap,
    this.icon = Icons.check,
    this.iconColor = AppColors.success,
    this.autoNavigateAfter,
    this.onAutoNavigate,
  });

  final String title;
  final String subtitle;

  final String? buttonText;
  final VoidCallback? onButtonTap;

  final IconData icon;
  final Color iconColor;

  final Duration? autoNavigateAfter;
  final VoidCallback? onAutoNavigate;

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();

    if (widget.buttonText == null &&
        widget.autoNavigateAfter != null &&
        widget.onAutoNavigate != null) {
      Future.delayed(widget.autoNavigateAfter!, () {
        if (!mounted) return;
        widget.onAutoNavigate!();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            children: [
              const Spacer(),

              /// Success Icon
              Center(
                child: Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor.withValues(alpha: 0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: widget.iconColor, width: 2.5),
                      ),
                      child: Icon(
                        widget.icon,
                        color: widget.iconColor,
                        size: 28.sp,
                      ),
                    ),
                  ),
                ),
              ),

              Gap(40.h),

              /// Title
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: context.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),

              Gap(16.h),

              /// Subtitle
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  widget.subtitle,
                  textAlign: TextAlign.center,
                  style: context.bodyLarge.copyWith(
                    color: AppColors.subtitleTextColor,
                    height: 1.5,
                  ),
                ),
              ),

              const Spacer(),

              /// Optional Button
              if (widget.buttonText != null)
                CustomButton(
                  text: widget.buttonText!,
                  onTap: widget.onButtonTap ?? () {},
                ),

              if (widget.buttonText != null) Gap(16.h),
            ],
          ),
        ),
      ),
    );
  }
}
