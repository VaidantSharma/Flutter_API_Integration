import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:api_integration/API/dio_config.dart';
import 'package:api_integration/listing_Controller.dart';
import 'package:api_integration/API/rest_API/user screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    const MyApp())
  ;
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(context){
    return MaterialApp(
      title: 'Api Handling',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Api Handling"),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: const HomePage(),
      ),
    );
  }
}