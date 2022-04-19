import 'package:colabflutter/secondpage.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _textControlller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Builder(
          builder: (context) => Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TextField(
                      controller: _textControlller,
                      decoration: InputDecoration(
                          label: Text("Enter NGROK url"),
                          hintText: "Only enter before .ngrok.io"),
                    ),
                  ),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SecondPage(urlText: _textControlller.text))),
                      icon: Icon(Icons.send),
                      label: Text("Send API Url"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
