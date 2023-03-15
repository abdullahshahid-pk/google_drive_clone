import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/screens/nav_screen.dart';
import 'package:google_drive_clone/screens/sign_in_screen.dart';

import 'controllers/auth_controller.dart';
import 'controllers/files_display_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: RootScreen(),
  )
  );
}

class RootScreen extends StatelessWidget {

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return authController.user.value == null ? SignInScreen() : NavScreen();
    });
  }
}

