import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Countries {
  final int id;
  final String name;
  final String capital;
  final int area;

  const Countries({
    required this.id,
    required this.name,
    required this.capital,
    required this.area,
  });

  factory Countries.fromJson(Map<String, dynamic> json) => Countries(
        id: json['id'],
        name: json['name'],
        capital: json['capital'],
        area: json['area'],
      );
}

class SecondPage extends StatefulWidget {
  final urlText;

  SecondPage({required this.urlText}) : super();

  @override
  State<StatefulWidget> createState() {
    return _SecondPage(urlText: urlText);
  }
}

class _SecondPage extends State<SecondPage> {
  //TODO Önceki sayfadan gelen url'in alınması için final türünde değişken oluşturunuz

  _SecondPage({required this.urlText}) : super();

  Future<List<Countries>> fetchCuntries() async {
    //TODO response değişkeninin http://$urlText.ngrok.io/countries adresinden veri çekmesini sağlayın.
    var response;

    //TODO [false] kısmını status code 200 olacak şekilde değiştirin.
    if (false) {
      var parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Countries>((json) => Countries.fromJson(json)).toList();
    } else {
      //TODO başarısız olunması durumunda istisna içinde mesaj fırlatın.
      throw UnimplementedError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NGROK App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("$urlText"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder<List<Countries>>(
                future: fetchCountries(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 0, 10.0, 5.0),
                            child: Card(
                                child: ListTile(
                              leading: Text("${snapshot.data![index].id}"),
                              title: Text("${snapshot.data![index].name}"),
                              subtitle:
                                  Text("${snapshot.data![index].capital}"),
                              trailing: Text("${snapshot.data![index].area}"),
                            )),
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('${snapshot.error}'));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
