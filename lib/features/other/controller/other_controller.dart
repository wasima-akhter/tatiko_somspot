/*
import 'package:get/get.dart';
import 'package:percel_delivery_app/core/di/injection.dart';
import 'package:percel_delivery_app/core/service/datasource/local/local_service.dart';
import 'package:percel_delivery_app/core/service/datasource/remote/api_client.dart';
import 'package:percel_delivery_app/features/other/model/terms_conditions_model.dart';
import 'package:percel_delivery_app/utils/enum/app_enum.dart';

class OtherController extends GetxController{
  final ApiClient apiClient = sl<ApiClient>();
  final LocalService localService = sl<LocalService>();


  /// ============================= GET Terms Condition =====================================
  final Rx<TermsConditionsModel> termsConditionsData = TermsConditionsModel().obs;
  final Rx<ApiStatus> termsLoading = ApiStatus.completed.obs;
  void termsLoadingMethod(ApiStatus status) => termsLoading.value = status;
*/
/*
  Future<void> getTermsCondition() async {
    termsLoadingMethod(ApiStatus.loading);
    var response = await apiClient.get(url: ApiUrl.termsConditions(),showResult: true);
    if (response.statusCode == 200) {
      termsConditionsData.value = TermsConditionsModel.fromJson(response.body);
      termsLoadingMethod(ApiStatus.completed);
    } else {
      if (response.statusCode == 503) {
        termsLoadingMethod(ApiStatus.internetError);
      } else if (response.statusCode == 404) {
        termsLoadingMethod(ApiStatus.noDataFound);
      } else {
        termsLoadingMethod(ApiStatus.error);
      }
    }
  }*/ /*

  /// ============================= GET Privacy Policy =====================================
  final Rx<TermsConditionsModel> privacyConditionsData = TermsConditionsModel().obs;
  final Rx<ApiStatus> privacyLoading = ApiStatus.completed.obs;
  void privacyLoadingMethod(ApiStatus status) => privacyLoading.value = status;

*/
/*  Future<void> getPrivacyPolicy() async {
    privacyLoadingMethod(ApiStatus.loading);
    var response = await apiClient.get(url: ApiUrl.privacyPolicy(),showResult: true);
    if (response.statusCode == 200) {
      privacyConditionsData.value = TermsConditionsModel.fromJson(response.body);
      privacyLoadingMethod(ApiStatus.completed);
    } else {
      if (response.statusCode == 503) {
        privacyLoadingMethod(ApiStatus.internetError);
      } else if (response.statusCode == 404) {
        privacyLoadingMethod(ApiStatus.noDataFound);
      } else {
        privacyLoadingMethod(ApiStatus.error);
      }
    }
  }*/ /*


*/
/*  /// ============================= GET Contact Number =====================================
  final Rx<String> contactNumber = "".obs;
  final Rx<ApiStatus> contactLoading = ApiStatus.completed.obs;
  void contactLoadingMethod(ApiStatus status) => contactLoading.value = status;

  Future<void> getContactNumber() async {
    contactLoadingMethod(ApiStatus.loading);
    var response = await apiClient.get(url: ApiUrl.contactNumber(),showResult: true);
    if (response.statusCode == 200) {
      final model = ContactNumberModel.fromJson(response.body);
      contactNumber.value = model.data?.contact??"";
      contactLoadingMethod(Status.completed);
    } else {
      if (response.statusCode == 503) {
        contactLoadingMethod(Status.internetError);
      } else if (response.statusCode == 404) {
        contactLoadingMethod(Status.noDataFound);
      } else {
        contactLoadingMethod(Status.error);
      }
    }
  }*/ /*


  /// ============================= Patch Change Password =====================================
  final RxBool changePasswordLoading = false.obs;
  void changePasswordLoadingMethod(bool loading) => changePasswordLoading.value = loading;

  */
/*Future<void> changePassword({required Map<String, String> body}) async {
    changePasswordLoadingMethod(true);
    var response = await apiClient.patch(url: ApiUrl.changePassword(),body: body,showResult: true);
    if (response.statusCode == 200) {
      changePasswordLoadingMethod(false);
      toastMessage(message: "successful".tr);
      AppRouter.route.pop();
    } else {
      toastMessage(message: response.body['message'].toString());
      changePasswordLoadingMethod(false);
    }
  }*/ /*


*/
/*  /// ============================= Ticker Send =====================================
  final RxBool submitLoading = false.obs;
  void submitMethod(bool status) => submitLoading.value = status;

  void submitTicket({required Map<String, String> body, required TextEditingController description}) async {
    try{
      submitMethod(true);
      var response = await apiClient.post(body: body,url: ApiUrl.ticket(),showResult: true);

      if (response.statusCode == 200) {
        submitMethod(false);
        toastMessage(message: "successful".tr);
        description.clear();
        AppRouter.route.pop();
      } else {
        submitMethod(false);
        toastMessage(message: response.body?['message'].toString()??"something want wrong".tr);
      }
    }catch (err){
      submitMethod(false);
    }
  }*/ /*

  /// ============================= Ticker Send =====================================
  final RxBool deleteLoading = false.obs;
  void deleteMethod(bool status) => deleteLoading.value = status;

*/
/*  void deleteAccount({required String password}) async {
    try{
      deleteMethod(true);
      final roll = await dbHelper.getUserRole();
      final email = await dbHelper.getUserEmail();
      if(roll == "USER"){
        var response = await apiClient.delete(body: {
          "email": email,
          "password": password,
        },url: ApiUrl.deleteUser(),showResult: true);

        if (response.statusCode == 200) {
          deleteMethod(false);
          toastMessage(message: "successful".tr);
          await dbHelper.logOut();
        } else {
          deleteMethod(false);
          toastMessage(message: response.body?['message'].toString()??"something want wrong".tr);
        }
      }else if(roll == "PARTNER"){
        var response = await apiClient.delete(body: {
          "email": email,
          "password": password,
        },url: ApiUrl.deletePartner(),showResult: true);

        if (response.statusCode == 200) {
          deleteMethod(false);
          toastMessage(message: "successful".tr);
          await dbHelper.logOut();
        } else {
          deleteMethod(false);
          toastMessage(message: response.body?['message'].toString()??"something want wrong".tr);
        }
      }else{
        await dbHelper.logOut();
      }
    }catch (err){
      deleteMethod(false);
    }
  }*/ /*

}*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/toast/toast_helper.dart';
import '../../../utils/app_strings/app_strings.dart';

class OtherController extends GetxController {
  static OtherController get to => Get.find();

  final formKey = GlobalKey<FormState>();

  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  final isSubmitting = false.obs;

  final List<FaqModel> faqs = const [
    FaqModel(
      question: "How do I claim a deal on SomSpot?",
      answer:
          "Go to any active offer on the Home or Saved screen, tap on the 'Claim' button. The coupon will be added to your My Claims list where you can click 'View' to present the QR code to the merchant to redeem.",
    ),
    FaqModel(
      question: "How long are deals valid?",
      answer:
          "Each deal has a specific expiry date indicated on its detail page and card. Make sure to redeem the deal before the timer or date runs out.",
    ),
    FaqModel(
      question: "Is SomSpot free to use?",
      answer:
          "Yes, SomSpot is 100% free for customers to discover nearby businesses, browse promotional discounts, and claim deals.",
    ),
    FaqModel(
      question: "Can I cancel a claimed deal?",
      answer:
          "Claimed deals will automatically expire if they are not used within their validity period. There is no need to manually cancel or remove them.",
    ),
  ];

  Future<void> submitMessage() async {
    if (!formKey.currentState!.validate()) return;

    isSubmitting.value = true;

    await Future.delayed(const Duration(seconds: 1));

    subjectController.clear();
    messageController.clear();

    isSubmitting.value = false;

    AppToast.success(message: AppStrings.messageSubmitted.tr);
  }

  @override
  void onClose() {
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }

  //
  // Rating app -->
  double rating = 3;

  String get ratingText {
    if (rating <= 1) return "Poor";
    if (rating <= 2) return "Fair";
    if (rating <= 3) return "Okay";
    if (rating <= 4) return "Good";
    return "Excellent";
  }

  void updateRating(double value) {
    rating = value;
    update();
  }
}

class FaqModel {
  final String question;
  final String answer;

  const FaqModel({required this.question, required this.answer});
}
