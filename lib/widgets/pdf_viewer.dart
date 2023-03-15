import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:google_drive_clone/models/file_model.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class pdfViewer extends StatefulWidget {
  final FileModel file;
  pdfViewer(this.file);

  @override
  State<pdfViewer> createState() => _pdfViewerState();
}

class _pdfViewerState extends State<pdfViewer> {

  late File pdfFile;
  bool initialize = false;

  @override
  void initState() {
    super.initState();
    initializePDF();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: initialize ? PDFView(
            filePath: pdfFile.path,
            fitEachPage: false,
          ) : Center(
            child: CircularProgressIndicator(),
          ),
        ),
    );
  }

  void initializePDF() async{
    pdfFile = await loadFilePDF(widget.file);
    initialize = true;
    setState(() {});
  }

  loadFilePDF(FileModel file) async {
    final response = await http.get(Uri.parse(file.url));
    final bytes = response.bodyBytes;
    return storeFile(file, bytes);
  }

  storeFile(FileModel file, List<int> bytes) async{
    final localDirectory = await getApplicationDocumentsDirectory();
    final fileName = File('${localDirectory.path}/${file.name}');
    await fileName.writeAsBytes(bytes, flush: true);
    return fileName;
  }
}
