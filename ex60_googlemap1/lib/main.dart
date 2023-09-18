import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

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
      home: const MyHomePage(title: 'ex60 googlemap1'),
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

  Completer<GoogleMapController> _controller = Completer();
  LatLng _myLoc1 = LatLng(37.57979551550774, 126.97706246296076);   // 경복궁
  LatLng _myLoc2 = LatLng(37.578932311976125, 126.99489126244981);  // 창경궁
  List<Marker> _markers = [];

  void setMarkerDaa() {
    /*
      마커 추가 : 마커 클릭시 인포윈도우를 띄울 수 있다.
          제목과 간단한 설명 글 그리고 탭(클릭) 했을 때
          호출할 메서드를 지정할 수 있다.
    */
    final marker1 = Marker(
      markerId: const MarkerId('A01'),
      position: _myLoc1,
      infoWindow: InfoWindow(
        title: "경복궁",
        snippet: "여기는 경복궁입니다.",
        onTap: () {
          print('aaaa');
        }
      ),
    );
    _markers.add(marker1);
    final marker2 = Marker(
      markerId: MarkerId('A02'),
      position: _myLoc2,
      infoWindow: InfoWindow(
        title: "창경궁",
        snippet: "여기는 창경궁입니다.",
        onTap: () {
          print('bbbb');
        }
      ),
    );
    _markers.add(marker2);
    }

    @override
    void initState() {
      super.initState();
      setMarkerDaa();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
          children: <Widget>[
              Container(
                color: Colors.amber,
                height: 400,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(target: _myLoc1, zoom: 15.0,),
                  markers: Set.from(_markers),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },                 
                  ),
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('경복궁 이동',
                                style: TextStyle(fontSize: 24)),
              onPressed: () => goToLocation(_myLoc1),
            ),
            SizedBox(width: 10,),
            ElevatedButton(
              child: const Text('창경궁 이동',
                                style: TextStyle(fontSize: 24)),
              onPressed: () => goToLocation(_myLoc2),
            ),
          ],
        ),
      ],
      ),
    );
  }

// 이동 버튼 클릭시 카메라의 위치 및 이동방식, 표현 방식 설정
  Future<void> goToLocation(LatLng loc) async {
    final GoogleMapController controller = await _controller.future;

    final CameraPosition pos = CameraPosition(
      target: loc,
      zoom: 15,
      // bearing: 180.0 // 지도 동서남북 회전
      // tilt: 60.0, // 지도 눕히기: Camera is directly facing the Earth,
      );

      // 애니메이션 효과가 없는 카메라 이동
      // controller.moveCamera(CameraUpdate.newCameraPosition(pos));
      // 애니메이션 효과 있음.
      controller.animateCamera(CameraUpdate.newCameraPosition(pos));
  }
}