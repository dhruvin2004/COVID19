import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Variable
{
   static  TextEditingController countryController = TextEditingController();
   static  TextEditingController stateController = TextEditingController();
   static  TextEditingController cityController = TextEditingController();
   static final searchCountry = ValueNotifier<String>('');
   static final searchState = ValueNotifier<String>('');
   static String country = "india";

}


class FontStyle
{
   static var title = TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18);
   static var title2 = TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16);
   static var txt = TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16);
   static var dropdownstyle =TextStyle(
       color: Colors.white,
       fontWeight: FontWeight.bold,
       fontSize: 14);

}