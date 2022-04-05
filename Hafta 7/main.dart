import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Comments>> fetchComments([String? pId]) async {
  var response;

  if (pId == '') {
    response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
  } else {
    response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/comments?id=$pId'));
  }

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Comments>((json) => Comments.fromJson(json)).toList();
  } else {
    throw Exception('Başarısız');
  }
}

class Comments {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  const Comments({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        postId: json['postId'],
        id: json['id'],
        name: json['name'],
        email: json['email'],
        body: json['body'],
      );
}

List<Comments> postFromJson(String str) =>
    List<Comments>.from(json.decode(str).map((x) => Comments.fromJson(x)));

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();
  }

  final TextEditingController? _idControlller = TextEditingController();

  final tarih = DateTime.now();

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text("Tarih: $tarih"),

            Expanded(
              child: FutureBuilder<List<Comments>>(
                future: fetchComments(_idControlller?.text),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Container(
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("postId: ${snapshot.data![index].postId}"),
                              Text("id:${snapshot.data![index].id}"),
                              Text("name:${snapshot.data![index].name}"),
                              Text("email:${snapshot.data![index].email}"),
                              Text("body:${snapshot.data![index].body}"),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: _idControlller,
                      decoration: const InputDecoration(
                          labelText: "Enter id", border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                  child: ElevatedButton.icon(
                      onPressed: () => setState(() {}),
                      icon: const Icon(Icons.add),
                      label: const Text("Search Comment",
                          style: TextStyle(fontSize: 18))),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
