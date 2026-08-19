import 'package:flutter/material.dart';

import '../../../utils/enum/app_enum.dart';
import '../loading/loading_widget.dart';
import 'error_card.dart';
import 'no_data_card.dart';
import 'no_internet_card.dart';

class ApiStatusBuilder extends StatelessWidget {
  final ApiStatus status;
  final String? errorMessage;
  final VoidCallback onRetry;
  final WidgetBuilder builder;

  /// Custom loading widget
  final Widget? loadingWidget;

  /// Pagination
  final bool isLoadingMore;
  final bool hasMore;

  final Widget? noDataWidget;

  const ApiStatusBuilder({
    super.key,
    required this.status,
    required this.onRetry,
    required this.builder,
    this.errorMessage,
    this.loadingWidget,
    this.isLoadingMore = false,
    this.hasMore = false,
    this.noDataWidget,
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case ApiStatus.loading:
        return loadingWidget ?? const LoadingWidget();

      case ApiStatus.internetError:
        return NoInternetCard(onTap: onRetry);

      case ApiStatus.error:
        return ErrorCard(onTap: onRetry, message: errorMessage);

      case ApiStatus.noDataFound:
        return
        // HomeEmptyState(
        //       icon: Icons.location_off_outlined,
        //       title: 'No Nearby Places Yet',
        //       message:
        //           'We couldn’t find any businesses nearby right now.\n'
        //           'Try again to discover places around you.',
        //       onRetry: onRetry,
        //     )
        noDataWidget ?? NoDataCard(onTap: onRetry, buttonText: "Retry");

      case ApiStatus.completed:
        return SingleChildScrollView(
          child: Column(
            children: [
              builder(context),

              if (hasMore && isLoadingMore)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: LoadingWidget()),
                ),
            ],
          ),
        );
    }
  }
}
