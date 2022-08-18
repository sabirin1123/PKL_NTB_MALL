class Umkm {
  final int id;
  final String name;
  final String address;
  final String owner;
  final String districts;
  final String subdistricts;
  final String type;
  final String type_business;
  final double latitude;
  final double longitude;

  const Umkm({
    required this.id,
    required this.name,
    required this.address,
    required this.owner,
    required this.districts,
    required this.subdistricts,
    required this.type,
    required this.type_business,
    required this.latitude,
    required this.longitude,
  });

  factory Umkm.fromJson(Map<String, dynamic> json) {
    return Umkm(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        owner: json['owner'],
        districts: json['districts'],
        subdistricts: json['subdistricts'],
        type: json['type'],
        type_business: json['type_business'],
        latitude: json['latitude'],
        longitude: json['longitude']);
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();

  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['address'] = this.address;
  //   data['owner'] = this.owner;
  //   data['districts'] = this.districts;
  //   data['subdistricts'] = this.subdistricts;
  //   data['type'] = this.type;
  //   data['type_business'] = this.type_business;
  //   data['latitude'] = this.latitude;
  //   data['longitude'] = this.longitude;
  // }
}
