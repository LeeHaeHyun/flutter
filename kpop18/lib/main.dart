import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: ''),
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
  late final WebViewController controller;
  AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel("JsFlutter",
          onMessageReceived: (JavaScriptMessage message) {
        print(message.message);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      })
      ..loadRequest(Uri.parse(
          'http://kpop18.dothome.co.kr/bbs/board.php?bo_table=genreboard')); // kpop
  }

  int _curIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
        child: getPage(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange, // 배경색
        // iconSize: 30, // 아이콘 크기
        selectedItemColor: Colors.black, // 선택햇을 떄 색깔
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedItemColor: Colors.white, // 선택 되지 않을때 색깔
        unselectedLabelStyle: const TextStyle(fontSize: 14),
        currentIndex: _curIndex, // 인덱스 설정
        onTap: (index) {
          setState(() {
            // 콜백된 인덱스를 통해 전역변수의 값 변경
            _curIndex = index;
          });
        },

        // 각 메뉴 구성
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.maps_home_work),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.piano),
            label: 'Compose',
          ),
        ],
      ),
    );
  }

  // 각 페이지의 인덱스를 설정해준다.
  Widget getPage() {
    Widget? page; // null safety 적용
    switch (_curIndex) {
      case 0:
        page = page1();
        break;
      case 1:
        page = page2();
        break;
    }
    return page!; // null check operation(실행시 null이면 런타임에러 발생)
  }

  Widget page1() {
    return Scaffold(
      backgroundColor: const Color(0xFF00000F),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 601,
              child: WebViewWidget(
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget page2() {
    return Scaffold(
        backgroundColor: const Color(0xFF00000F),
        body: ListView(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/media/piano.png',
                  width: 999, height: 185, fit: BoxFit.cover),
              const Text(
                'Major (밝은 느낌의 장조)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3.0, //자간
                  height: 2.1,
                ),
              ),
              Row(children: <Widget>[
                //////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/C.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar1();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.orange; // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '도',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/D.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar2();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.orange; // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '레',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/E.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar3();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.orange; // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '미',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/F.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar4();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.orange; // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '파',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/G.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar5();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.orange; // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '솔',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ]),
              /////////////////////////////////////////////////////////////
              Row(children: <Widget>[
                //////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/CP.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar6();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.orange; // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '도#',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                //////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/DP.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar7();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.orange; // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '레#',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                //////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/FP.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar8();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.orange; // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '파#',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                //////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/GP.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar9();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.orange; // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '솔#',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                //////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/AP.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar10();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.orange; // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '라#',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                )
              ]),
              Row(children: <Widget>[
                /////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 128.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/A.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar11();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.orange; // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '라',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                //////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/B.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar12();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.orange; // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '시',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ]),
              const Column(children: <Widget>[
                Text('Minor (어두운 느낌의 단조)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3.0, //자간
                      height: 2.1,
                    )),
              ]),
              Row(children: <Widget>[
                //////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/Cm.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar13();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0x0892236a); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '도',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/Dm.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar14();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0x0892236a); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '레',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/Em.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar15();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0x0892236a); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '미',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/Fm.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar16();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0x0892236a); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '파',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/Gm.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar17();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0x0892236a); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '솔',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ]),
              /////////////////////////////////////////////////////////////
              Row(children: <Widget>[
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/CPm.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar18();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0x0892236a); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '도#',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/DPm.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar19();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0x0892236a); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '레#',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/FPm.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar20();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0x0892236a); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '파#',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/GPm.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar21();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0x0892236a); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '솔#',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/APm.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar22();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0x0892236a); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '라#',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
              ]),
              Row(children: <Widget>[
                const Padding(padding: EdgeInsets.only(left: 128.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/Am.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar23();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0x0892236a); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '라',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/Bm.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar24();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0x0892236a); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '시',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ]),
              /////////////////////////////////////////////////////////////
              const Column(children: <Widget>[
                Text('Sus4 (긴장감을 주는 서스포)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3.0, //자간
                      height: 2.1,
                    )),
              ]),
              Row(children: <Widget>[
                //////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/CS.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar25();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFF000080); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '도',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/DS.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar26();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFF000080); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '레',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/ES.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar27();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFF000080); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '미',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/FS.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar28();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFF000080); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '파',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/GS.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar29();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFF000080); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '솔',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ]),
              /////////////////////////////////////////////////////////////
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Row(children: <Widget>[
                  const Padding(padding: EdgeInsets.only(left: 3.0)),
                  ElevatedButton(
                    onPressed: () async {
                      await _audioPlayer
                          .setAsset('assets/media/CPS.wav')
                          .then((value) async {
                        await _audioPlayer.stop().then((value) {
                          _audioPlayer.play();
                          callsnackbar30();
                        });
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return const Color(0xFF000080); // hover 배경
                          }
                          return Colors.black; // 일반 배경
                        },
                      ),
                      foregroundColor: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.white; // hover 글씨
                          }
                          return null; // 기본 글씨
                        },
                      ),
                    ),
                    child: const Text(
                      '도#',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  /////////////////////////////////////////////////////////////
                  const Padding(padding: EdgeInsets.only(left: 3.0)),
                  ElevatedButton(
                    onPressed: () async {
                      await _audioPlayer
                          .setAsset('assets/media/DPS.wav')
                          .then((value) async {
                        await _audioPlayer.stop().then((value) {
                          _audioPlayer.play();
                          callsnackbar31();
                        });
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return const Color(0xFF000080); // hover 배경
                          }
                          return Colors.black; // 일반 배경
                        },
                      ),
                      foregroundColor: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.white; // hover 글씨
                          }
                          return null; // 기본 글씨
                        },
                      ),
                    ),
                    child: const Text(
                      '레#',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  /////////////////////////////////////////////////////////////
                  const Padding(padding: EdgeInsets.only(left: 3.0)),
                  ElevatedButton(
                    onPressed: () async {
                      await _audioPlayer
                          .setAsset('assets/media/FPS.wav')
                          .then((value) async {
                        await _audioPlayer.stop().then((value) {
                          _audioPlayer.play();
                          callsnackbar32();
                        });
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return const Color(0xFF000080); // hover 배경
                          }
                          return Colors.black; // 일반 배경
                        },
                      ),
                      foregroundColor: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.white; // hover 글씨
                          }
                          return null; // 기본 글씨
                        },
                      ),
                    ),
                    child: const Text(
                      '파#',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  /////////////////////////////////////////////////////////////
                  const Padding(padding: EdgeInsets.only(left: 3.0)),
                  ElevatedButton(
                    onPressed: () async {
                      await _audioPlayer
                          .setAsset('assets/media/GPS.wav')
                          .then((value) async {
                        await _audioPlayer.stop().then((value) {
                          _audioPlayer.play();
                          callsnackbar33();
                        });
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return const Color(0xFF000080); // hover 배경
                          }
                          return Colors.black; // 일반 배경
                        },
                      ),
                      foregroundColor: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.white; // hover 글씨
                          }
                          return null; // 기본 글씨
                        },
                      ),
                    ),
                    child: const Text(
                      '솔#',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  /////////////////////////////////////////////////////////////
                  const Padding(padding: EdgeInsets.only(left: 3.0)),
                  ElevatedButton(
                    onPressed: () async {
                      await _audioPlayer
                          .setAsset('assets/media/APS.wav')
                          .then((value) async {
                        await _audioPlayer.stop().then((value) {
                          _audioPlayer.play();
                          callsnackbar34();
                        });
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return const Color(0xFF000080); // hover 배경
                          }
                          return Colors.black; // 일반 배경
                        },
                      ),
                      foregroundColor: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.white; // hover 글씨
                          }
                          return null; // 기본 글씨
                        },
                      ),
                    ),
                    child: const Text(
                      '라#',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  )
                ]),
              ),

              /////////////////////////////////////////////////////////////
              Row(children: <Widget>[
                const Padding(padding: EdgeInsets.only(left: 128.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/AS.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar35();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFF000080); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '라',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/BS.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar36();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFF000080); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '시',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ]),
              /////////////////////////////////////////////////////////////
              const Column(children: <Widget>[
                Text('Dim (어둡고 음침한 디미니쉬)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3.0, //자간
                      height: 2.1,
                    )),
              ]),
              Row(children: <Widget>[
                //////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/CD.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar37();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black; // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.red; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '도',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/DD.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar38();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black; // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.red; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '레',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/ED.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar39();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black; // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.red; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '미',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/FD.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar40();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black; // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.red; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '파',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/GD.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar41();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black; // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.red; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '솔',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ]),
              /////////////////////////////////////////////////////////////
              Row(children: <Widget>[
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/CPD.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar42();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black; // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.red; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '도#',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/DPD.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar43();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black; // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.red; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '레#',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/FPD.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar44();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black; // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.red; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '파#',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/GPD.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar45();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black; // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.red; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '솔#',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/APD.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar46();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black; // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.red; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '라#',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ]),
              /////////////////////////////////////////////////////////////
              Row(children: <Widget>[
                const Padding(padding: EdgeInsets.only(left: 128.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/AD.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar47();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black; // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.red; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '라',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/BD.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar48();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black; // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.red; // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '시',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ]),
              /////////////////////////////////////////////////////////////
              const Column(children: <Widget>[
                Text('Aug (신비로운 느낌의 어그먼트)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3.0, //자간
                      height: 2.1,
                    )),
              ]),
              Row(children: <Widget>[
                //////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/CA.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar49();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFFE6E6FA); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFF647979); // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '도',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/DA.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar50();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFFE6E6FA); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFF647979); // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '레',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/EA.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar51();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFFE6E6FA); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFF647979); // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '미',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/FA.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar52();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFFE6E6FA); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFF647979); // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '파',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 10.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/GA.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar53();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFFE6E6FA); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFF647979); // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '솔',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ]),
              /////////////////////////////////////////////////////////////
              Row(children: <Widget>[
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/CPA.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar54();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFFE6E6FA); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFF647979); // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '도#',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                ////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/DPA.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar55();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFFE6E6FA); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFF647979); // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '레#',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/FPA.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar56();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFFE6E6FA); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFF647979); // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '파#',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/GPA.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar57();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFFE6E6FA); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFF647979); // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '솔#',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                /////////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/APA.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar58();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFFE6E6FA); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFF647979); // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '라#',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ]),
              /////////////////////////////////////////////////////////////
              Row(children: <Widget>[
                const Padding(padding: EdgeInsets.only(left: 128.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/AA.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar59();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFFE6E6FA); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFF647979); // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '라',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                ///////////////////////////////////////////////////////////
                const Padding(padding: EdgeInsets.only(left: 3.0)),
                ElevatedButton(
                  onPressed: () async {
                    await _audioPlayer
                        .setAsset('assets/media/BA.wav')
                        .then((value) async {
                      await _audioPlayer.stop().then((value) {
                        _audioPlayer.play();
                        callsnackbar60();
                      });
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFFE6E6FA); // hover 배경
                        }
                        return Colors.black; // 일반 배경
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color(0xFF647979); // hover 글씨
                        }
                        return null; // 기본 글씨
                      },
                    ),
                  ),
                  child: const Text(
                    '시',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                ///////////////////////////////////////////////////////////
              ]),
            ]));
  }

////////////////// 코드 정보 //////////////////////////
  void callsnackbar1() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('C 메이저: 도,미,솔', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar2() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('D 메이저: 레,파#,라', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar3() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('E 메이저: 미,솔#,시', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar4() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('F 메이저: 파,라,도', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar5() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('G 메이저: 솔,시,레', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar6() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('C# 메이저: 도#,미#,솔#', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar7() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('D# 메이저: 레#,솔,라#', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar8() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('F# 메이저: 파#,라#,도#', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar9() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('G# 메이저: 솔#,도,레#', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar10() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('A# 메이저: 라#,레,파', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar11() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('A 메이저: 라,도#,미', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar12() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('B 메이저: 시,레#,파', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

/////////////////////////////////////////////////////////////////////////////////
  void callsnackbar13() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('C 마이너: 도,레#,솔', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar14() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('D 마이너: 레,파,라', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar15() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('E 마이너: 미,솔,시', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar16() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('F 마이너: 파,솔#,도', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar17() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('G 마이너: 솔,라#,레', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar18() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('C# 마이너: 도#,미,솔#', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar19() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('D# 마이너: 레#,파#,라#', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar20() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('F# 마이너: 파#,라,도#', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar21() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('G# 마이너: 솔#,시,레#', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar22() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('A# 마이너: 라#,도#,파', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar23() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('A 마이너: 라,도,미', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar24() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('B 마이너: 시,레,파#', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar25() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('C 서스포: 도,파,솔', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar26() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('D 서스포: 레,솔,라', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar27() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('E 서스포: 미,라,시', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar28() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('F 서스포: 파,라#,도', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar29() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('G 서스포: 솔,도,레', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar30() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('C# 서스포: 도#,파#,솔#', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar31() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('D# 서스포: 레#,솔#,라#', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar32() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('F# 서스포: 파#,시,도#', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar33() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('G# 서스포: 솔#,도#,레#', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar34() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('A# 서스포: 라#,레#,파', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar35() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('A 서스포: 라,레,미', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar36() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('B 서스포: 시,미,파#', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar37() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('C 디미니쉬: 도,레#,파#', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar38() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('D 디미니쉬: 레,파,솔#', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar39() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('E 디미니쉬: 미,솔,라#', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar40() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('F 디미니쉬: 파,솔#,시', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar41() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('G 디미니쉬: 솔,라#,도#', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar42() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('C# 디미니쉬: 도#,미,솔', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar43() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('D# 디미니쉬: 레#,파#,라', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar44() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('F# 디미니쉬: 파,솔#,시', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar45() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('G# 디미니쉬: 솔#,시,레', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar46() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('A# 디미니쉬: 라#,도#,미', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar47() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('A 디미니쉬: 라,도,레#', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar48() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('B 디미니쉬: 시,레,파', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar49() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('C 어그먼트: 도,미,솔#', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar50() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('D 어그먼트: 레,파#,라#', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar51() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('E 어그먼트: 미,솔#,도', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar52() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('F 어그먼트: 파,라,도#', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar53() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('G 어그먼트: 솔,시,레#', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar54() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('C# 어그먼트: 도#,파,라', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar55() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('D# 어그먼트: 레#,솔,시', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar56() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('F# 어그먼트: 파#,라#,레', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar57() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('G# 어그먼트: 솔#,도,미', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar58() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('A# 어그먼트: 라#,레,파#', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar59() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('A 어그먼트: 라,도#,파', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }

  void callsnackbar60() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('B 어그먼트: 시,레#,솔', // 메세지 스타일
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            )),
        backgroundColor: Colors.white, // 배경색
        duration: Duration(milliseconds: 1000), // 닫히는 시간
      ),
    );
  }
}
