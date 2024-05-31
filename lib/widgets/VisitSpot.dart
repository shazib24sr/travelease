import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import 'package:travel/widgets/gmap.dart';

class VisitSpot {
  String spotName;
  String image;
  String? date;
  int? time;

  VisitSpot({
    required this.spotName,
    required this.image,
    this.date,
    this.time,
  });
}

class VisitSpotList {
  String destination;
  int count = 0;
  List<VisitSpot> visitSpots;

  VisitSpotList(this.visitSpots, this.destination, this.count);
}

List<VisitSpotList> lst = [
  VisitSpotList([
    VisitSpot(
      spotName: "Departure Gujranwala",
      image: "images/guj.jpg",
      date: "",
      time: 0,
    ),
    VisitSpot(
      spotName: "Arrival at Rahwali Gate",
      image: "images/rah.jpeg",
      date: "",
      time: 20,
    ),
    VisitSpot(
      spotName: "Arrival at Nishan Manzil",
      image: "images/nm.jpeg",
      date: "",
      time: 30,
    ),
  ], "Gujranwala", 3),
  VisitSpotList([
    VisitSpot(
      spotName: "Departure Gujranwala",
      image: "images/guj.jpg",
      date: "",
      time: 0,
    ),
    VisitSpot(
      spotName: "Rahwali Gate",
      image: "images/rah.jpeg",
      date: "",
      time: 20,
    ),
    VisitSpot(
      spotName: "Dak Chowki, Wazirabad",
      image: "images/dak.jpg",
      date: "",
      time: 50,
    ),
    VisitSpot(
      spotName: "Kinara Hotel, Gujrat",
      image: "images/kinara.png",
      date: "",
      time: 70,
    ),
    VisitSpot(
      spotName: "Gujrat Muesam",
      image: "images/img6.jpeg",
      date: "",
      time: 80,
    ),
  ], "Gujrat", 5),
  VisitSpotList([
    VisitSpot(
      spotName: "Departure Gujranwala",
      image: "images/guj.jpg",
      date: "",
      time: 0,
    ),
    VisitSpot(
      spotName: "Gurdwara Rori Sahib, Eminabad",
      image: "images/emin.jpg",
      date: "",
      time: 20,
    ),
    VisitSpot(
      spotName: "Mall of Muridke, Muridke",
      image: "images/murd.jpeg",
      date: "",
      time: 40,
    ),
    VisitSpot(
      spotName: "Arrival at Minar-e-Pakistan, Lahore",
      image: "images/img1.jpg",
      date: "",
      time: 60,
    ),
    VisitSpot(
      spotName: "Explore Badshahi Mosque, Lahore",
      image: "images/badshahi.jpg",
      date: "",
      time: 70,
    ),
    VisitSpot(
      spotName: "Lahore Fort, Lahore",
      image: "images/fort.jpg",
      date: "",
      time: 80,
    ),
  ], "Lahore", 6),
  VisitSpotList([
    VisitSpot(
      spotName: "Departure Gujranwala",
      image: "images/guj.jpg",
      date: "",
      time: 0,
    ),
    VisitSpot(
      spotName: "Heran Minar, Sheikhupura",
      image: "images/hiran.jpg",
      date: "",
      time: 40,
    ),
    VisitSpot(
      spotName: "Sangla Hill",
      image: "images/sang.jpg",
      date: "",
      time: 70,
    ),
    VisitSpot(
      spotName: "Clock Tower, Faislabad",
      image: "images/img2.jpg",
      date: "",
      time: 110,
    ),
    VisitSpot(
      spotName: "Titanic Resort, Faislabad",
      image: "images/titanic.jpg",
      date: "",
      time: 120,
    ),
    VisitSpot(
      spotName: "Lyalpur Galleria, Faislabad",
      image: "images/lyal.jpg",
      date: "",
      time: 130,
    ),
  ], "Faislabad", 6),
  VisitSpotList([
    VisitSpot(
      spotName: "Departure Gujranwala",
      image: "images/guj.jpg",
      date: "",
      time: 0,
    ),
    VisitSpot(
      spotName: "Harrapa Muesam, Sahiwal",
      image: "images/harapa.jpg",
      date: "",
      time: 200,
    ),
    VisitSpot(
      spotName: "Multan Arrival",
      image: "images/img4.jpg",
      date: "",
      time: 280,
    ),
    VisitSpot(
      spotName: "Clock Tower, Multan",
      image: "images/clkmultan.jpg",
      date: "",
      time: 290,
    ),
    VisitSpot(
      spotName: "Qila Kohna Muesam, Multan",
      image: "images/mulmues.jpg",
      date: "",
      time: 300,
    ),
  ], "Multan", 5),
  VisitSpotList([
    VisitSpot(
      spotName: "Departure Gujranwala",
      image: "images/guj.jpg",
      date: "",
      time: 0,
    ),
    VisitSpot(
      spotName: "Harrapa Muesam, Sahiwal",
      image: "images/harapa.jpg",
      date: "",
      time: 200,
    ),
    VisitSpot(
      spotName: "Multan Arrival",
      image: "images/img4.jpg",
      date: "",
      time: 280,
    ),
    VisitSpot(
      spotName: "Clock Tower, Multan",
      image: "images/clkmultan.jpg",
      date: "",
      time: 290,
    ),
    VisitSpot(
      spotName: "Noor Mahal, Bahwalpur",
      image: "images/noor.jpg",
      date: "",
      time: 380,
    ),
    VisitSpot(
      spotName: "Sukhur Beraje",
      image: "images/sukh.jpg",
      date: "",
      time: 500,
    ),
    VisitSpot(
      spotName: "Tomb of Quaid-e-Azam, Karachi",
      image: "images/img5.jpg",
      date: "",
      time: 700,
    ),
    VisitSpot(
      spotName: "Sea view, Karachi",
      image: "images/seaview.jpeg",
      date: "",
      time: 750,
    ),
    VisitSpot(
      spotName: "Teen Talwar Clifton, Karachi",
      image: "images/talwar.jpg",
      date: "",
      time: 780,
    ),
  ], "Karachi", 0),
];

class VisitSpotGrid extends StatelessWidget {
  final List<VisitSpot> visitSpots;
  final String? date;
  final String? time;

  VisitSpotGrid(this.visitSpots, {this.date, this.time});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visit Spots'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.75, // Adjust child aspect ratio
        ),
        itemCount: visitSpots.length,
        itemBuilder: (BuildContext context, int index) {
          final spot = visitSpots[index];
          DateTime? spotTime;
          if (date != null && time != null) {
            spotTime = DateTime.parse('$date $time')
                .add(Duration(minutes: spot.time ?? 0));
          }

          return GestureDetector(
            onTap: () {},
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 120, // Fixed height for images
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                      child: Image.asset(
                        spot.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            spot.spotName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (spotTime != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                'Date: ${DateFormat('yyyy-MM-dd').format(spotTime)}, Time: ${DateFormat('HH:mm').format(spotTime)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
