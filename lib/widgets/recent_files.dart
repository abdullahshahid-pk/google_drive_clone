import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/constants.dart';
import 'package:google_drive_clone/controllers/files_screen_controller.dart';

class RecentFiles extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text('Recent Files', style: textStyle(20, textColor, FontWeight.bold),),
        ),
        SizedBox(height: 15,),
        GetX<FilesScreenController>(
          builder: (FilesScreenController controller){
            return Container(
              height: 100,
              child: ListView.builder(
                itemCount: controller.recentFileList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.only(right: 5, left: 5),
                    child: Container(
                      height: 90,
                      width: 60,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          controller.recentFileList[index].type == 'image' ?
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image(
                              width: 60,
                              height: 75,
                              image: NetworkImage(controller.recentFileList[index].url),
                              fit: BoxFit.cover,),
                          ) : Container(
                            height: 75,
                            width: MediaQuery.of(context).size.width/2.5,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 0.2),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: Image(
                                width: 50,
                                height: 55,
                                image: AssetImage('assets/images/${controller.recentFileList[index].ext}.png'),
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(controller.recentFileList[index].name, overflow: TextOverflow.ellipsis,
                            style: textStyle(13, textColor, FontWeight.w500),),
                        ],
                      ),
                    ),
                  );
                  }
              ),
            );
          }
        ),
      ],
    );
  }
}
