import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'dart:math';

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
      home: const MyHomePage(title: 'ex62 googlemap3'),
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

  final Completer<GoogleMapController> _controller = Completer();
  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 10,
  );
  LatLng _myLoc = const LatLng(0, 0);
  String lat = '';
  String lon = '';
  List<Marker> _markers = [];
  final Random _random = Random();

  // 위도, 경도 계속 구하기
  void getCurrentLocation() async {
    await Permission.location.request().then((status) {
      if (status == PermissionStatus.granted) {
        // 거리가 10미터 이상 변해야 리스너에 위치가 전달된다.
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) => newPosition(position));
      }
    });
  }

  void newPosition(Position position) async {
    if (position.accuracy > 25) return;

    lat = '${position.latitude}';
    lon = '${position.longitude}';
    _myLoc = LatLng(position.latitude, position.longitude);

    final GoogleMapController controller = await _controller.future;
    // 값은 변해 있지만, 애니메이션은 별도의 동작을 해줘야 한다.
    controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition
    (target: _myLoc, zoom: 17)));
      
      // 마커의 위치도 새로운 위치로 옮긴다.
      markerAdd();
  }

  late BitmapDescriptor customMarker;
  Future<void> setCustomMarker() async {
    customMarker = await BitmapDescriptor.fromAssetImage(
                            const ImageConfiguration(size: Size(48, 48)), 
                            'assets/images/marker4.png');     
  }

  @override
  void initState() {
    super.initState();

    setCustomMarker().then((value) {
      getCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Container(
                height: 400,
                width: 400,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(0, 0),
                    zoom: 17.0,
                  ),
                  // onMapCreated: _onMapCreated,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: Set.from(_markers),
                  ),
              ),
              Text("$lat $lon"),
          ],
        ),
      );
    }

    // Future<void> _onMapCreated(GoogleMapController controller) async {
    //   _controller.complete(controller);
    //   MarkerAdd();
    // }

    void markerAdd() {
      final marker = Marker(
        markerId: const MarkerId('marker'),
        position: _myLoc,
        icon: customMarker,
        // InfoWindow: InfoWindow(
        //   title: "내 위치",
        //   snippet: "내 위치로 이동",
        //   onTap: () {print('bbbb'); },
        // ),
        onTap: () => callSnackBar("안녕하세요~ 홍길동님!"),
    );

    setState(() {
      print('666');
      _markers.clear();
      _markers.add(marker);
    });
  }

  callSnackBar(msg) {
    int myRandomCount = _random.nextInt(5);
    print(myRandomCount);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          height: 60,
          child: Row(
            children: [
              Image.asset(
                'assets/images/marker3.png',
                width: 60,
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(msg, style: const TextStyle(color: Colors.black,)),
                Row(
                  children: [
                    IconTheme(
                      data: const IconThemeData(
                        color: Colors.red,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(5, (index) {
                          return Icon(index < myRandomCount ? Icons.star
                                                            : Icons.star_border, );
                        }),
                  ),
                ),
              ],
            ),
          ],
        ),
            ],
      ),
    ),

    backgroundColor: Colors.yellow[800],
    duration: const Duration(milliseconds: 60000),
    action: SnackBarAction(
      label: 'Undo',
      textColor: Colors.black,
      onPressed: () {},
    ),
    // 스낵바 모양
    // behavior: SnackBarBehavior.floating,
    // shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.circular(10),
    //   side: BorderSide(
    //     color: Colors.red,
    //     width: 2,
    //     ),
    //   ),
      ),
    );
}
}
