import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companionapp/controllers/main_controller.dart';
import 'package:companionapp/enums/snackbar_message.dart';
import 'package:companionapp/models/food_request.dart';
import 'package:companionapp/services/request_service.dart';
import 'package:companionapp/widgets/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List<String> foodCategoryList = [
    '-- Select Food Category --',
    'Meat',
    'Vegetables',
    'Dairy',
    'Sea Food',
    'Nuts',
    'Fruits',
    'Grains',
  ];
  RxString selectedFoodCategory = '-- Select Food Category --'.obs;
  RxBool loading = false.obs;

  final MainController _mainController = Get.put(MainController());

  void addRequest() async {
    try {
      loading(true);
      FoodRequest foodRequest = FoodRequest(
        uid: _mainController.currentUser.value!.uid,
        name: _mainController.currentUser.value!.name,
        email: _mainController.currentUser.value!.email,
        foodCategory: selectedFoodCategory.value,
        dateAdded: Timestamp.now(),
      );
      await RequestService.saveRequest(foodRequest);
      selectedFoodCategory('-- Select Food Category --');
      loading(false);
      showSnackbar(SnackbarMessage.success, 'Request Added.');
    } catch (e) {
      loading(false);
      showSnackbar(SnackbarMessage.error, e.toString());
    }
  }

  bool validate() {
    if (selectedFoodCategory.value == '-- Select Food Category --') {
      showSnackbar(SnackbarMessage.error, 'Please select food category.');
      return false;
    } else {
      return true;
    }
  }
}
