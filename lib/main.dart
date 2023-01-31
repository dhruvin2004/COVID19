import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'modal.dart';




void main()
{
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
    return const MaterialApp(
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
             List<CovidData> data = snapshot.data;
             return Column(
               children: [
                 Text("${data[0].active}"),
                 Text(""),
               ],
             );
          }
           else {
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
    Response response = await get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List covid = data.map((e) => CovidData.fromJson(e)).toList();
      return covid;

    } else {
      print(response.statusCode);
      throw "Unable to retrieve posts.";
    }
  }
}