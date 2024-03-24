import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pedalix_app/components/network_utility.dart';
import 'package:pedalix_app/constants.dart';
import 'package:pedalix_app/utils/map_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location _locationController = new Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng Pitipana = LatLng(6.821559595815525, 80.0415551335397);
  LatLng? _currentP = null;
  bool _isLockedToCurrentPosition = true;
  Set<Marker> _markers = {};

  Map<PolylineId, Polyline> polylines = {};

  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentPositionIcon = BitmapDescriptor.defaultMarker;

  void setCustomMarkerIcon() {
    ImageConfiguration config = const ImageConfiguration(size: Size(80, 80));
    BitmapDescriptor.fromAssetImage(
      config,
      "assets/Charging_Station.png",
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

  Future<void> fetchStationsAndCreateMarkers() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('stations').get();

    snapshot.docs.forEach((doc) {
      final double lat = double.parse(doc['lat'] as String);
      final double lng = double.parse(doc['lng'] as String);
      final String name = doc['name'] as String;

      final marker = Marker(
        markerId: MarkerId(name),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: name),
        icon: destinationIcon,
      );

      _markers.add(marker);
    });

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchStationsAndCreateMarkers();
    setCustomMarkerIcon();
    getLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentP == null
          ? const Center(
              child: Text("Loading..."),
            )
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: ((GoogleMapController controller) {
                    _mapController.complete(controller);
                    controller.setMapStyle(mapUtils.mapStyle);
                  }),
                  initialCameraPosition: CameraPosition(
                    target: Pitipana,
                    zoom: 15,
                  ),
                  markers: _markers,
                  polylines: Set<Polyline>.of(polylines.values),
                  zoomControlsEnabled: false,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 160,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Form(
                      child: Container(
                        width: 400,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                onChanged: (value) {
                                  placeAutoComplete(value);
                                },
                                decoration: InputDecoration(
                                  hintText: 'Search location',
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10), // Add some space
                            Expanded(
                              child: ListView.builder(
                                itemCount: _predictions.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                        _predictions[index].description ?? ""),
                                    onTap: () {
                                      // Handle selection of prediction
                                      // You may want to clear the search field and update the map accordingly
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 180,
                  right: 10,
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _isLockedToCurrentPosition =
                            !_isLockedToCurrentPosition;
                        if (_isLockedToCurrentPosition && _currentP != null) {
                          _cameraToPosition(_currentP!);
                        }
                      });
                    },
                    child: Icon(_currentP == null
                        ? Icons.location_disabled
                        : (_isLockedToCurrentPosition
                            ? Icons.my_location
                            : Icons.location_searching)),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 15,
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

          // Add a new marker for the current location
          Marker currentLocationMarker = Marker(
            markerId: MarkerId('currentLocation'),
            position: _currentP!,
            icon:
                currentPositionIcon, // Make sure to define this BitmapDescriptor
          );

          _markers.add(currentLocationMarker);
        });
      }
    });
  }

  void placeAutoComplete(String query) async {
    Uri url = Uri.https(
      'maps.googleapis.com',
      '/maps/api/place/autocomplete/json',
      {
        'input': query,
        'key': "AIzaSyDfd43AVuZ-MC7bx0nrfSaVKYLN2WBN_yI",
      },
    );
    String? response = await NetworkUtility.fetchUrl(url);
    if (response != null) {
      PlaceAutoCompleteResponse result =
          PlaceAutoCompleteResponse.parseAutoCompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          _predictions = result.predictions!;
        });
      }
    }
  }

  List<AutocompletePrediction> _predictions = [];
}
