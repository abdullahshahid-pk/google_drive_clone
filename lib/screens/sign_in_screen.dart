import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/constants.dart';
import 'package:google_drive_clone/controllers/auth_controller.dart';

class SignInScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
                end: Alignment.bottomLeft ,
                colors: [Colors.deepPurple, Colors.purpleAccent]
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 20),
                    child: Image(
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/app_main.png'),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(top: 25, bottom: 45),
                        child: Column(
                          children: [
                            Text('Simplify Yours', style: textStyle(25, Color(0xff635C9B), FontWeight.w700)),
                            Text('Filing System', style: textStyle(25, Color(0xff635C9B), FontWeight.w700)),
                            SizedBox(height: 20,),
                            Text('Keep Your Files', style: textStyle(20, textColor, FontWeight.w600)),
                            Text('organized more easily', style: textStyle(20, textColor, FontWeight.w600)),
                            SizedBox(height: 20,),
                            InkWell(
                              onTap: () => Get.find<AuthController>().signUp(),
                              child: Container(
                                width: MediaQuery.of(context).size.width/1.7,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.deepOrangeAccent.withOpacity(0.8),
                                ),
                                child: Center(
                                  child: Text("Let's go", style: textStyle(23, Colors.white, FontWeight.w700),),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
