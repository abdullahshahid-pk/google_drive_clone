import 'package:flutter/material.dart';
import 'package:google_drive_clone/widgets/storage_container.dart';
import 'package:google_drive_clone/widgets/upload_options.dart';

class StorageScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30,),
        StorageContainer(),
        SizedBox(height: 30,),
        UploadOptions(),
      ],
    );
  }
}
