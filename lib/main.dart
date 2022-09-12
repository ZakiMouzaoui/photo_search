import 'package:flutter/material.dart';
import 'package:photo_search/screens/home_screen.dart';


void main() {
  runApp(const PhotoSearchApp());
}

class PhotoSearchApp extends StatelessWidget {
  const PhotoSearchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Photo Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
