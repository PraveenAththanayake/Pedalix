import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NetworkUtility {
  static Future<String?> fetchUrl(Uri uri,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        print('Failed to fetch data from $uri');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return null;
  }
}

class PlaceAutoCompleteResponse {
  final String? status;
  final List<AutocompletePrediction>? predictions;

  PlaceAutoCompleteResponse({this.status, this.predictions});

  factory PlaceAutoCompleteResponse.fromJson(Map<String, dynamic> json) {
    return PlaceAutoCompleteResponse(
      status: json['status'] as String?,
      predictions: json['predictions'] != null
          ? (json['predictions'])
              .map<AutocompletePrediction>(
                  (json) => AutocompletePrediction.fromJson(json))
              .toList()
          : null,
    );
  }

  static PlaceAutoCompleteResponse parseAutoCompleteResult(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();
    return PlaceAutoCompleteResponse.fromJson(parsed);
  }
}

class AutocompletePrediction {
  final String? description;
  final String? placeId;
  final StructuredFormatting? structuredFormatting;
  final String? reference;

  AutocompletePrediction(
      {this.description,
      this.placeId,
      this.structuredFormatting,
      this.reference});

  factory AutocompletePrediction.fromJson(Map<String, dynamic> json) {
    return AutocompletePrediction(
      description: json['description'] as String?,
      placeId: json['place_id'] as String?,
      structuredFormatting: json['structured_formatting'] != null
          ? StructuredFormatting.fromJson(json['structured_formatting'])
          : null,
      reference: json['reference'] as String?,
    );
  }
}

class StructuredFormatting {
  final String? mainText;
  final String? secondaryText;

  StructuredFormatting({this.mainText, this.secondaryText});

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) {
    return StructuredFormatting(
      mainText: json['main_text'] as String?,
      secondaryText: json['secondary_text'] as String?,
    );
  }
}

Future<LatLng> getPlaceLocation(String placeId) async {
  // Construct the URL for the Places Details API
  Uri url = Uri.https(
    'maps.googleapis.com',
    '/maps/api/place/details/json',
    {
      'place_id': placeId,
      'fields': 'geometry',
      'key': "AIzaSyDfd43AVuZ-MC7bx0nrfSaVKYLN2WBN_yI",
    },
  );

  // Send a GET request to the Places Details API
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);

    double lat = jsonResponse['result']['geometry']['location']['lat'];
    double lng = jsonResponse['result']['geometry']['location']['lng'];

    return LatLng(lat, lng);
  } else {
    throw Exception('Failed to load place location');
  }
}
