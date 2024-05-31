import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Places extends StatefulWidget {
  final String pickupLocation;
  final String destination;

  const Places({
    Key? key,
    required this.pickupLocation,
    required this.destination,
  }) : super(key: key);

  @override
  _PlacesState createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  List<String> famousPlaces = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchFamousPlaces();
  }

  Future<void> fetchFamousPlaces() async {
    setState(() {
      isLoading = true;
    });

    try {
      final pickupLatLong = await getLatLong(widget.pickupLocation);
      final destinationLatLong = await getLatLong(widget.destination);

      // For simplicity, I'm adding sample places
      final List<String> places = await fetchSamplePlaces();

      setState(() {
        famousPlaces = places;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching famous places: $e');
    }
  }

  Future<Map<String, double>> getLatLong(String cityName) async {
    final apiKey = 'AIzaSyAQmXnS-3ACS488VOFOCli2ZS_YIk97olc';
    final apiUrl = 'https://maps.googleapis.com/maps/api/geocode/json';

    final response =
        await http.get(Uri.parse('$apiUrl?address=$cityName&key=$apiKey'));
    print('Geocode API Response: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final location = data['results'][0]['geometry']['location'];
        final lat = location['lat'];
        final lng = location['lng'];
        return {'latitude': lat, 'longitude': lng};
      } else {
        throw Exception('Failed to geocode city: ${data['status']}');
      }
    } else {
      throw Exception('Failed to fetch data from the geocoding API');
    }
  }

  Future<List<String>> fetchSamplePlaces() async {
    return Future.delayed(Duration(seconds: 2), () {
      return [
        'Famous Place 1',
        'Famous Place 2',
        'Famous Place 3',
        'Famous Place 4',
        'Famous Place 5',
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Famous Places'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: famousPlaces.length,
              itemBuilder: (context, index) {
                final place = famousPlaces[index];
                return ListTile(
                  title: Text(place),
                );
              },
            ),
    );
  }
}
