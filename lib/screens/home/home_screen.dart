import 'package:companionapp/controllers/main_controller.dart';
import 'package:companionapp/res/app_colors.dart';
import 'package:companionapp/screens/auth/components/auth_button.dart';
import 'package:companionapp/screens/home/controllers/home_controller.dart';
import 'package:companionapp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MainController _mainController = Get.put(MainController());
  final HomeController _homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    _mainController.refreshCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(80.0),
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildFoodCategoryDropDown(size.width),
                      const SizedBox(height: 30),
                      Obx(
                        () => _homeController.loading.value
                            ? circularProgress()
                            : AuthButton(
                                onPressed: () {
                                  if (_homeController.validate()) {
                                    _homeController.addRequest();
                                  }
                                },
                                buttonText: 'Request Food',
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodCategoryDropDown(double width) {
    return Obx(
      () => Container(
        width: width * 0.8,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: AppColors.primaryColor,
            width: 1,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            borderRadius: BorderRadius.circular(16.0),
            value: _homeController.selectedFoodCategory.value,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: _homeController.foodCategoryList.map((String item) {
              return DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                    color: item == '-- Select Food Category --'
                        ? Colors.grey
                        : Colors.black,
                    fontSize: 18.0,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                _homeController.selectedFoodCategory(newValue);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: AppColors.primaryColor,
      height: 100.0,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      alignment: Alignment.center,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome,',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => Text(
                _mainController.currentUser.value!.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: 0.0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: TextButton.icon(
            onPressed: () => _mainController.logout(),
            icon: const Icon(
              FontAwesomeIcons.powerOff,
              color: Colors.red,
            ),
            label: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
