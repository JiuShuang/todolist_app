import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var barTextStyle=GoogleFonts.lato(
  textStyle: const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 24
  )
);

var todoCardTitleStyle=GoogleFonts.lato(
    textStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16
    )
);

var todoCardTipStyle=GoogleFonts.lato(
    textStyle: TextStyle(
        color: Colors.white10.withOpacity(0.5),
        fontWeight: FontWeight.bold,
        fontSize: 13
    )
);

var titleTextStyle=GoogleFonts.lato(
    textStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 23
    )
);

var taskTextStyle=GoogleFonts.lato(
    textStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16
    )
);

var taskColors=[
  Colors.deepPurple.shade200.withOpacity(0.8),
  Colors.pinkAccent.shade100.withOpacity(0.8),
  Colors.redAccent.shade200.withOpacity(0.8)
];
