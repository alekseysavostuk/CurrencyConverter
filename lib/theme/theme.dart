import 'package:flutter/material.dart';

final privateTheme = ThemeData(
  scaffoldBackgroundColor: const Color.fromARGB(255, 127, 127, 131),
  textTheme: TextTheme(
        bodyMedium: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20
        ),
        labelSmall: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 13
        ),
        headlineMedium: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 24,
        ),
  )
  
);