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
      home: const MyHomePage(title: 'ex04 Icon'),
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
      body: const Row( // 아이콘은 상수이기 때문에 아래 모두 상수 처리하지 말고
                      // 여기서 상수 처리하면 됨
        children: <Widget>[ // 우리가 만들고 자동으로 완성된 코드에는 
                            // 앞에 있는 Widget이 없다. 
                            // 없어도 됨
              Icon(
                Icons.camera_alt,
                color: Colors.red,
                size: 35.0,
        ),
           Icon(
                Icons.cancel,
                color: Colors.orange,
                size: 35.0,
          ),
          Icon(
              Icons.home,
              color: Colors.black,
              size: 35.0,
        ),
        Icon(
            Icons.visibility_off,
            color: Colors.red,
            size: 35.0,
        ),

        ],
      )
    );
  }
  }