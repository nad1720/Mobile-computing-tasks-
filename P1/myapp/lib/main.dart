import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:sensors_plus/sensors_plus.dart';

enum UserActivity { unknown, walking, running, jugging }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My App',
      home: MyHomePage(title: 'My App Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
StreamController<UserActivity> _userActivityStream = StreamController<UserActivity>();

class _MyHomePageState extends State<MyHomePage> {
  final MapController _mapController = MapController();
  final GeolocatorPlatform _geolocator = GeolocatorPlatform.instance;
  UserActivity _userActivity = UserActivity.unknown;
  final List<Marker> _markers = [];
  final List<LatLng> __route = [];
  //final url = 'path/to/local/tiles/{z}/{x}/{y}.png';
  //final file = DefaultCacheManager().getSingleFile('assets/');
  late Polyline _polyline = Polyline(
    points: [],
    color: Colors.red,
    strokeWidth: 4.0,
  );
  @override
  void initState() {
    super.initState();
    _initPlatformState();
    _initSensors();
    _getCurrentLocation();
    _listenToLocationChanges();
  }
  Future<void> _listenToLocationChanges() async {
    Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10,
    ).listen((Position position) {
      _onLocationUpdate(position);
    });
  }

  Future<void> _initPlatformState() async {
    await _geolocator.isLocationServiceEnabled();
  }

  Future<void> _getCurrentLocation() async {
    Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10,
    ).listen((Position position) {
      _onLocationUpdate(position);
    });
  }

  void _onLocationUpdate(Position position) {
    LatLng latLng = LatLng(position.latitude, position.longitude);
    double speed = position.speed;

    
    if (speed > 2.0) {
      setState(() {
        _userActivity = UserActivity.running;
      });
    } else if (speed > 1.0) {
      setState(() {
        _userActivity = UserActivity.jugging;
      });
    } else if (speed > 0.5) {
      setState(() {
        _userActivity = UserActivity.walking;
      });
    } else {
      setState(() {
        _userActivity = UserActivity.unknown;
      });
    }

    
    _userActivityStream.add(_userActivity);

    
    setState(() {
      _markers.add(Marker(
        width: 80.0,
        height: 80.0,
        point: latLng,
        builder: (ctx) => const Icon(Icons.location_on),
      ));
      __route.add(latLng);
      _polyline = Polyline(
        points: __route,
        color: Colors.red,
        strokeWidth: 4.0,
      );
    });

    
    _mapController.move(latLng, 16);
  }
  void _initSensors() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      double x = event.x;
      double y = event.y;
      double z = event.z;

      if (x.abs() > y.abs()) {
        if (x > 0) {
          _userActivityStream.add(UserActivity.running);
        } else {
          _userActivityStream.add(UserActivity.jugging);
        }
      } else {
        if (y > 0) {
          _userActivityStream.add(UserActivity.walking);
        } else {
          _userActivityStream.add(UserActivity.unknown);
        }
      }
    });
  }
  @override
  void dispose() {
    _userActivityStream.close();
    super.dispose();
  }

  Widget _buildMap() {
    return StreamBuilder<UserActivity>(
      stream: _userActivityStream.stream,
      initialData: UserActivity.unknown,
      builder: (BuildContext context, AsyncSnapshot<UserActivity> snapshot) {
        if (snapshot.hasData) {
          _userActivity = snapshot.data!;
        }
        return FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center: LatLng(37.7749, -122.4194),
            zoom: 13.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            PolylineLayerOptions(
              polylines: [_polyline],
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: __route.isNotEmpty ? __route.last : LatLng(0, 0),
                  builder: (ctx) => const Icon(
                    Icons.person_pin_circle_outlined,
                    color: Colors.blue,
                    size: 50.0,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          _buildMap(),
          Positioned(
            bottom:20,
            left: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _userActivity.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(backgroundColor: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Position position = await _geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          _onLocationUpdate(position);
        },
        tooltip: 'Get Location',
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
