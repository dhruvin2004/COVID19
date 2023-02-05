// To parse this JSON data, do
//
//     final allState = allStateFromJson(jsonString);

import 'dart:convert';

List<AllState> allStateFromJson(String str) => List<AllState>.from(json.decode(str).map((x) => AllState.fromJson(x)));

String allStateToJson(List<AllState> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllState {
  AllState({
    this.id,
    this.country,
    this.countryCode,
    this.province,
    this.city,
    this.cityCode,
    this.lat,
    this.lon,
    this.confirmed,
    this.deaths,
    this.recovered,
    this.active,
    this.date,
  });

  String? id;
  Country? country;
  CountryCode? countryCode;
  Province? province;
  String? city;
  String? cityCode;
  String? lat;
  String? lon;
  int? confirmed;
  int? deaths;
  int? recovered;
  int? active;
  DateTime? date;

  factory AllState.fromJson(Map<String, dynamic> json) => AllState(
    id: json["ID"],
    country: countryValues.map[json["Country"]]!,
    countryCode: countryCodeValues.map[json["CountryCode"]]!,
    province: provinceValues.map[json["Province"]]!,
    city: json["City"],
    cityCode: json["CityCode"],
    lat: json["Lat"],
    lon: json["Lon"],
    confirmed: json["Confirmed"],
    deaths: json["Deaths"],
    recovered: json["Recovered"],
    active: json["Active"],
    date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Country": countryValues.reverse[country],
    "CountryCode": countryCodeValues.reverse[countryCode],
    "Province": provinceValues.reverse[province],
    "City": city,
    "CityCode": cityCode,
    "Lat": lat,
    "Lon": lon,
    "Confirmed": confirmed,
    "Deaths": deaths,
    "Recovered": recovered,
    "Active": active,
    "Date": date?.toIso8601String(),
  };
}

enum Country { INDIA }

final countryValues = EnumValues({
  "India": Country.INDIA
});

enum CountryCode { IN }

final countryCodeValues = EnumValues({
  "IN": CountryCode.IN
});

enum Province { SIKKIM, WEST_BENGAL, MEGHALAYA, JHARKHAND, TRIPURA, ANDHRA_PRADESH, MANIPUR, ASSAM, HIMACHAL_PRADESH, TAMIL_NADU, TELANGANA, HARYANA, BIHAR, MAHARASHTRA, CHHATTISGARH, NAGALAND, DELHI, CHANDIGARH, LAKSHADWEEP, PUNJAB, UTTAR_PRADESH, PUDUCHERRY, KARNATAKA, ARUNACHAL_PRADESH, ANDAMAN_AND_NICOBAR_ISLANDS, MIZORAM, MADHYA_PRADESH, RAJASTHAN, GOA, JAMMU_AND_KASHMIR, LADAKH, ODISHA, DADRA_AND_NAGAR_HAVELI_AND_DAMAN_AND_DIU, UTTARAKHAND, KERALA, GUJARAT }

final provinceValues = EnumValues({
  "Andaman and Nicobar Islands": Province.ANDAMAN_AND_NICOBAR_ISLANDS,
  "Andhra Pradesh": Province.ANDHRA_PRADESH,
  "Arunachal Pradesh": Province.ARUNACHAL_PRADESH,
  "Assam": Province.ASSAM,
  "Bihar": Province.BIHAR,
  "Chandigarh": Province.CHANDIGARH,
  "Chhattisgarh": Province.CHHATTISGARH,
  "Dadra and Nagar Haveli and Daman and Diu": Province.DADRA_AND_NAGAR_HAVELI_AND_DAMAN_AND_DIU,
  "Delhi": Province.DELHI,
  "Goa": Province.GOA,
  "Gujarat": Province.GUJARAT,
  "Haryana": Province.HARYANA,
  "Himachal Pradesh": Province.HIMACHAL_PRADESH,
  "Jammu and Kashmir": Province.JAMMU_AND_KASHMIR,
  "Jharkhand": Province.JHARKHAND,
  "Karnataka": Province.KARNATAKA,
  "Kerala": Province.KERALA,
  "Ladakh": Province.LADAKH,
  "Lakshadweep": Province.LAKSHADWEEP,
  "Madhya Pradesh": Province.MADHYA_PRADESH,
  "Maharashtra": Province.MAHARASHTRA,
  "Manipur": Province.MANIPUR,
  "Meghalaya": Province.MEGHALAYA,
  "Mizoram": Province.MIZORAM,
  "Nagaland": Province.NAGALAND,
  "Odisha": Province.ODISHA,
  "Puducherry": Province.PUDUCHERRY,
  "Punjab": Province.PUNJAB,
  "Rajasthan": Province.RAJASTHAN,
  "Sikkim": Province.SIKKIM,
  "Tamil Nadu": Province.TAMIL_NADU,
  "Telangana": Province.TELANGANA,
  "Tripura": Province.TRIPURA,
  "Uttarakhand": Province.UTTARAKHAND,
  "Uttar Pradesh": Province.UTTAR_PRADESH,
  "West Bengal": Province.WEST_BENGAL
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}