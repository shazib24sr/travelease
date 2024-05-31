class Travel {
  final String name;
  final String description;
  final String location;
  final double rating;
  final int distance;
  final String imageUrl;
  Travel(this.name, this.description, this.location, this.rating, this.distance,
      this.imageUrl);

  static List<Travel> getTravelItems() {
    final List<Travel> _travelList = [
      Travel('Nishan Manzil', 'The beautiful place to explore in Rahwali Cant',
          'Gujranwala, Pakistan', 4.7, 12, 'images/img3.jpg'),
      Travel(
          'Gujrat Muesam',
          'Explore the beautiful and historic sights at Gujrat Muesam, Gujrat',
          'Gujrat, Pakistan',
          4.2,
          46,
          'images/thumb6.jpeg'),
      Travel(
        'Minar-e-Pakistan',
        'Explore the historical place in the heart of Punjab',
        'Lahore, Pakistan',
        4.9,
        78,
        'images/thumb1.jpg',
      ),
      Travel(
          'Clock Tower Faislabad',
          'In the center of the city, here the clock tower is located',
          'Faislabad, Pakistan',
          4.6,
          156,
          'images/img2.jpg'),
      Travel(
          'Tomb of Bahudin Zakria',
          'Where the heart goes, Explore the landmark of sufisim',
          'Multan, Pakistan',
          4.8,
          788,
          'images/thumb4.jpg'),
      Travel(
          'Tomb of Quaid-e-Azam',
          'Explore the place where the founder of Pakistan is burrried',
          'Karachi, Pakistan',
          4.8,
          1344,
          'images/thumb5.jpg'),
    ];
    return _travelList;
  }

  static List<Travel> getNearestItems() {
    List<Travel> _travelList = Travel.getTravelItems();
    return _travelList.where((element) => element.distance < 100).toList();
  }
}
