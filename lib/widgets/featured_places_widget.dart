import 'package:flutter/material.dart';
import 'package:travel/widgets/Travel.dart';
import 'package:travel/widgets/detailView.dart';

class FeauterdPlacesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Travel> _travelList = Travel.getTravelItems();
    List<Travel> _nearestTravelList = Travel.getNearestItems();
    return Container(
      margin: const EdgeInsets.only(top: 16),
      height: size.height * .82,
      child: SingleChildScrollView(
        child: Column(
          children: _travelList.map((travel) {
            final index = _travelList.indexOf(travel);
            if (index < 6) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailView(index),
                    ));
                  },
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        child: Image.asset(
                          travel.imageUrl,
                          fit: BoxFit.fill,
                          height: 90.0,
                          width: 70.0,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              travel.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  travel.location,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Color(0xff686771),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    Text(
                                      travel.rating.toString(),
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return SizedBox(); // Return an empty SizedBox for items beyond the 5th index
            }
          }).toList(),
        ),
      ),
    );
  }
}
