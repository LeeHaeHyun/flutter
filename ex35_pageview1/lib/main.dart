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
      home: const MyHomePage(title: 'ex35 pageview1'),
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
  // 페이지뷰를 사용하기 위한 컨트롤러를 생성한다.

  final _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              const Text(
               '터치한 후 좌우로 Swipe 하세요.',
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            Expanded(
              flex: 1,
              child: PageView(
                // 페이지뷰의 컨트롤러 연결
                controller: _pageController,
                // pageSnapping: false, // 페이지 넘김 보정 끄기
              children: [
                // 페이지는 위젯으로 생성한다.
                page1(),
                page2(),
                page3(),
          ],
        ),
      ),
          ],
        ),
      ),
    );
  }

  Widget page1() {
    return const SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [ 
            Icon(Icons.camera_alt, color: Colors.red, size: 50.0),
            Text(
              'Page index : 0',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

   Widget page2() {
    return const SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [ 
            Icon(Icons.camera_alt, color: Colors.orange, size: 50.0),
            Text(
              'Page index : 1',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

   Widget page3() {
    return const SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [ 
            Icon(Icons.camera_alt, color: Colors.blue, size: 50.0),
            Text(
              'Page index : 2',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}