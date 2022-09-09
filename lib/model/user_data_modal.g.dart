// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_modal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Userdata _$UserdataFromJson(Map<String, dynamic> json) => Userdata(
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      id: json['id'] as int?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      name: json['name'] == null
          ? null
          : Name.fromJson(json['name'] as Map<String, dynamic>),
      phone: json['phone'] as String?,
      v: json['v'] as int?,
    );

Map<String, dynamic> _$UserdataToJson(Userdata instance) => <String, dynamic>{
      'address': instance.address,
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'password': instance.password,
      'name': instance.name,
      'phone': instance.phone,
      'v': instance.v,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      geolocation: json['geolocation'] == null
          ? null
          : Geolocation.fromJson(json['geolocation'] as Map<String, dynamic>),
      city: json['city'] as String?,
      street: json['street'] as String?,
      number: json['number'] as int?,
      zipcode: json['zipcode'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'geolocation': instance.geolocation,
      'city': instance.city,
      'street': instance.street,
      'number': instance.number,
      'zipcode': instance.zipcode,
    };

Geolocation _$GeolocationFromJson(Map<String, dynamic> json) => Geolocation(
      lat: json['lat'] as String?,
      long: json['long'] as String?,
    );

Map<String, dynamic> _$GeolocationToJson(Geolocation instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'long': instance.long,
    };

Name _$NameFromJson(Map<String, dynamic> json) => Name(
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
    );

Map<String, dynamic> _$NameToJson(Name instance) => <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
    };
