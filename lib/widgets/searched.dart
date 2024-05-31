import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';
import 'package:travel/widgets/VisitSpot.dart';

class SearchedScreen extends StatelessWidget {
  final String searchQuery;

  const SearchedScreen({Key? key, required this.searchQuery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Result'),
      ),
      body: FutureBuilder(
        future: loadData(
            searchQuery), // Pass the search query to the loadData function
        builder:
            (BuildContext context, AsyncSnapshot<List<TravelData>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.data!.isEmpty) {
              return Center(
                child: Text("No result found"),
              );
            } else {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final travel = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        color:
                            Color.fromARGB(255, 0, 127, 247).withOpacity(0.1),
                        child: InkWell(
                          onTap: () {
                            navigateToVisitSpotGrid(
                              context,
                              travel.destination,
                              DateFormat('yyyy-MM-dd').format(travel.startDate),
                              DateFormat('HH:mm').format(travel.startDate),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      const Color.fromARGB(255, 0, 106, 192),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        travel.routeName,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        travel.pickupLocation,
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        travel.destination,
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      Text(
                                        "Start Date: ${DateFormat.yMd().add_jm().format(travel.startDate)}",
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }

  Future<List<TravelData>> loadData(String searchQuery) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection("datastore")
        .where("destination")
        .get(); // Filter Firestore data based on the search query

    List<TravelData> dataList = [];

    querySnapshot.docs.forEach((doc) {
      String destination = doc["destination"].toString().toLowerCase();
      if (destination.contains(searchQuery.toLowerCase())) {
        // Check if the destination contains the search query (case-insensitive)
        dataList.add(TravelData(
          routeName: doc["route_name"],
          pickupLocation: doc["pickup_location"],
          destination: doc["destination"],
          startDate: (doc["journey_date"] as Timestamp).toDate(),
        ));
      }
    });
    print(searchQuery);
    print(dataList);

    return dataList;
  }
}

void navigateToVisitSpotGrid(
    BuildContext context, String destination, String? date, String? time) {
  VisitSpotList? selectedList;
  for (var list in lst) {
    if (list.destination == destination) {
      selectedList = list;
      break;
    }
  }

  if (selectedList != null) {
    // Navigate to VisitSpotGrid with the selected VisitSpotList
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VisitSpotGrid(
          selectedList!.visitSpots,
          date: date,
          time: time,
        ),
      ),
    );
  } else {
    // Handle case where destination is not found
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Destination Not Found"),
          content: Text("No visit spots found for destination: $destination"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class TravelData {
  final String routeName;
  final String pickupLocation;
  final String destination;
  final DateTime startDate; // Added startDate field

  TravelData({
    required this.routeName,
    required this.pickupLocation,
    required this.destination,
    required this.startDate, // Updated constructor
  });
}
