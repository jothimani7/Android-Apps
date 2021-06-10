import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File file;
  String filename;
  StorageTaskSnapshot task;
  CollectionReference fileRef;
  bool page = true, circle = false;
  // Color c1 = HexColor("#E94B3CFF");

  @override
  void initState() {
    super.initState();
    fileRef = Firestore.instance.collection("FileUrl");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload'),
        backgroundColor: Colors.black12,
      ),
      backgroundColor: Colors.grey[850],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (circle) ? CircularProgressIndicator() : Container(),
            SizedBox(
              height: 30,
            ),
            (file == null)
                ? ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: 150, height: 50),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shadowColor: MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(Color(0xFFF2AA4C)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )),
                        
                      ),
                      child: Text(
                        'Select File',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                      onPressed: getCsvFile,
                    ),
                  )
                : enable(context),
          ],
        ),
      ),
    );
  }

  Widget enable(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          (page && circle == false)
              ? Column(
                  children: [
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(height: 50, width: 100),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shadowColor: MaterialStateProperty.all(Colors.white),
                            backgroundColor: MaterialStateProperty.all(Color(0xFFF2AA4C)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          )),
                        ),
                        child: Text(
                          'Upload',
                          style: TextStyle(
                              fontSize: 18, fontFamily: 'times new roman'),
                        ),
                        onPressed: uploadCsvFile,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(height: 50, width: 100),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shadowColor: MaterialStateProperty.all(Colors.white),
                          backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          )),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              fontSize: 18, fontFamily: 'times new roman'),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    (circle)
                        ? Text(
                            'Uploading',
                            style: TextStyle(fontSize: 28,fontFamily: 'Times New Roman',color: Colors.lightBlueAccent),
                          )
                        : Text(
                            'Completed',
                            style: TextStyle(fontSize: 38,fontFamily: 'Times New Roman',color: Colors.white),
                          ),
                    SizedBox(height: 20,),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: 150, height: 50),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shadowColor: MaterialStateProperty.all(Colors.white),
                            backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                        child: Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Times New Roman',
                          ),
                        ),
                        onPressed: (circle)
                            ? null
                            : () {
                                Navigator.of(context).pop();
                              },
                      ),
                    )
                  ],
                ),
        ],
      ),
    );
  }


  Future getCsvFile() async {
    final res = await FilePicker.getFile();
    if (res == null) return;
    final path = res.path;
    setState(() {
      file = File(path);
      filename = basename(file.path);
      print(filename);
    });
  }

  Future uploadCsvFile() async {
    setState(() {
      circle = true;
    });
    StorageReference ref =
        FirebaseStorage.instance.ref().child('files/$filename');
    StorageUploadTask upload = ref.putFile(file);
    task = await upload.onComplete;
    if (task == null) return;
    String url;
    await ref.getDownloadURL().then((value) => url = value.toString());
    fileRef.add({'filename': filename, 'url': url}).whenComplete(() {
      setState(() {
        circle = false;
        page = false;
      });
    });
  }

// showAlertDialog(BuildContext context){
//   Widget okButton = FlatButton(
//     child: Text('Done'),
//     onPressed: (){
//
//     },
//   );
//
//   AlertDialog alert = AlertDialog(
//     title: Text('Completed'),
//     actions: [
//       okButton,
//     ],
//   );
//
//   showDialog(
//     context: context,
//     builder: (BuildContext context){
//       return alert;
//     },
//   );
// }
}

// String basename(String path) => context.basename(path);
