import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Variable
{
   static  TextEditingController countryController = TextEditingController();
   static  TextEditingController stateController = TextEditingController();
   static  TextEditingController cityController = TextEditingController();
}


class FontStyle
{
   static var title = GoogleFonts.lato(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18);
}