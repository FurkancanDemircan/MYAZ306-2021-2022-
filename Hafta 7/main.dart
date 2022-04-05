import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

// TODO: Bu haftaki çalışmada sahte api üzerinden veri çekmeniz ve çekilen veriyi göstermeniz beklenmektedir.
// TODO 1: http paketini yapılacak örnek uygulamaya yükleyin ve paketi import ediniz.

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
  final TextEditingController? _idControlller = TextEditingController();

  // TODO 2: final türünde şimdiki zamanı tutan bir değişken oluşturunuz.

  // TODO 3: Get işlemi için aşağıdaki fetchComments() metotunu kullanmanız beklenmektedir.
  // TODO 4: Örnek işlem için "https://pub.dev/packages/http" sayfasını kullanınız.

  /// Eğer [pId] boş ise;     URL 1: https://jsonplaceholder.typicode.com/comments
  ///
  /// Eğer [pId] boş değilse; URL 2: https://jsonplaceholder.typicode.com/comments?id=id_değeri
  Future<List<Comments>> fetchComments([String? pId]) async {
    var response;

    // TODO 5: Eğer String? pId boş metin ise ('') bütün listeyi get metoduyla response değişkenine atanmalıdır.
    // TODO 6: Eğer pId boş metin değilse ilgili id değerine ait değer response değişkenine atanmalıdır.


    // TODO 7: [false] kısmını geri dönen [statusCode] 200 ise cevabı yazdıracak şekilde değiştirin.
    if (false) {
      var parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Comments>((json) => Comments.fromJson(json)).toList();
    } else {
      // TODO 8: Eğer kod farklı ise hata fırlatınız.
      return throw UnimplementedError();
    }
  }

  @override
  void initState() {
    super.initState();
  }

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
          children: [
            // TODO 9: final türünde oluşturduğunuz değişkeni Text widget'ıyla ekrana bastırınız.
            Text("Tarih: "),
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
