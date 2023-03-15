import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:google_drive_clone/constants.dart';
import 'package:google_drive_clone/models/file_model.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService{

  Uuid uuid = Uuid();

  uploadFile(String folderName) async{
    FilePickerResult? result = await
    FilePicker.platform.pickFiles(allowMultiple: true);

    if(result != null){
      List<File> files = result.paths.map((path) => File(path!)).toList();

      for(File file in files){
        String? type = lookupMimeType(file.path);
        String end = '/';
        int startIndex = 0;
        int? endIndex = type?.indexOf(end);
        String? fileType = type?.substring(startIndex,endIndex);

        String fileName = file.path.split('/').last;
        String fileExt = fileName.substring(fileName.indexOf('.')+1);
         print(fileName);
         print(fileExt);

         File? compressedFile = await compressFile(file, fileType!);

         UploadTask uploadTask = FirebaseStorage.instance.ref().child('files').child(
           'File ${uuid.v4()}').putFile(compressedFile!);
         TaskSnapshot snapshot = await uploadTask.whenComplete((){});
         String fileUrl = await snapshot.ref.getDownloadURL();

         userCollection.doc(FirebaseAuth.instance.currentUser!.uid).collection('files').add(
             {
               'fileName': fileName,
               'fileUrl': fileUrl,
               'fileType': fileType,
               'fileExtension': fileExt,
               'folder': folderName,
               'size': (compressedFile.readAsBytesSync().length/1024).round(),
               'dateUploaded': DateTime.now(),
             });
      }
      if(folderName == ''){
        Get.back();
      }
      else{
        Get.back();
      }
    }
  }

  Future<File?> compressFile(File file, String type) async{
    if(type == 'image'){
      Directory directory = await getTemporaryDirectory();
      String targetPath = directory.path +'/${uuid.v4().substring(0,7)}.jpeg';
      File? result = await FlutterImageCompress.compressAndGetFile(file.path,
          targetPath, quality: 75);
      return result;
    }
    else if(type == 'video'){
      MediaInfo? info = await VideoCompress.compressVideo(file.path,
          quality: VideoQuality.MediumQuality, deleteOrigin: false,
          includeAudio: true);
      return File(info!.path!);
    }
    return file;
  }

  downloadFile(FileModel file) async{
    try{
      final downloadPath = await downloadingPath();
      final path = '$downloadPath/${file.name.replaceAll(' ', '')}';
      var status = await Permission.storage.status;
      if(!status.isGranted){
        await Permission.storage.request();
      }
      await Dio().download(file.url, path);
    }
    catch(e){
      Get.snackbar('Error', 'Error in downloading');
    }
  }

  Future<String?> downloadingPath() async{
    Directory? directory;
    try{
      if(Platform.isIOS){
        directory = await getApplicationDocumentsDirectory();
      }
      else{
        directory = Directory('/storage/emulated/0/Download');
        if(await directory.exists()){
        }else{
          directory = getExternalStorageDirectory() as Directory;
        }
      }
    }
    catch(e){
      Get.snackbar('Error', 'Storage Error');
    }
    return directory!.path;
  }

  deleteFile(FileModel file) async{
    await userCollection.doc(FirebaseAuth.instance.currentUser!.uid).collection('files').
    doc(file.id).delete();
  }
}