import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/constants.dart';
import 'package:google_drive_clone/firebase_service.dart';
import 'package:google_drive_clone/models/file_model.dart';
import 'package:google_drive_clone/widgets/audio_player.dart';
import 'package:google_drive_clone/widgets/pdf_viewer.dart';
import 'package:google_drive_clone/widgets/video_player.dart';

class ViewFileScreen extends StatelessWidget {

  FileModel file;
  ViewFileScreen(this.file);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              backgroundColor: Colors.black,
              title: Text(file.name, style: textStyle(20, Colors.white, FontWeight.w600),),
              actions: [
                IconButton(
                  icon: Icon(Icons.more_vert, color: Colors.white, size: 30,),
                  onPressed: (){
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10),),
                      ),
                      builder: (context){
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(file.name,
                                  style: textStyle(16, Colors.black, FontWeight.w500),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Divider(color: Colors.grey, height: 5,),
                            ListTile(
                              onTap: (){
                                FirebaseService().downloadFile(file);
                                Get.back();
                              },
                              dense: true,
                              contentPadding: EdgeInsets.only(top: 10, bottom: 0, left: 15),
                              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                              leading: Icon(Icons.file_download, color: Colors.grey,),
                              title: Text('Download',
                                style: textStyle(16, Colors.black, FontWeight.w500),
                              ),
                            ),
                            ListTile(
                              onTap: (){
                                FirebaseService().deleteFile(file);
                                Get.back();
                              },
                              dense: true,
                              contentPadding: EdgeInsets.only(top: 8, bottom: 12, left: 15),
                              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                              leading: Icon(Icons.delete, color: Colors.grey,),
                              title: Text('Remove',
                                style: textStyle(16, Colors.black, FontWeight.w500),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          body: file.type == 'image' ? showImage(file.url) :
          file.type == 'application' ? showFile(file, context) :
          file.type == 'video' ? videoPlayerWidget(file.url) :
          file.type == 'audio' ? AudioPlayerWidget(file.url) : showError(),
        ),
    );
  }

  showImage(String url) {
    return Center(
      child: Image(image: NetworkImage(url)),
    );
  }

  showFile(FileModel file, context) {
    if(file.ext == 'pdf'){
      return pdfViewer(file);
    }
    else{
      return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Unfortunately unable to open file',
            style: textStyle(18, Colors.white, FontWeight.w700),
            ),
            SizedBox(height: 20,),
            Container(
              height: 30,
              width: MediaQuery.of(context).size.width/2,
              child: TextButton(
                onPressed: (){
                  FirebaseService().downloadFile(file);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                ),
                child: Text('Download', style: textStyle(17, Colors.white, FontWeight.w600),),
              ),
            ),
          ],
        ),
      );
    }
  }

  showError() {
    return Center(
      child: Text('Unsupported File', style: textStyle(16, Colors.white, FontWeight.w700),),
    );
  }
}
