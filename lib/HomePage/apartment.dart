import 'package:flutter_app/HomePage/description.dart';

class Apartment {
  String imageUrl;
  String location;
  String area;
  int rentpermonth;
  List<Description> description;

  Apartment(
      {this.imageUrl,
        this.location,
        this.area,
        this.rentpermonth,
        this.description});
}

class Office {
  String imageUrl;
  String location;
  String area;
  int rentpermonth;
  List<Description> description;

  Office(
      {this.imageUrl,
        this.location,
        this.area,
        this.rentpermonth,
        this.description});
}

class Description {
  String imageUrl;
  String location;
  int rentpermonth;
  String area;
  String bedrooms;
  String bathrooms;
  String phone;
  String email;

  Description({
    this.imageUrl,
    this.location,
    this.rentpermonth,
    this.area,
    this.bedrooms,
    this.bathrooms,
    this.phone,
    this.email,
  });
}

List<Description> descriptions = [
  Description(
      imageUrl: 'assets/images/1a.jpg',
      location: 'Near new english school,Khalda',
      rentpermonth: 400,
      area: '230',
      bedrooms: '4',
      bathrooms: '3',
      phone: '078948777',
      email: 'jamal@gmail.com'),
  Description(
      imageUrl: 'assets/images/1a.jpg',
      location: 'Near new english school,Khalda',
      rentpermonth: 400,
      area: '230',
      bedrooms: '4',
      bathrooms: '3',
      phone: '078948777',
      email: 'jamal@gmail.com'),
  Description(
      imageUrl: 'assets/images/1a.jpg',
      location: 'Near new english school,Khalda',
      rentpermonth: 400,
      area: '230',
      bedrooms: '4',
      bathrooms: '3',
      phone: '078948777',
      email: 'jamal@gmail.com'),
  Description(
      imageUrl: 'assets/images/1a.jpg',
      location: 'Near new english school,Khalda',
      rentpermonth: 400,
      area: '230',
      bedrooms: '4',
      bathrooms: '3',
      phone: '078948777',
      email: 'jamal@gmail.com'),
];
List<Apartment> apartments = [
  Apartment(
    imageUrl: 'assets/images/1.jpg',
    location: 'Khalda,Amman',
    area: '230',
    rentpermonth: 400,
  ),
  Apartment(
    imageUrl: 'assets/images/2.jpg',
    location: 'Marj Al-hamam,Amman',
    area: '230',
    rentpermonth: 350,
  ),
  Apartment(
    imageUrl: 'assets/images3.jpg',
    location: 'Hesban,Madaba',
    area: '230',
    rentpermonth: 500,
  ),
  Apartment(
    imageUrl: 'assets/images/4.jpg',
    location: 'Rabia,Amman',
    area: '230',
    rentpermonth: 400,
  ),
];
List<Office> offices = [
  Office(
    imageUrl: 'assets/images/1.jpg',
    location: 'Khalda,Amman',
    area: '230',
    rentpermonth: 400,
  ),
  Office(
    imageUrl: 'assets/images/2.jpg',
    location: 'Marj Al-hamam,Amman',
    area: '230',
    rentpermonth: 350,
  ),
  Office(
    imageUrl: 'assets/images/2.jpg',
    location: 'Marj Al-hamam,Amman',
    area: '230',
    rentpermonth: 350,
  ),
];