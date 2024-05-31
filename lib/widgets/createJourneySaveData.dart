import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel/widgets/places.dart';
import 'package:intl/intl.dart';
import 'package:travel/widgets/VisitSpot.dart';

class CreatedJourney extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreatedJourneyState();
  }
}

class TravelData {
  final String routeName;
  final String pickupLocation;
  final String destination;
  final DateTime startDate;
  final String count; // Added count field

  TravelData({
    required this.routeName,
    required this.pickupLocation,
    required this.destination,
    required this.startDate,
    required this.count, // Updated constructor
  });
}

class CreatedJourneyState extends State<CreatedJourney> {
  late Future<List<TravelData>> travelDataList;

  @override
  void initState() {
    super.initState();
    travelDataList = loadData();
  }

  void navigateToVisitSpotGrid(String destination, String? date, String? time) {
    VisitSpotList? selectedList;
    for (var list in lst) {
      if (list.destination == destination) {
        selectedList = list;
        print('Match found for $destination');
        break;
      }
    }
    print(destination);
    print(selectedList);
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

  Future<List<TravelData>> loadData() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection("datastore").get();
    List<TravelData> dataList = [];

    querySnapshot.docs.forEach((doc) {
      dataList.add(TravelData(
        routeName: doc["route_name"],
        pickupLocation: doc["pickup_location"],
        destination: doc["destination"],
        startDate: (doc["journey_date"] as Timestamp)
            .toDate(), // Convert Timestamp to DateTime
        count: doc["count"], // Fetch count from Firestore
      ));
    });

    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Planned Journies',
          style: TextStyle(color: Color.fromARGB(255, 0, 127, 247)),
        ),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 0, 127, 247)),
      ),
      body: FutureBuilder(
        future: travelDataList,
        builder:
            (BuildContext context, AsyncSnapshot<List<TravelData>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final travel = snapshot.data![index];
                  return LongPressDraggable(
                    feedback: Material(
                      child: ListTile(
                        title: Text(travel.routeName),
                        subtitle: Text(travel.pickupLocation),
                      ),
                    ),
                    childWhenDragging: Container(),
                    onDragStarted: () {
                      // Show delete confirmation dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Delete Item"),
                            content: Text(
                              "Are you sure you want to delete this item?",
                              style: TextStyle(
                                  color: Color.fromARGB(
                                      255, 0, 127, 247)), // Set text color
                            ),
                            backgroundColor: Colors.white,
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Colors.grey), // Set text color
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  // Delete data from Firestore
                                  await FirebaseFirestore.instance
                                      .collection("datastore")
                                      .where("route_name",
                                          isEqualTo: travel.routeName)
                                      .where("pickup_location",
                                          isEqualTo: travel.pickupLocation)
                                      .where("destination",
                                          isEqualTo: travel.destination)
                                      .get()
                                      .then((snapshot) {
                                    snapshot.docs.first.reference.delete();
                                  });
                                  // Update UI
                                  setState(() {
                                    travelDataList = loadData();
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text("Delete",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 127, 247),
                                    )),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Padding(
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
                                travel.destination,
                                DateFormat('yyyy-MM-dd')
                                    .format(travel.startDate),
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
                                        const SizedBox(height: 4.0),
                                        Text(
                                          "Start Date: ${DateFormat.yMd().add_jm().format(travel.startDate)}",
                                        ),
                                        const SizedBox(height: 4.0),
                                        Text(
                                          "Count: ${travel.count}",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey,
                                          ),
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
                    ),
                  );
                },
              );
            }
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: Color.fromARGB(255, 0, 127, 247),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Plan Journey",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Saved Journies",
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, "/home");
          }
          if (index == 1) {
            Navigator.pushNamed(context, "/create_journey");
          }
          if (index == 2) {}
        },
      ),
    );
  }
}
