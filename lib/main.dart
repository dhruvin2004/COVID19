import 'dart:convert';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import 'Global.dart';
import 'modal.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HttpService httpService = HttpService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    httpService.getCovidData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: httpService.getCovidData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CountryData> data = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Country",
                    style: GoogleFonts.lato(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomDropdown.search(
                    listItemStyle: GoogleFonts.lato(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                    hintText: 'Select Country',
                    items: [
                      ...data!
                          .map((CountryData e) => e.country.toString())
                          .toList(),
                    ],
                    controller: Global.countryController,
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class HttpService {
  Future getCovidData() async {
    Response response =
        await get(Uri.parse('https://api.covid19api.com/countries'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List covid = data.map((e) => CountryData.fromJson(e)).toList();
      return covid;
    } else {
      print(response.statusCode);
      throw "Unable to retrieve posts.";
    }
  }
}
