import 'package:json_annotation/json_annotation.dart';

part 'user_data_modal.g.dart';

@JsonSerializable()
class Userdata {
  Address? address;

  Userdata({
    this.address,
    this.id,
    this.email,
    this.username,
    this.password,
    this.name,
    this.phone,
    this.v,
  });
  int? id;
  String? email;
  String? username;
  String? password;
  Name? name;
  String? phone;
  int? v;

  factory Userdata.fromJson(Map<String, dynamic> json) =>
      _$UserdataFromJson(json);

  Map<String, dynamic> toJson() => _$UserdataToJson(this);
  }

@JsonSerializable()
class Address {
  Address({
    this.geolocation,
    this.city,
    this.street,
    this.number,
    this.zipcode,
  });

  Geolocation? geolocation;
  String? city;
  String? street;
  int? number;
  String? zipcode;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Geolocation {
  Geolocation({
    this.lat,
    this.long,
  });

  String? lat;
  String? long;

  factory Geolocation.fromJson(Map<String, dynamic> json) =>
      _$GeolocationFromJson(json);

  Map<String, dynamic> toJson() => _$GeolocationToJson(this);
}

@JsonSerializable()
class Name {
  Name({
    this.firstname,
    this.lastname,
  });

  String? firstname;
  String? lastname;

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);

  Map<String, dynamic> toJson() => _$NameToJson(this);
}
