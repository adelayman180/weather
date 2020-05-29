import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class ResultPage extends StatelessWidget {
  final data;
  ResultPage(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/bg1.jpg'), fit: BoxFit.cover),
        ),
        child: SafeArea(
          minimum: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data['name'],
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Purisa',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                      '${formatDate(DateTime.now().toUtc().add(Duration(seconds: data['timezone'])), [
                    h,
                    ':',
                    nn,
                    ' ',
                    am,
                    ' - ',
                    DD,
                    ', ',
                    dd,
                    ' ',
                    M,
                    ' `',
                    yy
                  ])}'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data['main']['temp'].toInt().toString() + '°',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 3,
                        fontFamily: 'Sawasdee'),
                  ),
                  Row(
                    children: <Widget>[
                      Image.network(
                        'http://openweathermap.org/img/wn/${data['weather'][0]['icon']}@2x.png',
                        width: 80,
                      ),
                      Text(
                        data['weather'][0]['main'],
                        style: TextStyle(fontSize: 30, fontFamily: 'Sawasdee'),
                      ),
                    ],
                  ),
                  Divider(color: Colors.white70, indent: 30, endIndent: 30),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Columns('Min', data['main']['temp_min'].toInt()),
                  Container(color: Colors.white70, width: 1, height: 40),
                  Columns('Description', data['weather'][0]['description']),
                  Container(color: Colors.white70, width: 1, height: 40),
                  Columns('Max', data['main']['temp_max'].toInt()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Columns extends StatelessWidget {
  final String title;
  final text;
  Columns(this.title, this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(color: Colors.white70),
        ),
        SizedBox(height: 10),
        Text(
          text is String ? text : text.toString() + '°',
          style: TextStyle(fontSize: text is String ? 16 : 25),
        ),
      ],
    );
  }
}
