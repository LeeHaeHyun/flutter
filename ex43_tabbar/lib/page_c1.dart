import 'package:flutter/material.dart';
import 'page_c2.dart';

class PageC1 extends StatefulWidget {
  const PageC1({ Key? key}) : super(key: key);

  @override
  _PageC1State createState() => _PageC1State();
}

class _PageC1State extends State<PageC1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page C-1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Page C-1', style: TextStyle(fontSize: 30)),
            const SizedBox(height: 30,),
            ElevatedButton(
              child: const Text('4페이지 추가',
                                style: TextStyle(fontSize: 24)),
              onPressed: () {
                Navigator.push(
                  context, 
                  // MaterialPageRoute(builder: (context) => const PageA2())),
                  PageRouteBuilder(
                    pageBuilder: (context, anim1, anim2) => const PageC2(),
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