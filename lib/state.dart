import 'dart:convert';

import 'package:covid19/Global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'modal/statemodal.dart';



class StateDetails extends StatefulWidget {
  const StateDetails({Key? key}) : super(key: key);

  @override
  State<StateDetails> createState() => _StateDetailsState();
}

class _StateDetailsState extends State<StateDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(CupertinoIcons.back, color: Colors.white,),
        ),
        title: Text("COVID - 19", style: FontStyle.title,),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 10,),
            CupertinoSearchTextField(
              backgroundColor: Colors.grey.shade900,
              itemColor: Colors.white,
              placeholderStyle: TextStyle(color: Colors.white),
              style: FontStyle.title,
              onChanged: (val){
                setState(() {
                  Variable.searchState.value = val;
                });
              },
            ),
            SizedBox(height: 15,),
            Expanded(
              child: FutureBuilder(
                future: getStateResponse(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    List<AllState> state = snapshot.data;
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemCount: state.length,
                      itemBuilder: (context, index) {
                        var widget = ClipRRect(

                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ExpansionTile(
                               collapsedIconColor: Colors.white,
                              tilePadding: const EdgeInsets.symmetric(horizontal: 15),
                              title: Text("${state[index].province}".substring(9), style: FontStyle.title,),
                              subtitle: Text("${state[index].date}".substring(0,10), style: TextStyle(color: Colors.grey.shade700,fontWeight: FontWeight.w400),),
                              expandedAlignment: Alignment.centerLeft,
                              childrenPadding: const EdgeInsets.all(10),
                              expandedCrossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Total Cases : ${state[index].confirmed}",style: FontStyle.dropdownstyle,),
                                Text("Active Case : ${state[index].active}",style: FontStyle.dropdownstyle),
                                Text("Recovered : ${state[index].recovered}",style: FontStyle.dropdownstyle),
                                Text("Deaths : ${state[index].deaths}",style: FontStyle.dropdownstyle),
                              ],
                            ),
                          ),
                        );
                        if(Variable.searchState.value != '') {
                          if(state[index].province.toString().toUpperCase().contains(Variable.searchState.value.toUpperCase())) {
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
      backgroundColor: Colors.black,
    );
  }

  Future getStateResponse() async {
    Response res = await get(Uri.parse('https://api.covid19api.com/live/country/india/status/status'));
    if(res.statusCode == 200) {
      List<dynamic> data = jsonDecode(res.body);
      List state = data.map((e) => AllState.fromJson(e)).toList();
      return state;
    } else {
      throw "No Data Found";
    }
  }
}
