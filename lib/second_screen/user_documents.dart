import 'dart:io';
import 'package:check/third_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './view_image_screen.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:file_picker/file_picker.dart';
import '../Resources/AllColors.dart';

class UserDocuments extends StatefulWidget {
  static const routeName = '/upload_documents';
  @override
  _UserDocumentsState createState() => _UserDocumentsState();
}

class _UserDocumentsState extends State<UserDocuments> {
  File imageFile;

  File profileStored;
  File licenseStored;
  File certificateStored;
  File passportStored;
  int stepsCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemeData.themeData.backgroundColor,
      body: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Upload Documents',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: StepProgressIndicator(
                      roundedEdges: Radius.circular(10),
                      totalSteps: 4,
                      currentStep: stepsCount,
                      selectedColor: Colors.blue,
                      unselectedColor: Colors.grey[300],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  profile('Profile Picture'),
                  license('Driving License'),
                  certificate('Certificate'),
                  passport('Passport'),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Builder(builder: (BuildContext context) {
                  return InkWell(
                      onTap: () {
                        (stepsCount < 4)
                            ? Scaffold.of(context).showSnackBar(new SnackBar(
                                content: Text('Upload all files'),
                                duration: Duration(seconds: 3),
                              ))
                            : Navigator.of(context)
                                .pushNamed(UserHome.routeName);
                      },
                      child: new Container(
                          height: 49.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: stepsCount < 4 ? Colors.grey : Colors.blue,
                          ),
                          child: Text(
                            'DONE',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          )));
                })
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget profile(String title) {
    return GestureDetector(
      child: items(title, Icon(Icons.person), 0),
      onTap: () {
        if (profileStored == null) {
          if (stepsCount == 0) showChoiceDialog(context);
        } else
          profileView();
      },
    );
  }

  Widget license(String title) {
    return GestureDetector(
      child: items(title, Icon(Icons.image), 1),
      onTap: () {
        if (licenseStored == null) {
          if (stepsCount == 1) showChoiceDialog(context);
        } else
          licenseView();
      },
    );
  }

  Widget certificate(String title) {
    return GestureDetector(
      child: items(title, Icon(Icons.insert_drive_file), 2),
      onTap: () {
        if (certificateStored == null) {
          if (stepsCount == 2) showChoiceDialog(context);
        } else
          certificateView();
      },
    );
  }

  Widget passport(String title) {
    return GestureDetector(
      child: items(title, Icon(Icons.card_membership), 3),
      onTap: () {
        if (passportStored == null) {
          if (stepsCount == 3) showChoiceDialog(context);
        } else
          passportView();
      },
    );
  }

  Widget items(String title, Icon icon, int cardNo) {
    File storedFile;
    storedFile = null;
    switch (cardNo) {
      case 0:
        storedFile = profileStored;
        break;

      case 1:
        storedFile = licenseStored;
        break;

      case 2:
        storedFile = certificateStored;
        break;

      case 3:
        storedFile = passportStored;
        break;

      default:
        storedFile = null;
    }

    return Card(
      margin: EdgeInsets.all(5),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45),
      ),
      child: ListTile(
          title: Row(
            children: <Widget>[
              SizedBox(
                width: 7,
              ),
              Text(title),
            ],
          ),
          trailing: (storedFile != null &&
                  (storedFile.path.endsWith('.png') ||
                      storedFile.path.endsWith('.jpg')))
              ? Container(
                  height: 50,
                  width: 50,
                  padding: EdgeInsets.all(5),
                  child: Image.file(
                    storedFile,
                    fit: BoxFit.fill,
                  ),
                )
              : (storedFile != null && storedFile.path.endsWith('.pdf'))
                  ? Icon(
                      Icons.picture_as_pdf,
                      color: Colors.redAccent,
                      size: 45,
                    )
                  : icon),
    );
  }

  profileView() {
    Navigator.of(context)
        .pushNamed(ViewImageScreen.routeName, arguments: profileStored);
  }

  licenseView() {
    Navigator.of(context)
        .pushNamed(ViewImageScreen.routeName, arguments: licenseStored);
  }

  certificateView() {
    Navigator.of(context)
        .pushNamed(ViewImageScreen.routeName, arguments: certificateStored);
  }

  passportView() {
    Navigator.of(context)
        .pushNamed(ViewImageScreen.routeName, arguments: passportStored);
  }

  Future<void> showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a Choice"),
            content: SingleChildScrollView(
              child: ListBody(children: <Widget>[
                GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.photo_library, color: Colors.lightGreen),
                        SizedBox(width: 5),
                        Text("Gallery"),
                      ],
                    ),
                    onTap: () {
                      openGallery(context);
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 0),
                  child: GestureDetector(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.camera, color: Colors.lightBlue),
                          SizedBox(width: 5),
                          Text("Camera"),
                        ],
                      ),
                      onTap: () {
                        openCamera(context);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 0),
                  child: GestureDetector(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.insert_drive_file,
                              color: Colors.redAccent),
                          SizedBox(width: 5),
                          Text("Document"),
                        ],
                      ),
                      onTap: () {
                        openDocument(context);
                      }),
                ),
              ]),
            ),
          );
        });
  }

  openGallery(BuildContext context) async {
    var picture;
    //File imageFile;
    picture = await ImagePicker().getImage(source: ImageSource.gallery);

    this.setState(() {
      imageFile = File(picture.path);
      print('Image Path $imageFile');
    });

    setState(() {
      if (stepsCount == 0)
        profileStored = imageFile;
      else if (stepsCount == 1)
        licenseStored = imageFile;
      else if (stepsCount == 2)
        certificateStored = imageFile;
      else if (stepsCount == 3) passportStored = imageFile;
    });

    if (imageFile != null) {
      setState(() {
        stepsCount++;
      });
    }
  }

  openCamera(BuildContext context) async {
    PickedFile picture =
        await ImagePicker().getImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = File(picture.path);
      print('Image Path $imageFile');
    });
    if (imageFile == null) return null;
    setState(() {
      if (stepsCount == 0)
        profileStored = imageFile;
      else if (stepsCount == 1)
        licenseStored = imageFile;
      else if (stepsCount == 2)
        certificateStored = imageFile;
      else if (stepsCount == 3) passportStored = imageFile;
    });
    if (imageFile != null) {
      setState(() {
        stepsCount++;
      });
    }
  }

  openDocument(BuildContext context) async {
    //File imageFile ;
    imageFile = null;
    FilePickerResult doc = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    this.setState(() {
      imageFile = File(doc.files.single.path);
    });
    setState(() {
      if (stepsCount == 0)
        profileStored = imageFile;
      else if (stepsCount == 1)
        licenseStored = imageFile;
      else if (stepsCount == 2)
        certificateStored = imageFile;
      else if (stepsCount == 3) passportStored = imageFile;
    });

    if (imageFile != null) {
      setState(() {
        stepsCount++;
      });
    }
  }
}
