import 'package:flutter/material.dart';
import 'package:travel/widgets/Travel.dart';
import 'package:travel/widgets/appDrawer.dart';
import 'package:travel/widgets/searched.dart';
import 'package:travel/widgets/featured_places_widget.dart';
import 'package:travel/widgets/nearest_places_widget.dart';

class Home extends StatefulWidget {
  //final Function(String) onSubmitted;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Travel> _travelList = Travel.getTravelItems();
    List<Travel> _nearestTravelList = Travel.getNearestItems();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: Color.fromARGB(255, 0, 127, 247),
            ),
            const Text(
              'Gujranwala, Pakistan',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 127, 247),
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Discover',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 127, 247),
                    fontSize: 32,
                    height: 1.3,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' the Best Places to Travel',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(.8),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 0, 127, 247),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search Places',
                            contentPadding: EdgeInsets.only(
                                left: 8.0,
                                bottom: 1.0), // Add left and bottom padding
                          ),
                          onSubmitted: (value) {
                            // Navigate to the searched screen when the Enter button is pressed
                            if (value.isNotEmpty) {
                              // Clear the TextField
                              _searchController.clear();
                              // Execute after the current frame has finished building
                              WidgetsBinding.instance!
                                  .addPostFrameCallback((_) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SearchedScreen(searchQuery: value),
                                  ),
                                );
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 127, 247).withOpacity(.1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Nearest to you',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // Text(
                  //   'View All',
                  //   style: TextStyle(
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.w600,
                  //       color: Color.fromARGB(255, 0, 127, 247)),
                  // ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                height: size.height * .4,
                child: NearestPlacesWidget(), // Use NearestPlacesWidget here
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Featured Places',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // Text(
                  //   'View All',
                  //   style: TextStyle(
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.w600,
                  //       color: Color.fromARGB(255, 0, 127, 247)),
                  // ),
                ],
              ),
              Container(
                child: FeauterdPlacesWidget(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.info),
          //   label: "About",
          // ),
        ],
        onTap: (index) {
          if (index == 0) {}
          if (index == 1) {
            Navigator.pushNamed(context, "/create_journey");
          }
          if (index == 2) {
            Navigator.pushNamed(context, "/createdJourney");
          }
          // if (index == 3) {
          //   Navigator.pushNamed(context, "/about");
          // }
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
