import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
      home: const MyHomePage(title: 'ex33 gridview2'),
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
              SizedBox(   // SizeBox로 사용하길 권장
                height: 300,  // 컨테이너로 감싸서 크기를 지정하면 스크롤 가능
                child: GridView.count(
                  // 스크롤은 세로방향이 디폴트
                  // scrollDirection: Axis.vertical,
                  crossAxisCount: 4, // 타일의 갯수가 자동으로 계산된다.
                  childAspectRatio: 1.5, // 가로세로 비율을 정한다.
                  // int(50)의 길이만큼 0부터 index-1까지 범위의 각 인덱스를 
                  // 오름차순으로 호출하여 만든 값으로 리스트를 생성한다.
                  children: List.generate(50, (index) {
                    return const Card(
                      color: Colors.blue,
                      child: Icon(
                        Icons.face,
                        color: Colors.yellow,
                        size: 50,
                      ),
                    );
                  }),
                ),
              ),
            SizedBox( // 구분하기 위해서 sizeBox로 구분
              height: 200,
              child: GridView.count(
                scrollDirection: Axis.horizontal, // 가로 스크롤 방향으로 설정
                crossAxisCount: 2,
                children: List.generate(50, (index) {
                  return const Card(
                    color: Colors.amber,
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}