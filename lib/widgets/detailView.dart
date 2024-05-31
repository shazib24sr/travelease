import 'package:flutter/material.dart';
import 'package:travel/widgets/Travel.dart';
import 'package:travel/widgets/VisitSpot.dart';

class DetailView extends StatelessWidget {
  final int index;
  DetailView(this.index);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Travel> _travelList = Travel.getTravelItems();

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: size.height,
              width: double.infinity,
              child: FittedBox(
                child: Image.asset(_travelList[index].imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black87.withOpacity(.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: size.height * .6,
              width: size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.topCenter,
                  stops: const [0, 1],
                  colors: [Colors.white, Colors.white.withOpacity(.03)],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            width: size.width * .8,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          _travelList[index].name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Text(
                            _travelList[index].rating.toString(),
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            const SizedBox(width: 5),
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                  text: _travelList[index].location,
                                  style: TextStyle(
                                    color: Colors.black87.withOpacity(.5),
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          ' (${_travelList[index].distance.toString()} km)',
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _travelList[index].description,
                    style: const TextStyle(
                      color: Color(0xff686771),
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.favorite_border,
                          color: Color.fromARGB(255, 0, 127, 247),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Color.fromARGB(255, 0, 127, 247)),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            List<VisitSpot> visitSpots = lst[index].visitSpots;
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    VisitSpotGrid(visitSpots)));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(9),
                            child: const Center(
                              child: Text(
                                'Discover',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 0, 127, 247),
                              border: Border.all(
                                color: Color.fromARGB(255, 0, 127, 247),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
