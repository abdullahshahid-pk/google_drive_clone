import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/controllers/nav_controller.dart';
import 'package:google_drive_clone/screens/files_screen.dart';
import 'package:google_drive_clone/screens/storage_screen.dart';
import 'package:google_drive_clone/widgets/floating_button.dart';
import 'package:google_drive_clone/widgets/header_widget.dart';

class NavScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(25),
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
              ),
          ),
          // floatingActionButton: Obx(()=> Get.find<NavController>().tab.value == 'Storage' ? Container():
          // FloatingButton()),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          body: Column(
            children: [
              Header(),
              Obx(()=> Get.find<NavController>().tab.value == 'Storage' ? StorageScreen() : FilesScreen()),
            ],
          ),
        ),
    );
  }
}
