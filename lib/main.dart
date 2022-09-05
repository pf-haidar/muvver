import 'package:flutter/material.dart';
import 'package:muvver/views/home.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Muvver',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: Home(),
    ),
  );
}
