class Description{
  String imageUrl;
  String location;
  String rentpermonth;
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
      rentpermonth: '400',
      area: '230',
      bedrooms: '4',
      bathrooms: '3',
      phone: '078948777',
      email: 'jamal@gmail.com'),
];