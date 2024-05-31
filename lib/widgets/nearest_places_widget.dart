import 'package:flutter/material.dart';
import 'package:travel/widgets/Travel.dart';

import 'package:travel/widgets/detailView.dart';

class NearestPlacesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Travel> _travelList = Travel.getTravelItems();
    List<Travel> _nearestTravelList = Travel.getNearestItems();

    return Container(
      margin: const EdgeInsets.only(top: 16),
      height: size.height * .4,
      child: ListView.builder(
          itemCount: _nearestTravelList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailView(index)));
                },
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(24),
                      ),
                      child: Image.asset(_nearestTravelList[index].imageUrl),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, .5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            )),
                        child: Text(
                          _nearestTravelList[index].distance.toString() +
                              "km away",
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
