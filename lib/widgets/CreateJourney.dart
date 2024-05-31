import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateJourney extends StatefulWidget {
  @override
  _CreateJourneyState createState() => _CreateJourneyState();
}

class _CreateJourneyState extends State<CreateJourney> {
  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
    _selectedDestination = "Lahore";
  }

  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _routeNameController = TextEditingController();
  String _selectedPickupLocation = "Gujranwala"; // Default pickup location
  late String _selectedDestination = "Lahore"; // Default destination

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  List<String> locations = [
    "Lahore",
    "Gujrat",
    "Faislabad",
    "Karachi",
    "Multan",
    "Gujranwala",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Plan your Journey',
          style: TextStyle(color: Color.fromARGB(255, 0, 127, 247)),
        ),
        //backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 0, 127, 247)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _routeNameController,
                decoration: InputDecoration(
                  labelText: 'Route Name',
                  prefixIcon: const Icon(
                    Icons.near_me_sharp,
                    color: Color.fromARGB(255, 0, 127, 247),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 127, 247).withOpacity(.1),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 127, 247).withOpacity(.1),
                    ),
                  ), // Remove the outline border
                  filled: true,
                  fillColor:
                      const Color.fromARGB(255, 0, 127, 247).withOpacity(.1),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0), // Reduce the height
                ),
                style: const TextStyle(
                    fontSize: 16.0), // Adjust text size if needed
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'Pickup Location: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedPickupLocation,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedPickupLocation = newValue ?? "Gujranwala";
                        });
                      },
                      items: <String>['Gujranwala'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 0, 127, 247)
                                .withOpacity(.1),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 0, 127, 247)
                                .withOpacity(.1),
                          ),
                        ), // Remove the outline border
                        filled: true,
                        fillColor: const Color.fromARGB(255, 0, 127, 247)
                            .withOpacity(.1),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 10.0), // Reduce the height
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text('Destination: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedDestination,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedDestination = newValue ?? locations.first;
                        });
                      },
                      items: locations.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 0, 127, 247)
                                .withOpacity(.1),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 0, 127, 247)
                                .withOpacity(.1),
                          ),
                        ),
                        filled: true,
                        fillColor:
                            Color.fromARGB(255, 0, 127, 247).withOpacity(.1),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 10.0), // Reduce the height
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Date: ${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.date_range,
                        color: Color.fromARGB(255, 0, 127, 247)),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Time: ${_selectedTime.hour}:${_selectedTime.minute}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.access_time,
                        color: Color.fromARGB(255, 0, 127, 247)),
                    onPressed: () => _selectTime(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    String routeName = _routeNameController.text;
                    String pickupLocation = _selectedPickupLocation;
                    String destination = _selectedDestination;
                    DateTime journeyDateTime = DateTime(
                      _selectedDate.year,
                      _selectedDate.month,
                      _selectedDate.day,
                      _selectedTime.hour,
                      _selectedTime.minute,
                    );
                    CollectionReference collRef =
                        FirebaseFirestore.instance.collection("datastore");
                    try {
                      await collRef.add({
                        'route_name': routeName,
                        'pickup_location': pickupLocation,
                        'destination': destination,
                        'journey_date': journeyDateTime,
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Journey Created'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      Navigator.pushNamed(context, "/home");
                    } catch (e) {
                      print("Error adding data: $e");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 0, 127, 247),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text('Create Journey',
                      style: TextStyle(fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Color.fromARGB(255, 0, 127, 247),
        unselectedItemColor: Colors.grey,
        items: const [
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
            label: "Saved Journeys",
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, "/home");
          }
          if (index == 1) {}
          if (index == 2) {
            Navigator.pushNamed(context, "/createdJourney");
          }
        },
      ),
    );
  }
}
