import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pedalix_app/components/network_utility.dart';
import 'package:pedalix_app/constants.dart';
import 'package:pedalix_app/utils/map_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';

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
  double _distance = 0.0;
  late DatabaseReference _userLocationsRef;

  Map<PolylineId, Polyline> polylines = {};

  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentPositionIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor selectedPositionIcon = BitmapDescriptor.defaultMarker;

  double _searchContainerHeight = 160;
  TextEditingController _searchController = TextEditingController();

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
    BitmapDescriptor.fromAssetImage(
      config,
      "assets/Place_Marker.png",
    ).then((icon) {
      setState(() {
        selectedPositionIcon = icon;
      });
    });
  }

  Future<void> fetchStationsAndCreateMarkers() async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('stations').get();

      snapshot.docs.forEach((doc) {
        final double lat = double.parse(doc['lat'] as String);
        final double lng = double.parse(doc['lng'] as String);
        final String name = doc['name'] as String;

        final marker = Marker(
          markerId: MarkerId(name),
          position: LatLng(lat, lng),
          onTap: () async {
            // Generate polyline when marker is tapped
            List<LatLng> polylineCoordinates =
                await getPolylinePoints(LatLng(lat, lng));
            generatePolyLineFromPoints(polylineCoordinates);

            // Calculate the distance between current position and station
            if (_currentP != null) {
              double distanceInMeters = Geolocator.distanceBetween(
                _currentP!.latitude,
                _currentP!.longitude,
                lat,
                lng,
              );
              _distance = distanceInMeters / 1000; // convert to kilometers
              print('Distance to station: $_distance km');
            }
          },

          // infoWindow: InfoWindow(title: name),
          icon: destinationIcon,
        );

        _markers.add(marker);
      });

      setState(() {});
    } catch (e) {
      print('Error fetching stations: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchStationsAndCreateMarkers();
    setCustomMarkerIcon();
    getLocationUpdates();

    // Get a reference to the Firebase Realtime Database node where user locations are stored
    _userLocationsRef =
        FirebaseDatabase.instance.reference().child('user_locations');

    // Listen for changes in the user locations and update the map accordingly
    _userLocationsRef.onValue.listen((event) {
      // Check if the event snapshot contains data
      if (event.snapshot.value != null) {
        // Convert the snapshot value to a Map<dynamic, dynamic>
        Map<dynamic, dynamic>? locations =
            event.snapshot.value as Map<dynamic, dynamic>?;

        // Clear existing markers representing other users' locations
        _markers.removeWhere(
            (marker) => marker.markerId.value.startsWith('user_location'));

        // Add markers for each user's location
        locations?.forEach((key, value) {
          // Extract latitude and longitude from the user's location data
          double latitude = value['latitude'];
          double longitude = value['longitude'];

          // Create a marker for the user's location
          Marker userLocationMarker = Marker(
            markerId: MarkerId(
                'user_location_$key'), // Use a unique marker ID for each user
            position: LatLng(latitude, longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue), // You can customize the marker icon
            infoWindow: InfoWindow(
                title:
                    'User $key'), // Provide an info window with user information
          );

          // Add the marker to the set of markers
          _markers.add(userLocationMarker);
        });

        // Update the UI to reflect the changes
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentP == null
          ? const Center(
              child: CircularProgressIndicator(),
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
                  onTap: (LatLng location) async {
                    // Add a new marker for the selected location
                    Marker selectedLocationMarker = Marker(
                      markerId: MarkerId('selectedLocation'),
                      position: location,
                      icon: selectedPositionIcon,
                      infoWindow: InfoWindow(title: 'Selected Location'),
                    );

                    _markers.add(selectedLocationMarker);

                    _distance = Geolocator.distanceBetween(
                      _currentP!.latitude,
                      _currentP!.longitude,
                      location.latitude,
                      location.longitude,
                    );
                    // Convert the distance to kilometers
                    _distance = _distance / 1000;

                    // Update the UI
                    setState(() {});

                    List<LatLng> polylineCoordinates =
                        await getPolylinePoints(location);
                    generatePolyLineFromPoints(polylineCoordinates);
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      if (_searchController.text.isEmpty) {
                        setState(() {
                          _searchContainerHeight = 160; // Initial height
                        });
                      }
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: _searchContainerHeight,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _searchController,
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    _searchContainerHeight =
                                        160; // Initial height
                                  });
                                } else {
                                  setState(() {
                                    _searchContainerHeight = 300;
                                  });
                                  placeAutoComplete(value);
                                }
                              },
                              readOnly: false,
                              onTap: () {
                                placeAutoComplete('');
                              },
                              decoration: InputDecoration(
                                hintText: 'Search',
                                fillColor: Color(0xFFF6F6F6),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: Icon(Icons.search),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Distance: ${_distance.toStringAsFixed(2)} km',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: _predictions.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                        _predictions[index].description ?? ""),
                                    onTap: () async {
                                      // Handle selection of prediction
                                      String selectedPlaceId =
                                          _predictions[index].placeId!;
                                      LatLng selectedPlaceLocation =
                                          await getPlaceLocation(
                                              selectedPlaceId);

                                      // Update the search field with the selected place
                                      _searchController.text =
                                          _predictions[index].description!;

                                      // Update the map with the selected place
                                      _cameraToPosition(selectedPlaceLocation);

                                      // Clear predictions and reset search container height
                                      setState(() {
                                        _predictions.clear();
                                        _searchContainerHeight = 160;
                                      });
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
                  top: 250,
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
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
      if (!_serviceEnabled) {
        return;
      }
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

          Marker currentLocationMarker = Marker(
            markerId: MarkerId('currentLocation'),
            position: _currentP!,
            icon: currentPositionIcon,
          );

          _markers.add(currentLocationMarker);

          // Update the user's location to Firebase Realtime Database
          updateLocationToFirebase(_currentP!);

          // If there is a selected place, update the polyline
          if (_predictions.isNotEmpty) {
            String? placeId = _predictions[0].placeId;
            if (placeId != null) {
              updatePolyline(placeId);
            }
          }
        });
      }
    });
  }

  void updateLocationToFirebase(LatLng location) async {
    // Get the current user's email from Firestore
    String? userEmail;
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (snapshot.exists) {
        userEmail = snapshot['email'];
      }
    }

    if (userEmail != null) {
      // Construct the database reference with the user's email
      DatabaseReference locationRef = FirebaseDatabase.instance
          .reference()
          .child('user_locations')
          .child(userEmail.replaceAll('.', '_'));

      // Update user's location with latitude and longitude
      locationRef.set({
        'latitude': location.latitude,
        'longitude': location.longitude,
        'timestamp': ServerValue.timestamp,
      });
    }
  }

  Future<void> updatePolyline(String placeId) async {
    LatLng selectedPlaceLocation = await getPlaceLocation(placeId);
    List<LatLng> polylineCoordinates =
        await getPolylinePoints(selectedPlaceLocation);
    generatePolyLineFromPoints(polylineCoordinates);

    _distance = Geolocator.distanceBetween(
      _currentP!.latitude,
      _currentP!.longitude,
      selectedPlaceLocation.latitude,
      selectedPlaceLocation.longitude,
    );
    // Convert the distance to kilometers
    _distance = _distance / 1000;

    // Update the UI
    setState(() {});
  }

  void placeAutoComplete(String query) async {
    // Check if the query is empty
    if (query.isEmpty) {
      setState(() {
        _predictions.clear();
        polylines.clear();
      });
      return;
    }

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
      if (result.predictions != null && result.predictions!.isNotEmpty) {
        setState(() {
          _predictions = result.predictions!;
        });
        String? placeId = _predictions[0].placeId;
        if (placeId != null) {
          LatLng selectedPlaceLocation = await getPlaceLocation(placeId);

          // Add a new marker for the selected location
          Marker selectedLocationMarker = Marker(
            markerId: MarkerId('selectedLocation'),
            position: selectedPlaceLocation,
            icon: selectedPositionIcon,
            infoWindow: InfoWindow(title: 'Selected Location'),
          );

          _markers.add(selectedLocationMarker);

          _distance = Geolocator.distanceBetween(
            _currentP!.latitude,
            _currentP!.longitude,
            selectedPlaceLocation.latitude,
            selectedPlaceLocation.longitude,
          );
          // Convert the distance to kilometers
          _distance = _distance / 1000;

          // Update the UI
          setState(() {});

          List<LatLng> polylineCoordinates =
              await getPolylinePoints(selectedPlaceLocation);
          generatePolyLineFromPoints(polylineCoordinates);
        }
      }
    }
  }

  Future<List<LatLng>> getPolylinePoints(LatLng destination) async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDfd43AVuZ-MC7bx0nrfSaVKYLN2WBN_yI",
      PointLatLng(_currentP!.latitude, _currentP!.longitude),
      PointLatLng(destination.latitude, destination.longitude),
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
        color: Colors.black,
        points: polylineCoordinates,
        width: 4);
    setState(() {
      polylines[id] = polyline;
    });
  }

  List<AutocompletePrediction> _predictions = [];
}
