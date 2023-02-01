// To parse this JSON data, do
//
//     final countryData = countryDataFromJson(jsonString);

import 'dart:convert';

List<CountryData> countryDataFromJson(String str) => List<CountryData>.from(json.decode(str).map((x) => CountryData.fromJson(x)));

String countryDataToJson(List<CountryData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryData {
  CountryData({
    this.country,
    this.slug,
    this.iso2,
  });

  String? country;
  String? slug;
  String? iso2;

  factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
    country: json["Country"],
    slug: json["Slug"],
    iso2: json["ISO2"],
  );

  Map<String, dynamic> toJson() => {
    "Country": country,
    "Slug": slug,
    "ISO2": iso2,
  };
}
