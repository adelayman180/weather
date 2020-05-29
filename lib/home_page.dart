import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:geolocator/geolocator.dart';
import './loading_page.dart';

class HomePage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bg0.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'With city name',
                    style: TextStyle(
                      fontFamily: 'Purisa',
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _controller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(hintText: 'Enter city name'),
                  ),
                  SizedBox(height: 20),
                  FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: Border.all(width: 1, color: Colors.white),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_controller.text == null ||
                          _controller.text.trim().length < 4) {
                        showAlert(context, 'Check the city name');
                      } else
                        onClick(context, _controller.text);
                      _controller.clear();
                    },
                    child: Text('GO'),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    'With Location',
                    style: TextStyle(
                      fontFamily: 'Purisa',
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Open location service',
                      style: TextStyle(fontSize: 9),
                    ),
                  ),
                  FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: Border.all(width: 1, color: Colors.white),
                    onPressed: () async {
                      bool isconnect =
                          await Geolocator().isLocationServiceEnabled();
                      if (!isconnect)
                        showAlert(context, 'Turn on the location service');
                      else
                        onClick(context, null);
                    },
                    child: Text('GO'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void onClick(BuildContext ctx, String city) async {
    var connect = await Connectivity().checkConnectivity();
    if (connect == ConnectivityResult.none) {
      showAlert(ctx, 'Check your internet connection');
    } else {
      var e = await Navigator.push(
          ctx, MaterialPageRoute(builder: (_) => LoadingPage(city)));
      if (e == 'error') showAlert(ctx, 'An error occurred. please try again');
    }
  }

  void showAlert(BuildContext ctx, String text) {
    showDialog(
        context: ctx,
        builder: (_) => AlertDialog(
              content: Text(text),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text('Close'),
                ),
              ],
            ));
  }
}
