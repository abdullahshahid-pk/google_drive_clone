import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/constants.dart';
import 'package:google_drive_clone/controllers/files_display_controller.dart';
import 'package:google_drive_clone/firebase_service.dart';
import 'package:google_drive_clone/screens/view_files_screen.dart';
import 'package:google_drive_clone/widgets/floating_button.dart';

class DisplayFilesScreen extends StatefulWidget {

  final String title;
  final String type;
  DisplayFilesScreen(this.title, this.type);

  @override
  State<DisplayFilesScreen> createState() => _DisplayFilesScreenState();


}

class _DisplayFilesScreenState extends State<DisplayFilesScreen> {
  late FilesDisplayController filesDisplayController;

  @override
  void initState() {
    // TODO: implement initState
   filesDisplayController=Get.put(FilesDisplayController(widget.type,"Folder",widget.title));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                    onPressed: (){
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back, color: textColor,),
                ),
                title: Text(widget.title, style: textStyle(20, textColor, FontWeight.bold),),
              ),
          ),
          floatingActionButton: InkWell(
            onTap: ()=> widget.type == 'folder' ? FirebaseService().uploadFile(widget.title) :
            FirebaseService().uploadFile(''),
            child: FloatingButton(),
          ),
          body: Obx(()=>
             GridView.builder(
              itemCount: filesDisplayController.files.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 2,
                childAspectRatio: 1.25,
              ),
              itemBuilder: (context, index){
                return InkWell(
                  onTap: () => Get.to(()=> ViewFileScreen(filesDisplayController.files[index])),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                    child: Container(
                      width: MediaQuery.of(context).size.width/2,
                      child: Column(
                        children: [
                          filesDisplayController.files[index].type == 'image' ?
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image(
                              width: MediaQuery.of(context).size.width/2.5,
                              height: 90,
                              fit: BoxFit.cover,
                              image: NetworkImage(filesDisplayController.files[index].url),
                            ),
                          ) : Container(
                            height: 75,
                            width: 60,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 0.15),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: Image(
                                width: 50,
                                height: 55,
                        image: AssetImage('assets/images/${filesDisplayController.files[index].ext}.png'),
                      ),
                    ),
                  ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Text(filesDisplayController.files[index].name,
                                    style: textStyle(14, textColor, FontWeight.bold),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.more_vert, color: Colors.black, size: 30,),
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
                                                child: Text(filesDisplayController.files[index].name,
                                                  style: textStyle(16, Colors.black, FontWeight.w500),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Divider(color: Colors.grey, height: 5,),
                                            ListTile(
                                              onTap: (){
                                                FirebaseService().downloadFile(filesDisplayController.files[index]);
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
                                                FirebaseService().deleteFile(filesDisplayController.files[index]);
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
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
    );
  }
}
