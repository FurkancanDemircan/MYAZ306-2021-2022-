import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController controller = TextEditingController();

  // TODO: String türünde bir liste oluşturunuz.
  // Cevap:
  List<String> itemList = [];

  // TODO: Oluşturduğunuz listeye metot içinde değer atayınız. Metot String türünde parametresi almalıdır.
  // Cevap:
  AddItem(String item) {
    itemList.add(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Tutorial'),
        ),
        body: Column(children: [
          Container(
              child: Expanded(
            child: ListView.builder(
                // TODO: itemCount değişkenine oluşturduğunuz liste uzunluğunu veriniz.
                // Cevap:
                itemCount: itemList.length,
                itemBuilder: (BuildContext, index) => ListTile(
                      title: Text(
                          // TODO: Oluşturulan liste içindeki elemanı ekrana bastırın.
                          // Cevap:
                          "${itemList[index]}"
                      ),
                    )),
          )),
          Container(
              alignment: Alignment.center,
              child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: "Enter item",
                    border: OutlineInputBorder(),
                  ))),
          ElevatedButton(
            child: Text("Add"),
            onPressed: () => setState(() {
              // TODO: Oluşturduğunuz metota TextField içindeki değeri gönderin.
              // Cevap: 
              AddItem(controller.text);
              controller.clear();
            }),
          ),
        ]));
  }
}
