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
      home: const MyHomePage(title: 'ex10 layout'),
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
      /* 
        위젯을 감쌀 필요가 있는 경우 Ctrl + . 을 사용한다.
      */
      body: SafeArea(
        child: Container( // 스타일을 주고 싶다면 역시 컨테이너로 감싼다.
          color: Colors.orange,
          child: Column( // 여러 뭉텅이를 만들고 싶다면 column을 추가한다.
            children: [
              Expanded( // 화면을 비율로 꽉차게 하고 싶다면 widget을 추가하여 expanded
                flex: 1,
                child: Container(  // 배경색을 주고 싶다면 무조건 container로 감싼다
                  color: Colors.yellow,
                  width: 300,
                  height: 100,
              
                  child: Row(     // 가로형 배치
                    mainAxisAlignment: MainAxisAlignment.center, // 가로의 가운데 배치
                    mainAxisSize: MainAxisSize.max,
                    // children : 2개 이상의 위젯을 배치할 때 사용
                    // child : 1개의 위젯을 배치할 때 사용
                    children: [
                      ElevatedButton(child: const Text('Button'),onPressed: () {},),
                      // const SizedBox(width: 10,), // 버튼 사이의 여백, 여백
                      // const Spacer(flex: 1,), // 위젯의 전체적인 배치 조정, 비율
                      ElevatedButton(child: const Text('Button'),onPressed: () {},),
                      // const SizedBox(width: 10,), // 버튼 사이의 여백
                      // const Spacer(flex: 2,), // 버튼 사이의 여백을 주는 다른 방법
                      ElevatedButton(child: const Text('Button'),onPressed: () {},),
                    ],
                  ),
                ),
              ),
              Expanded( // 화면을 비율로 꽉차게 하고 싶다면 widget을 추가하여 expanded
                flex: 2, // 화면 비율을 1:2로 꽉차게 한다.
                child: Container(  // 배경색을 주고 싶다면 무조건 container로 감싼다
                  color: Colors.cyan,
                  width: 300,
                  height: 100,
                  margin: const EdgeInsets.all(5), //밖의 여백
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10), // 안쪽 여백
                  child: Row(  // 가로형 배치
                    mainAxisAlignment: MainAxisAlignment.center, // 정렬
                    mainAxisSize: MainAxisSize.max,
                    // 수직 방향에서 아래쪽 - 끝으로 정렬
                    crossAxisAlignment: CrossAxisAlignment.end, // 끝에 정렬
                    children: [
                      ElevatedButton(child: const Text('Button'),onPressed: () {},),
                      // const SizedBox(width: 10,), // 버튼 사이의 여백
                      // const Spacer(flex: 1,), // 버튼 사이의 여백을 주는 다른 방법
                      ElevatedButton(child: const Text('Button'),onPressed: () {},),
                      // const SizedBox(width: 10,), // 버튼 사이의 여백
                      // const Spacer(flex: 2,), // 버튼 사이의 여백을 주는 다른 방법
                      ElevatedButton(child: const Text('Button'),onPressed: () {},),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ), // 버튼 만들기
    );
  }
}
