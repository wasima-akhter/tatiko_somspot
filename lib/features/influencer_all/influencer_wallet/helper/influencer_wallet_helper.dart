enum InfluencerWalletTab { withdraw, analytics }

extension InfluencerWalletTabExtension on InfluencerWalletTab {
  String get displayName {
    switch (this) {
      case InfluencerWalletTab.withdraw:
        return "Withdraw";

      case InfluencerWalletTab.analytics:
        return "Analytics";
    }
  }
}

//
enum WalletAnalyticsPeriod { sevenDays, thirtyDays, all }

extension WalletAnalyticsPeriodExtension on WalletAnalyticsPeriod {
  String get displayName {
    switch (this) {
      case WalletAnalyticsPeriod.sevenDays:
        return "7D";

      case WalletAnalyticsPeriod.thirtyDays:
        return "30D";

      case WalletAnalyticsPeriod.all:
        return "All";
    }
  }

  String get apiValue {
    switch (this) {
      case WalletAnalyticsPeriod.sevenDays:
        return "7d";

      case WalletAnalyticsPeriod.thirtyDays:
        return "30d";

      case WalletAnalyticsPeriod.all:
        return "all";
    }
  }
}
