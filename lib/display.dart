import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';
// import 'package:pdftron_flutter/pdftron_flutter.dart';

class Display extends StatefulWidget {
  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  File file;
  String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Excel-Files'),
        backgroundColor: Colors.black12,
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('FileUrl').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return !snapshot.hasData
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  padding: EdgeInsets.all(10.0),
                  // height: 30,
                  child: ListView(
                    children: snapshot.data.documents.map((DocumentSnapshot document){
                      return new Card(
                        color: Color(0xFFF2AA4C),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                              TextButton(
                              child: Center(
                                child: Text(
                                    document['filename'],
                                  style: TextStyle(
                                    fontFamily: 'times new roman',
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: (){
                                PdftronFlutter.openDocument(document['url']);
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          );
        },
      ),
      backgroundColor: Colors.grey[700],
    );
  }

// Future<void> getCsFile() async{
//  final res = await FilePicker.getFile();
//  if(res==null) return;
//  final path = res.path.toString();
//  setState(() {
//    file = File(path);
//  });
//  print(path.runtimeType);
//  print(path);
//  PdftronFlutter.openDocument(path);
// }
}
