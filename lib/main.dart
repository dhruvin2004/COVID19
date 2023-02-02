import 'dart:convert';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import 'Global.dart';
import 'modal.dart';
import 'modal/globaldatamodal.dart';

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
    httpService.getCovidCountryData();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          FutureBuilder(
            future: httpService.getCovidCountryData(),
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
                        style: FontStyle.title,
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
                        controller: Variable.countryController,
                      ),
                      SizedBox(
                        height: 20,
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
          FutureBuilder(
              future: httpService.getCovidGlobalData(),
              builder: (context, snapshot) {
                Global data = snapshot.data;
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Global Covid19 Data",
                        style: FontStyle.title,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 200,
                        width: w,
                        padding : EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12, blurRadius: 20),
                          ],
                        ),
                        child: Column(

                          children: [
                            Text("Date : ${data.date!.day} / ${data.date!.month} / ${data.date!.year}"),
                            Text("${data.newConfirmed}"),
                            Text("${data.newRecovered}"),
                            Text("${data.newDeaths}"),
                            Text("${data.totalConfirmed}"),
                            Text("${data.totalRecovered}"),
                            Text("${data.totalDeaths}"),

                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              })
        ],
      ),
    );
  }
}

class HttpService {
  Future getCovidCountryData() async {
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

  Future getCovidGlobalData() async {
    Response response =
        await get(Uri.parse("https://api.covid19api.com/summary"));
    if (response.statusCode == 200) {
      GlobalData data = globalDataFromJson(response.body);
      Global? globaldata = data.global;
      return globaldata;
    }
  }
}
