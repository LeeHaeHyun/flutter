import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ex32 gridview1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(10), // 전체화면에서의 패딩
        crossAxisSpacing: 10, // 아이템 간의 간격(수평방향)
        mainAxisSpacing: 20,  // 아이템 간의 간격(수직방향)
        crossAxisCount: 4,    // 한줄에 표시할 컨테이너의 갯수
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            color: Colors.blue[100],
            child: const Text("1"),
        ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            color: Colors.blue[200],
            child: const Text("2"),
        ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            color: Colors.blue[300],
            child: const Text("3"),
        ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            color: Colors.blue[500],
            child: const Text("5"),
        ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            color: Colors.blue[600],
            child: const Text("6"),
        ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            color: Colors.blue[700],
            child: const Text("7"),
        ),
          ],
        ),
    );
  }
}
