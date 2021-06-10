import 'package:excel_project/display.dart';
import 'package:excel_project/upload.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: MyApp(),
));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Excel'),
        backgroundColor: Colors.black12,
      ),
      backgroundColor: Colors.grey[850],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 100, height: 50),
              child: ElevatedButton(
                style: ButtonStyle(
                  shadowColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Color(0xFFF2AA4C)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                child: Text(
                  'Upload',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Times New Roman',
                  ),
                ),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Upload()));
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 100,height: 50),
              child: ElevatedButton(
                style: ButtonStyle(
                    shadowColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Color(0xFFF2AA4C)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )
                    )
                ),
                child: Text('Display',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Times New Roman',
                  ),
                ),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Display()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
