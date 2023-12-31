import 'package:flutter/material.dart';
import 'page2.dart';
import 'page3.dart';

// final이 아닌 하나 이상의 인스턴스 필드를 정의할때 노란줄이 보임
// ignore: must_be_immutable
class Page1 extends StatefulWidget {
  // 파라미터로 전달된 값을 받을 변수
  String data = '';
  Page1({super.key, required this.data});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Page 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              ElevatedButton(
                child: const Text('2페이지 추가', style: TextStyle(fontSize: 24)),
                // 버튼 1을 누르면... 비동기로 동작한다.
                onPressed: () async {
                  // 변수 data의 값을 반 문자열로 만든다.
                  setState(() {
                    widget.data = '';
                  });
                  // 2페이지를 수택에 추가한다.
                  // 2페이지에서 콜백 데이터가 넘어오길 기다린다.(await)
                  String value = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      // 2페이지를 추가하면서 데이터 파라미터도 함께 전닳한다
                      builder: (context) => Page2(
                        data: '1페이지에서 보냄(1->2)',
                  )),
              );
              // 2페이지에서 콜백해준 데이터를 여기서 출력한다.
                  print('result(1-1) : $value');
              // 콜백 데이터를 통해 화면을 갱신한다.
                  setState(() {
                    widget.data = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text('3페이지 추가', style: TextStyle(fontSize: 24)),
                // 버튼 2를 누르면 3페이지로 스택에 추가한다.
                onPressed: () async {
                  // 변수 내용 지움
                  setState(() {
                    widget.data = '';
                  });
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Page3(
                        data: '1페이지에서 보냄 (1->3)',
                      )),
                  ).then((value) {
                    // 3페이지에서 콜백 데이터가 정상적으로 넘어오면 then절이 실행된다.
                    print('result(1-2) : $value');
                    setState(() {
                      widget.data = value;
                    });
                });
                },
              ),
               // 파라미터로 전달받은 값을 텍스트 위젯에 출력
              Text(widget.data, style: const TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}

