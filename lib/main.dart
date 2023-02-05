import 'dart:convert';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:covid19/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart';

import 'Global.dart';

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
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              color: Colors.black, elevation: 0, centerTitle: true),),
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

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountryResponse();
  }


  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "COVID - 19",
          style: FontStyle.title,
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Search Country",
              style: FontStyle.title,
            ),
            const SizedBox(
              height: 15,
            ),
            CupertinoSearchTextField(
              backgroundColor: Colors.grey.shade900,
              placeholderStyle: TextStyle(color: Colors.white),
              itemColor: Colors.white,
              style: FontStyle.title2,
              onChanged: (val){
                setState(() {
                  Variable.searchCountry.value = val;
                });
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Country Covid Data",
              style: FontStyle.title,
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: FutureBuilder(
                future: getCountryResponse(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    print(snapshot.hasData);

                    List<AllCountry> country = snapshot.data!;

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: country.length,
                      itemBuilder: (context, index) {
                        var widget = ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ExpansionTile(
                              leading: SizedBox(width: 50,child: Image.network("${country[index].countryInfo!.flag}",)),
                              tilePadding: const EdgeInsets.symmetric(horizontal: 15),
                              title: Text("${country[index].country}", style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              expandedAlignment: Alignment.centerLeft,
                              childrenPadding: const EdgeInsets.all(10),
                              expandedCrossAxisAlignment: CrossAxisAlignment.start,
                              trailing: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Variable.country = country[index].country.toString();
                                    Navigator.push(context,MaterialPageRoute(builder: (context) => StateDetails(),),);
                                  });
                                },
                                child: Icon(CupertinoIcons.forward, color: Colors.white,),
                              ),
                              children: [
                                Text("Total Cases : ${country[index].cases}",style: FontStyle.dropdownstyle,),
                                Text("Today Cases : ${country[index].todayCases}",style: FontStyle.dropdownstyle,),
                                Text("Active Cases : ${country[index].active}",style: FontStyle.dropdownstyle,),
                                Text("Critical Cases : ${country[index].critical}",style: FontStyle.dropdownstyle,),
                                Text("Total Deaths : ${country[index].deaths}",style: FontStyle.dropdownstyle,),
                                Text("Today Deaths : ${country[index].todayDeaths}",style: FontStyle.dropdownstyle,),
                                Text("Total Recovered : ${country[index].recovered}",style: FontStyle.dropdownstyle,),
                                Text("Today Recovered : ${country[index].todayRecovered}",style: FontStyle.dropdownstyle,),
                                Text("Tests : ${country[index].tests}",style: FontStyle.dropdownstyle,),
                                Text("Continent : ${country[index].continent}",style: FontStyle.dropdownstyle,),
                              ],
                            ),
                          ),
                        );
                        if(Variable.searchCountry.value != '') {
                          if(country[index].country!.toUpperCase().contains(Variable.searchCountry.value.toUpperCase())) {
                            return widget;
                          }
                        } else {
                          return widget;
                        }
                        return Container();
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}


  Future getCountryResponse() async {
    Response res = await get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
    if(res.statusCode == 200){
      List<dynamic> data = jsonDecode(res.body);
      List covid = data.map((e) => AllCountry.fromJson(e)).toList();

      print(covid);
      return covid;
    } else {
      throw "No Data Found";
    }
  }
