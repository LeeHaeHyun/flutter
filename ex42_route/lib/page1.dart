import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Page1 extends StatefulWidget {
  // main.dart 에서 전달한 파라미터를 받기 위해 변수를 선언한 후 생성자의 
  // 추가한다. 또한 required가 있으므로 필수적으로 받아야 하는 값이 된다.
  String data = '';
  Page1({Key? key, required this.data }) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('2페이지 추가',
                                style: TextStyle(fontSize: 24)),
              onPressed: () async {
                // Route에서는 push() 대신에 pushNamed()(경로를 지정)를 사용한다.
                // 새로운 페이지에서 콜백데이터가 올때까지 대기
                // var로 설정. String 으로 받으면 에러가 발생
                // 결과 데이터를 받을 변수는 var로 선언한다. 
                // String으로 받으면 에러가 발생한다.
                // 이미 있는 페이지를 부름
                var result = await Navigator.pushNamed(context, '/page2');
                print('result(from 2) : $result');
                // 콜백데이터를 화면에 적용하기 위해서 재렌더링 한다.
                setState(() {
                  // 결과 데이터를 명시적으로 String으로 형변환 후 data에 설정
                  widget.data = result as String;
                });
              },
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            child: const Text('3페이지 추가',
                              style: TextStyle(fontSize: 24)),
            // 동작 방식은 동일하다. 콜백이 성공하면 then()절에 실행됨. 
            onPressed: () async {
              await Navigator.pushNamed(
                context, '/page3'
            ).then((result) {
              print('result(from 3) : $result');
              setState(() {
                widget.data = result as String;
              });
            });
          },
        ),
        // 앱 실행 초기에는 main.dart에서 전달한 '시작' 출력된다.
        Text(widget.data, style: const TextStyle(fontSize: 30)),
        ],
        ),
      ),
    );
  }
}
