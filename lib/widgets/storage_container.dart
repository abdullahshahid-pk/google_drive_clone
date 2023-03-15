import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/constants.dart';
import 'package:google_drive_clone/controllers/storage_screen_controller.dart';

class StorageContainer extends StatelessWidget {

  StorageScreenController storageScreenController = Get.put(StorageScreenController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade100,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.001),
            offset: Offset(10, 10),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.001),
            offset: Offset(-10, 10),
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 25, bottom: 35),
        child: Obx(()=>
           Column(
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ((storageScreenController.size.value/1000000) * 100).toStringAsFixed(2),
                          style: textStyle(30, Color(0xff635C9B), FontWeight.bold),),
                        Text('%', style: textStyle(20, Color(0xff635C9B), FontWeight.bold),),
                      ],
                    ),
                    Text('Used', style: textStyle(24, Color(0xff635C9B).withOpacity(0.7), FontWeight.bold),),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 18,
                        width: 18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      SizedBox(width: 15,),
                      Column(
                        children: [
                          Text('Used',style: textStyle(18, textColor.withOpacity(0.7), FontWeight.w600),),
                          Text(getSize(storageScreenController.size.value),
                            style: textStyle(20, Color(0xff635C9B), FontWeight.w600),),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 18,
                        width: 18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 15,),
                      Column(
                        children: [
                          Text('Total',style: textStyle(18, textColor.withOpacity(0.7), FontWeight.w600),),
                          Text('1 GB',style: textStyle(20, Color(0xff635C9B), FontWeight.w600),),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

   getSize(int size) {
    if(size < 1000){
      return '$size KB';
    }
    else if(size < 1000000){
      int sizeMB = (size * 0.001).round();
      return '$sizeMB MB';
    }
    else{
      int sizeGB = (size * 0.000001).round();
      return '$sizeGB GB';
    }
   }
}
