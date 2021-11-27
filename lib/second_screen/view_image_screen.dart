import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

class ViewImageScreen extends StatefulWidget {
  static const routeName = '/view-image';

  @override
  _ViewImageScreenState createState() => _ViewImageScreenState();
}

class _ViewImageScreenState extends State<ViewImageScreen> {
  bool isPDF = false;
  bool isImage = false;

  @override
  Widget build(BuildContext context) {
    File imageFile = ModalRoute.of(context).settings.arguments;
    print(imageFile.path);
    if (imageFile != null) {
      if (imageFile.path.endsWith('.pdf')) {
        isPDF = true;
      } else {
        isImage = true;
      }
    }
    return Scaffold(
      body: Container(
        child: Center(
          child: isImage
              ? Image.file(
                  imageFile,
                  fit: BoxFit.fitWidth,
                )
              : isPDF
                  ? PDFViewerScaffold(
                      path: imageFile.path,
                    )
                  : Center(
                      child: Text('Process Failed'),
                    ),
        ),
      ),
    );
  }
}
