import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/constants.dart';
import 'package:google_drive_clone/controllers/nav_controller.dart';

class Header extends StatelessWidget {

  NavController navController = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text('Clone Drive', style: textStyle(28, textColor, FontWeight.bold),),
          SizedBox(height: 20,),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 20, right: 20),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  offset: Offset(10, 10),
                  blurRadius: 10,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  offset: Offset(-10, 10),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Obx(()=>
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap:()=> navController.changeTab('Storage'),
                    child: tabCell('Storage',navController.tab.value == 'Storage' ? true : false, context),
                  ),
                  InkWell(
                    onTap:()=> navController.changeTab('Files'),
                    child: tabCell('Files',navController.tab.value == 'Files' ? true : false, context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tabCell(String text, bool isSelect, BuildContext  context) {
    return isSelect ? Container(
      padding: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width*0.44,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.deepOrangeAccent,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(10, 10),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(-10, 10),
            blurRadius: 10,
          ),
        ],
      ),
      child: Center(
        child: Text(text, style: textStyle(23,Colors.white, FontWeight.bold),),
      ),
    ) : Container(
      padding: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width*0.44,
      height: 60,
      child: Center(
        child: Text(text, style: textStyle(23,textColor , FontWeight.bold),
        ),
      ),
    );
  }
}
