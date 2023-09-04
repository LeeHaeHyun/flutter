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
      home: const MyHomePage(title: 'Ex07 button'),
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
      body: Center(       // 좌우의 중앙
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 위아래의 중앙
          children: <Widget>[
              ElevatedButton(
                // 글자의 크기에 의해 버튼에 크기가 변함
                child: const Text('Button ㅇㅇㅇ#1',
                              style: TextStyle(fontSize: 24)),
                              onPressed: () { // 짧으면 직접 구현
                                print("첫번째 버튼이 클릭됨");
                              },
        ),
          ElevatedButton(
            child: const Text('Button #2', 
                                style: TextStyle(fontSize: 24)),
            onPressed: () {   // 함수 호출 : 코드가 길 때 함수 구현부에서 호출
              _onClick();
            },
          ),
          ElevatedButton(
            child: const Text('Button #3',
                        style: TextStyle(fontSize: 24)),
            onPressed: () => _onClick(), // 람다 형태로 함수 호출
          ),
          ElevatedButton(
            onPressed: _onClick,  // 함수 이름 대입
            child: const Text('Button #4', 
                                style: TextStyle(fontSize: 24)),
          ),
          ],
        ),
      ),
    );
  }

  void _onClick() {
    print("버튼이 클릭됨");
  }
}
