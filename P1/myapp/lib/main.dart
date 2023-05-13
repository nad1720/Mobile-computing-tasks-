import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:latlong2/latlong.dart';

enum UserActivity { unknown, walking, running }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: MyHomePage(title: 'My App Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MapController _mapController = MapController();
  GeolocatorPlatform _geolocator = GeolocatorPlatform.instance;
  UserActivity _userActivity = UserActivity.unknown;
  List<LatLng> _points = [];
  List<Marker> _markers = [];
  List<LatLng> _route = [];
  Polyline _polyline = Polyline(
    points: [],
    color: Colors.red,
    strokeWidth: 4.0,
  );

  @override
  void initState() {
    super.initState();

    // Start listening to location updates
    _geolocator.getPositionStream().listen((position) {
      // Update the map view with the user's current location
      _mapController.move(LatLng(position.latitude, position.longitude), 15);
      setState(() {
        _markers.clear();
        _markers.add(Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(position.latitude, position.longitude),
          builder: (ctx) => Container(
            child: Icon(Icons.person, color: Colors.blue),
          ),
        ));
        _points.add(LatLng(position.latitude, position.longitude));
        _route = List.from(_points);
        _polyline = Polyline(
          points: _route,
          color: Colors.red,
          strokeWidth: 4.0,
        );
      });
    });

    // Start listening to accelerometer updates
    accelerometerEvents.listen((AccelerometerEvent event) {
      // Calculate the magnitude of the acceleration vector
      double acceleration =
          event.x * event.x + event.y * event.y + event.z * event.z;

      // Determine whether the user is walking or running based on the magnitude of the acceleration vector
      if (acceleration > 25.0) {
        setState(() {
          _userActivity = UserActivity.running;
        });
      } else {
        setState(() {
          _userActivity = UserActivity.walking;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: LatLng(29.309, 30.841),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "assets/{z}/{x}/{y}.png",
            tileProvider: const AssetTileProvider(),
            maxZoom: 18.0,
          ),
          PolylineLayerOptions(
            polylines: [_polyline],
          ),
          MarkerLayerOptions(markers: _markers),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Center the map view on the user's current location
          _geolocator.getCurrentPosition().then((position) {
            _mapController.move(
                LatLng(position.latitude, position.longitude), 15);
          });
        },
        child: Icon(Icons.my_location),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60.0,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'User activity:',
                ),
                Text(
                  _userActivity.toString(),
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
