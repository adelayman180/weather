import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:loading/indicator/ball_grid_pulse_indicator.dart';
import 'package:loading/loading.dart';
import './result_page.dart';
import 'dart:convert';

class LoadingPage extends StatefulWidget {
  final String city;
  LoadingPage(this.city);
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  String url =
      'http://api.openweathermap.org/data/2.5/weather?appid=d14b8a19cf13b254db1c2840f7555fd1&units=metric&';
  @override
  void initState() {
    super.initState();
    widget.city == null ? getLocation() : getCity(widget.city);
  }

  void getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
    url += 'lat=${position.latitude}&lon=${position.longitude}';
    getData();
  }

  void getCity(String city) {
    url += 'q=$city';
    getData();
  }

  void getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => ResultPage(jsonDecode(response.body))));
    } else {
      Navigator.pop(context, 'error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Loading(
        indicator: BallGridPulseIndicator(),
        size: 70,
      ),
    );
  }
}
