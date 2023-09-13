import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Page3 extends StatefulWidget {

  String data = '';
  Page3({Key? key, required this.data }) : super(key: key);

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 3'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('3페이지 제거',
                                style: TextStyle(fontSize: 24)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              // 해당 페이지를 제거한 후 파라미터를 보낸다.
              onPressed: () {
                Navigator.pop(context, '3페이지에서 보냄 (pop)');
              },
          ),
          Text(widget.data, style: const TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}
