import 'package:get/get.dart';

class NotificationModel {
  final String id;
  final String toId;
  final String title;
  final String description;
  final String time;
  final RxBool isUnread;

  NotificationModel({
    required this.id,
    required this.toId,
    required this.title,
    required this.description,
    required this.time,
    required bool isUnread,
  }) : isUnread = isUnread.obs;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] ?? '',
      toId: json['toId'] ?? '',
      title: json['title'] ?? '',
      description: json['message'] ?? '',
      time: json['createdAt'] ?? '',
      isUnread: !(json['isRead'] ?? false),
    );
  }
}
