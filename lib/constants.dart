import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyle(double fSize, Color fColor, FontWeight fWeight){
  return GoogleFonts.montserrat(
    fontSize: fSize,
    color: fColor,
    fontWeight: fWeight,
  );
}

Color textColor = Color(0xffA69CB7);

CollectionReference<Map<String,dynamic>> userCollection =
    FirebaseFirestore.instance.collection('users');