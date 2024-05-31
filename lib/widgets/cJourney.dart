class Journey {
  String? routeName;
  String? pickupLocation;
  String? destination;

  Journey({
    required this.routeName,
    required this.pickupLocation,
    required this.destination,
  });

  Journey.fromJson(Map<String, dynamic> mp) {
    routeName = mp["routeName"];
    pickupLocation = mp["pickupLocation"];
    destination = mp["destination"];
  }

  Map<String, dynamic> toJson() {
    return {
      "routeName": routeName,
      "pickupLocation": pickupLocation,
      "destination": destination
    };
  }
}
