import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:pedalix_app/constants.dart';
import 'package:pedalix_app/utils/map_style.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location _locationController = new Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng Pitipana = LatLng(6.823998564075345, 80.03050881837878);
  static const LatLng GreenUni = LatLng(6.820800702603565, 80.04185109605329);
  LatLng? _currentP = null;
  bool _isLockedToCurrentPosition = true;

  Map<PolylineId, Polyline> polylines = {};

  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentPositionIcon = BitmapDescriptor.defaultMarker;

  void setCustomMarkerIcon() {
    ImageConfiguration config = ImageConfiguration(size: Size(88, 88));
    BitmapDescriptor.fromAssetImage(
      config,
      "assets/Place_Marker.png",
    ).then((icon) {
      setState(() {
        destinationIcon = icon;
      });
    });
    BitmapDescriptor.fromAssetImage(
      config,
      "assets/Record.png",
    ).then((icon) {
      setState(() {
        currentPositionIcon = icon;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setCustomMarkerIcon();
    getLocationUpdates().then(
      (_) => {
        getPolylinePoints().then((coordinates) => {
              generatePolyLineFromPoints(coordinates),
            }),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentP == null
          ? const Center(
              child: Text("Loading..."),
            )
          : GoogleMap(
              onMapCreated: ((GoogleMapController controller) {
                _mapController.complete(controller);
                controller.setMapStyle(mapUtils.mapStyle);
              }),
              initialCameraPosition: CameraPosition(
                target: Pitipana,
                zoom: 13,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("_currentLocation"),
                  icon: currentPositionIcon,
                  position: _currentP!,
                ),
                Marker(
                    markerId: MarkerId("_sourceLocation"),
                    icon: destinationIcon,
                    position: Pitipana),
                Marker(
                    markerId: MarkerId("_destionationLocation"),
                    icon: destinationIcon,
                    position: GreenUni)
              },
              polylines: Set<Polyline>.of(polylines.values),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isLockedToCurrentPosition = !_isLockedToCurrentPosition;
            if (_isLockedToCurrentPosition && _currentP != null) {
              _cameraToPosition(_currentP!);
            }
          });
        },
        child: Icon(_currentP == null
            ? Icons.location_disabled
            : (_isLockedToCurrentPosition
                ? Icons.lock
                : Icons.location_searching)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          if (_isLockedToCurrentPosition) {
            _cameraToPosition(_currentP!);
          }
        });
      }
    });
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDfd43AVuZ-MC7bx0nrfSaVKYLN2WBN_yI",
      PointLatLng(Pitipana.latitude, Pitipana.longitude),
      PointLatLng(GreenUni.latitude, GreenUni.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: primaryColor,
        points: polylineCoordinates,
        width: 4);
    setState(() {
      polylines[id] = polyline;
    });
  }
}
