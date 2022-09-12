import 'package:flutter/material.dart';
import 'package:photo_search/screens/result_screen.dart';

import '../utils/constants.dart';

import 'package:http/http.dart' as http;
import 'package:photo_search/utils/constants.dart';
import 'dart:convert';


class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final TextEditingController _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/Camera-Logo-Graphics-1-2.jpg",
              width: MediaQuery.of(context).size.width/3.76,
              height: MediaQuery.of(context).size.height/3.76,),
              SizedBox(height: MediaQuery.of(context).size.height/37.6),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: "Category Name",
                  hintText: "Search for an image...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/37.6,),
              GestureDetector(
                onTap: () async{
                  // Make api call to search images
                  if(_categoryController.text.trim().isNotEmpty){
                    Future<dynamic> objects = getPics(_categoryController.text);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ResultScreen(future: objects)));
                  }
                },
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue[200]
                    ),
                    child: const Center(
                      child: Text("Search",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<dynamic>> getPics(String query) async{
    http.Response response = await http.get(Uri.parse("https://pixabay.com/api/?key=$apiKey&q=$query&image_type=photo&pretty=true&per_page=20"));
    return json.decode(response.body)["hits"];

  }
}
