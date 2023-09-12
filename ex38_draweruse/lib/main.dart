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
      home: const MyHomePage(title: 'ex38 draweruse'),
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
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // 기본 슬라이딩 동작을 방지합니다.
        drawerEnableOpenDragGesture: true, // true면 드래그가 된다.
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(widget.title),
          leading: Builder(builder: (context) => // 상황에 맞게 있는지
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer()
              ),
            ),
          ),
          // drawer 메뉴를 위한 프로퍼티
          drawer: Drawer(
            // 해당 메뉴는 리스트뷰를 통해 구성한다.
            child: ListView(
              padding: EdgeInsets.zero,
              /*
                만약 해당 위젯이 const로 선언되면 메뉴에 ontap()을
                추가했을때  에러가 발생하므로 주의해야한다.
              */ 
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.message),
                title: Text('Messages'),
              ),
              const ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
              ),
              // 리스트타일을 통해 각 메뉴 구성
              ListTile(   // 아이콘과 텍스트 메뉴 구성
                leading: const Icon(Icons.settings),
                title: const Text('Drawer Close'),
                onTap: (() {
                  // Closing programmatically
                  scaffoldKey.currentState!.openEndDrawer();
                  // Scaffold.of(context).openEndDrawer(); // 닫기가 안됨
                }),
              ),
              ],
            ),
          ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              const Text(
          '왼쪽 끝에서 오른쪽으로 드래그 해봅시다.',
        ),
        ElevatedButton(
          child: const Text('Drawer 열기',
                              style: TextStyle(fontSize: 24)),
          onPressed: () {
            //Scaffold.of(context).openDrawer(); // 안됨
            scaffoldKey.currentState!.openDrawer();
          }
        ),
      ],
        ),
      ),
      );
  }
}