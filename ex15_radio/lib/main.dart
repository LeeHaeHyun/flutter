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
      home: const MyHomePage(title: 'ex15 radio'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// enum은 클래스 내부에 선언할 수 없고, 상수는 소문자로.. (자바와 다르다.)
enum Fruit { apple, banana }

class _MyHomePageState extends State<MyHomePage> {

  Fruit _myGroup1 = Fruit.apple; // 첫번째 그룹 구분에 사용할 변수
  Fruit _myGroup2 = Fruit.banana; // 두번째 그룹 구분에 사용할 변수

  bool _btn = true; // 버튼의 활성화 / 비활성화를 위한 변수

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
            // 라디오 버튼을 정확히 클릭해야 선택된다.
              ListTile(
                title: const Text('사과'),
                leading: Radio <Fruit>(
                  groupValue: _myGroup1,
                  value: Fruit.apple,
                  /*
                    Flutter2.0에서 적용되면서 Null Safety가 적용되어 null 체크
                    부분이 강화되었습니다.
                  */
                  onChanged: (Fruit? value) {
                    setState(() {
                      // null 체크를 해야한다.
                      _myGroup1 = value!;
                      print(_myGroup1);
                    });
                  },
                ),
        ),
        ListTile(
          title: const Text('바나나'),
          leading: Radio <Fruit>(
            // 라디오를 하나의 그룹으로 만들 때 사용하는 속성
            groupValue: _myGroup1,
            // 해당 라디오의 값으로 사용하는 속성
            value: Fruit.banana,
            // 라디오 클릭시 이벤트 리스너 
            onChanged: (value) {
              setState(() {
                // 변수 뒤에 ! - 변수 값이 null이 들어오면 런 타임 에러 발생시킴
                _myGroup1 = value!;
                print(_myGroup1);
              });
            },
          ),
        ),
        const SizedBox(height: 50), // 간단한 간격 조정
        // 라디오 버튼의 영역이 넓어지므로 해당 라인을 클릭하면 된다.
        RadioListTile <Fruit>(
          title: const Text('사과'),
          groupValue: _myGroup2,
          value: Fruit.apple,
          onChanged: (value) {
            setState(() {
              _myGroup2 = value!;
              print(_myGroup2);
              // 아래 엘리베이트 버튼을 활성화/비활성화 시키는 기능이 추가됨
              _btn = true;
            });
          },
        ),
         RadioListTile <Fruit>(
          title: const Text('바나나'),
          groupValue: _myGroup2,
          value: Fruit.banana,
          activeColor: Colors.pink,
          // 노멀 상태의 배경색은 테마로 변경 : unselectedWidgetColor
          onChanged: (value) {
            setState(() {
              _myGroup2 = value!;
              print(_myGroup2);
              _btn = false;
            });
          },
        ),
        const SizedBox(height: 50), // 간단한 간격 조정
        ElevatedButton(
          // 버튼이 활성화 되었을 때만 _onClick1메소드를 호출할 수 있다.
          // 버튼의 onPresssed 매개변수를 null로 설정하면 버튼을 비활성화 할 수 있다.
          onPressed: _btn ? _onClick1 : null, // 함수 호출
          child: const Text('ElevatedButton',
                            style: TextStyle(fontSize: 24,
                                            color: Colors.white)),
          
          ),
        ],
      ),
    ),
  );
}

void _onClick1() {
  print('Radio 2 : $_myGroup2');
}
}
