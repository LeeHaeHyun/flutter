import 'package:flutter/material.dart';
import 'page_b2.dart';

class PageB1 extends StatefulWidget {
  const PageB1({ Key? key}) : super(key: key);

  @override
  _PageB1State createState() => _PageB1State();
}

class _PageB1State extends State<PageB1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page B-1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Page B-1', style: TextStyle(fontSize: 30)),
            const SizedBox(height: 30,),
            ElevatedButton(
              child: const Text('3페이지 추가',
                                style: TextStyle(fontSize: 24)),
              onPressed: () {
                Navigator.push(
                  context, 
                  // MaterialPageRoute(builder: (context) => const PageA2())),
                  PageRouteBuilder(
                    pageBuilder: (context, anim1, anim2) => const PageB2(),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}