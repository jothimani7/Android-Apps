import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    bool k=false;
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
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return new Card(
                        color: Color(0xFFF2AA4C),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              onPressed: () {
                                PdftronFlutter.openDocument(document['url']);
                              },
                            ),
                            IconButton(
                              color: Colors.red,
                              icon: Icon(Icons.delete_outline_rounded),
                              onPressed: () async {
                                String file = document['url'];
                                var docid = document.documentID.toString();
                                StorageReference storage = await FirebaseStorage
                                    .instance
                                    .getReferenceFromUrl(file);
                                await storage.delete().then((value) => k=true);
                                if(k) {
                                  Firestore.instance
                                      .collection('FileUrl')
                                      .document(docid)
                                      .delete();
                                }
                              },
                            )
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
}

// class Snak extends StatelessWidget {
//   // const snak({key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SnackBar(
//       content: Text("Successfully Deleted"),
//     );
//   }
// }
