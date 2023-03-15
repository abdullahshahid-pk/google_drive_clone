import 'package:get/get.dart';

class NavController extends GetxController{
  RxString tab = 'Storage'.obs;

  changeTab(String currentTab){
    tab.value = currentTab;
  }
}