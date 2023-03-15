import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/constants.dart';
import 'package:google_drive_clone/controllers/files_display_controller.dart';
import 'package:google_drive_clone/screens/display_files_screen.dart';

class UploadOptions extends StatelessWidget {

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
        padding: const EdgeInsets.only(top: 25, bottom: 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            coloredContainer(Colors.lightBlue.withOpacity(0.2),
                Icon(Icons.image_outlined, color: Colors.cyan, size: 40,),
                'image', 'Images'),
            coloredContainer(Colors.pink.withOpacity(0.3),
                Icon(Icons.play_arrow,  color: Colors.pink.withOpacity(0.3), size: 40,),
                'video', 'Videos'),
            coloredContainer(Colors.blue.withOpacity(0.4),
                Icon(EvaIcons.fileText,  color: Colors.indigoAccent.withOpacity(0.5), size: 40,),
                'application', 'Documents'),
            coloredContainer(Colors.purple.withOpacity(0.2),
                Icon(EvaIcons.music,  color: Colors.pink.withOpacity(0.3), size: 40,),
                'audio', 'Audios'),
          ],
        ),
      ),
    );
  }
}

Widget coloredContainer(Color bgColor, Icon cIcon, String option, String title) {
  return Column(
    children: [
      InkWell(
        onTap: () => Get.to(()=> DisplayFilesScreen(title, 'files'),
        binding: FilesBinding('files', '', option)),
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: bgColor,
          ),
          child: Center(
            child: cIcon,
          ),
        ),
      ),
      SizedBox(height: 5,),
      Text(title, style: textStyle(12, Color(0xff635C9B), FontWeight.bold),),
    ],
  );
}
